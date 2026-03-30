import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSettingsSuccessPage extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonTitle;
  final Function()? onTap;
  const PSettingsSuccessPage({
    super.key,
    required this.message,
    required this.title,
    this.onTap,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: null, leading: SizedBox.shrink()),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
                width: double.infinity,
                child: Column(
                  children: [
                    PAppSize.s30.verticalSpace,
                    const PAnimatedCheckmark(),
                    PAppSize.s30.verticalSpace,
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w700,

                            color: PHelperFunction.isDarkMode(context)
                                ? PAppColor.primary950
                                : PAppColor.textColorDark,
                            fontSize: PAppSize.s24,
                          ),
                    ),
                    PAppSize.s12.verticalSpace,
                    _buildRichText(
                      context,
                      title,
                      baseStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: PAppSize.s16,
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor.withOpacityExt(PAppSize.s0_7)
                            : PAppColor.textColorLight,
                      ),
                    ),

                    PAppSize.s20.verticalSpace,
                  ],
                ).symmetric(horizontal: PAppSize.s20),
              ),

              Expanded(child: Container()),

              // PAppSize.s18.verticalSpace,
              Container(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s18,
                ),
                child: PGradientButton(
                  label: buttonTitle ?? 'done'.tr,
                  textColor: PAppColor.whiteColor,
                  showIcon: false,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a RichText widget that parses **bold** markers
  Widget _buildRichText(BuildContext context, String text, {TextStyle? baseStyle}) {
    final List<TextSpan> spans = [];
    final RegExp boldPattern = RegExp(r'\*\*(.+?)\*\*');
    int lastEnd = 0;

    for (final match in boldPattern.allMatches(text)) {
      // Add text before the match
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      // Add the bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: baseStyle?.copyWith(fontWeight: FontWeight.w700),
      ));
      lastEnd = match.end;
    }

    // Add remaining text after last match
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    // If no bold markers found, return simple text
    if (spans.isEmpty) {
      spans.add(TextSpan(text: text, style: baseStyle));
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }
}
