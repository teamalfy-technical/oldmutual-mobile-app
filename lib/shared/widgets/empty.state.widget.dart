import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PEmptyStateWidget extends StatelessWidget {
  final Widget? icon;
  final String message;
  final double size;
  const PEmptyStateWidget({
    super.key,
    this.icon,
    required this.message,
    this.size = PAppSize.s160,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedColumnWidget(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Assets.lotties.noRecord.lottie(repeat: false, height: size),
          PAppSize.s8.verticalSpace,
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ).symmetric(horizontal: PAppSize.s30),
        ],
      ).scrollable(physics: const AlwaysScrollableScrollPhysics()),
    );
  }
}
