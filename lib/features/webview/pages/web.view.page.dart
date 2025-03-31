import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/webview/webview.dart';
import 'package:redacted/redacted.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    _controller =
        WebViewController()
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
              onPageFinished: (String url) {
                setLoading(false);
                updateProgressPercentage(100);
                log('Page is done loading: $url');
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
  }

  @override
  Widget build(BuildContext context) {
    // PHelperFunction.setStatusBarColorForIOS(context);
    return Scaffold(
      backgroundColor:
          PHelperFunction.isDarkMode(context)
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
