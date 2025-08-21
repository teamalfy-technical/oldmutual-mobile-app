import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PAuthLinkButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final double fontSize;
  final Color? subtitleColor;
  final Function()? onTap;
  const PAuthLinkButton({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.fontSize = PAppSize.s14,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Color(0xFFCCCCCC),
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: subtitle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: subtitleColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
