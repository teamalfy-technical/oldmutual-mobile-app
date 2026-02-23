import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PFinancialInsightDetailPage extends StatefulWidget {
  final Content content;
  const PFinancialInsightDetailPage({super.key, required this.content});

  @override
  State<PFinancialInsightDetailPage> createState() =>
      _PFinancialInsightDetailPageState();
}

class _PFinancialInsightDetailPageState
    extends State<PFinancialInsightDetailPage> {
  late WebViewController _webViewController;
  bool get isVideo => widget.content.contentType != 'article';

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _initializeWebView();
    }
  }

  void _initializeWebView() {
    final videoUrl = widget.content.mediaUrl ?? '';
    final embedUrl = _convertToEmbedUrl(videoUrl);

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(embedUrl));
  }

  String _convertToEmbedUrl(String url) {
    // Convert YouTube watch URL to embed URL
    if (url.contains('youtube.com/watch')) {
      final uri = Uri.parse(url);
      final videoId = uri.queryParameters['v'];
      if (videoId != null) {
        return 'https://www.youtube.com/embed/$videoId';
      }
    } else if (url.contains('youtu.be/')) {
      final videoId = url.split('youtu.be/').last.split('?').first;
      return 'https://www.youtube.com/embed/$videoId';
    }
    return url;
  }

  Widget _buildStyledDescription(BuildContext context, String description) {
    final lines = description.split('\n');
    final List<TextSpan> spans = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Check if line is a heading (not empty, doesn't start with bullet, and is relatively short)
      final isHeading =
          line.isNotEmpty &&
          !line.startsWith('•') &&
          !line.startsWith('-') &&
          line.length < 50 &&
          !line.contains(':') &&
          (i == 0 ||
              lines[i - 1].isEmpty ||
              (i < lines.length - 1 && lines[i + 1].isEmpty));

      // Check if line is a section title (ends with colon)
      final isSectionTitle =
          line.isNotEmpty && line.endsWith(':') && line.length < 50;

      if (isHeading || isSectionTitle) {
        spans.add(
          TextSpan(
            text: '$line\n',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s16,
              fontWeight: FontWeight.w700,
              height: 2.0,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$line\n',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s15,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.content;
    final contentType = content.contentType?.capitalizeFirst ?? '';
    final duration = content.duration ?? '6 mins';
    final currentDate = DateFormat('MMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Text(content.title ?? ''),
        actions: [
          IconButton(
            onPressed: () {
              if (content.id != null) {
                PAffluentVm.instance.bookmarkContent(id: content.id!);
              }
            },
            icon: Assets.icons.bookmarkIcon.svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.blackColor,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meta Info Row (Type, Duration, Date)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaInfoItem(
                icon: Assets.icons.bookIcon.svg(
                  width: PAppSize.s16,
                  height: PAppSize.s16,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor
                      : PAppColor.darkBgColor,
                ),
                value: contentType,
              ),
              PAppSize.s8.verticalSpace,
              _MetaInfoItem(
                icon: Assets.icons.calendarIcon.svg(
                  width: PAppSize.s16,
                  height: PAppSize.s16,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor
                      : PAppColor.darkBgColor,
                ),
                value: currentDate,
              ),
              PAppSize.s8.verticalSpace,
              _MetaInfoItem(
                icon: Assets.icons.clockIcon.svg(
                  width: PAppSize.s16,
                  height: PAppSize.s16,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor
                      : PAppColor.darkBgColor,
                ),
                value: duration,
              ),
            ],
          ),

          PAppSize.s24.verticalSpace,

          // Content based on type
          if (isVideo) ...[
            // Video Player
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PAppSize.s12),
                color: PAppColor.blackColor,
              ),
              clipBehavior: Clip.hardEdge,
              child: WebViewWidget(controller: _webViewController),
            ),
            PAppSize.s24.verticalSpace,
          ],

          // Long Description with styled headings
          _buildStyledDescription(context, content.content ?? ''),
        ],
      ).all(PAppSize.s20).scrollable(),
    );
  }
}

class _MetaInfoItem extends StatelessWidget {
  const _MetaInfoItem({required this.icon, required this.value});

  final Widget icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        PAppSize.s8.horizontalSpace,
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: PAppSize.s13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
