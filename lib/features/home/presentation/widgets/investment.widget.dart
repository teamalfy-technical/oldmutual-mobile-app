import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class InvestmentWidget extends StatelessWidget {
  const InvestmentWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.subTitleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style:
              titleStyle ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          softWrap: true,
          style:
              subTitleStyle ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s15,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
