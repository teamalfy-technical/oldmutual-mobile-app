import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/features/webview/webview.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:redacted/redacted.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PWebView extends StatefulWidget {
  final String? title;
  final String? url;
  const PWebView({super.key, this.url, this.title});

  @override
  State<PWebView> createState() => _PWebViewState();
}

class _PWebViewState extends State<PWebView> {
  var percentageProgress = 0;

  bool _loading = false;

  WebViewController _controller = WebViewController();
  late final PlatformWebViewControllerCreationParams params;

  // Updating loading state
  void setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  // Updating loading state
  void updateProgressPercentage(value) {
    setState(() {
      percentageProgress = value;
    });
    log('Loading Page (progress : $percentageProgress%)');
  }

  @override
  void initState() {
    super.initState();
    log(widget.url ?? '');
    initializeWebController();
  }

  void initializeWebController() {
    params = WebViewPlatform.instance is WebKitWebViewPlatform
        ? WebKitWebViewControllerCreationParams(
            allowsInlineMediaPlayback: true,
            mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
          )
        : const PlatformWebViewControllerCreationParams();

    _controller =
        WebViewController.fromPlatformCreationParams(
            params,
            onPermissionRequest: (request) {
              request.grant();
            },
          )
          // _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..enableZoom(false)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                updateProgressPercentage(progress);
              },
              onPageStarted: (String url) {
                setLoading(true);
                updateProgressPercentage(0);
                log('Page started loading: $url');
              },
              onPageFinished: (String url) async {
                setLoading(false);
                updateProgressPercentage(100);
                log('Page is done loading: $url');
                checkCallBackResponse();
                //checkVerificationStatus(context);
              },
              onWebResourceError: (WebResourceError error) {
                log(
                  'An error occurred whiles loading url: ${error.description}',
                );
                initializeWebController(); // initialize & reload url
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(widget.url ?? PAppConstant.termsConditionsLink),
          );

    _controller.addJavaScriptChannel(
      'FlutterChannel',
      onMessageReceived: (JavaScriptMessage message) {
        pensionAppLogger.e("📩 Message from JS: ${message.message}");
      },
    );
  }

  // Future<void> checkVerificationStatus(context) async {
  // final vm = Get.find<PAuthVm>();
  // final checker = ApiStatusChecker(
  //   sessionId: vm.verificationRes.value.sessionId ?? '',
  // );

  // checker.statusStream.listen((success) {
  //   if (success) {
  //     pensionAppLogger.e(success);
  //   }
  //   print(success ? "API is UP ✅" : "API is DOWN ❌");
  // });

  // checker.start(context);
  // }

  Future<void> checkCallBackResponse() async {
    try {
      // Get the page content
      final result = await _controller.runJavaScriptReturningResult(
        "document.body.innerText",
      );

      // Handle different return types from runJavaScriptReturningResult
      String pageContent;
      if (result is String) {
        pageContent = result;
      } else if (result is Map) {
        // If already a Map, convert to JSON string first
        pageContent = jsonEncode(result);
      } else {
        pageContent = result.toString();
      }

      pensionAppLogger.d("📄 Page Content: $pageContent");

      // Try to parse the content - it might be double-encoded JSON string
      dynamic json;
      try {
        // First decode (removes outer string quotes if present)
        final firstDecode = jsonDecode(pageContent);
        // Check if result is still a string (double-encoded)
        if (firstDecode is String) {
          json = jsonDecode(firstDecode);
        } else {
          json = firstDecode;
        }
      } catch (_) {
        // If first approach fails, try direct decode
        json = jsonDecode(pageContent);
      }

      if (json is Map<String, dynamic> &&
          json.containsKey('data') &&
          json['data'].containsKey('verification_token')) {
        pensionAppLogger.d("✅ Verification Token Found");
      }

      if (json is Map<String, dynamic> &&
          json.containsKey('data') &&
          json['data'].containsKey('verification_token')) {
        Get.find<PAuthVm>().verificationToken(
          json['data']['verification_token'],
        );
        pensionAppLogger.e(Get.find<PAuthVm>().verificationToken);
        pensionAppLogger.d(
          "✅ Token: ${json['data']['verification_token']}, Ghana Card: ${json['data']['ghana_card']}",
        );
        navigateToCreateAccount(json['data']['message']);
      } else if (json is Map<String, dynamic> &&
          json.containsKey('data') &&
          json['data'].containsKey('message')) {
        Get.find<PPaymentVm>().navigateToSuccessPage();
      }
    } catch (e) {
      pensionAppLogger.e("❌ Not valid JSON: $e");
    }
  }

  void navigateToCreateAccount(String message) {
    PHelperFunction.switchScreen(
      destination: Routes.createAccountPage,
      popAndPush: true,
      args: true,
    );
    PPopupDialog(context).successMessage(title: 'success'.tr, message: message);
  }

  @override
  Widget build(BuildContext context) {
    // PHelperFunction.setStatusBarColorForIOS(context);
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.blackColor
          : PAppColor.whiteColor,
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: SafeArea(
        bottom: false,
        child:
            (Platform.isIOS && percentageProgress < 100) ||
                (Platform.isAndroid && _loading)
            //  percentageProgress < 100
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: const RedactedWidget().redacted(
                      context: context,
                      redact: true,
                    ),
                  );
                },
              )
            : WebViewWidget(controller: _controller),

        // Platform.isIOS
        //     ? percentageProgress < 100
        //         ? ListView.builder(
        //             itemCount: 10,
        //             itemBuilder: (context, index) {
        //               return Padding(
        //                 padding: const EdgeInsets.only(
        //                     top: 8.0, left: 8.0, right: 8.0),
        //                 child: const RedactedWidget().redacted(
        //                   context: context,
        //                   redact: true,
        //                 ),
        //               );
        //             })
        //         : WebViewWidget(controller: _controller)
        //     : Column(
        //         children: [
        //           if (percentageProgress < 100)
        //             LinearProgressIndicator(
        //               color: Colors.white,
        //               backgroundColor: GHelperFunction.isDarkMode(context)
        //                   ? GAppColor.blackColor
        //                   : GAppColor.primaryDark,
        //               value: percentageProgress / 100,
        //             ),
        //           Expanded(
        //             child: WebViewWidget(controller: _controller),
        //           ),
        //         ],
        //       ),
      ),
    );
  }
}
