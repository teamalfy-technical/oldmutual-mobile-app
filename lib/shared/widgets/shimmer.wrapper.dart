import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: PAppColor.greyColor.withValues(alpha: PAppSize.s0_2),
        highlightColor: PAppColor.greyColor.withValues(alpha: PAppSize.s0_1),
      ),
      child: child,
    );
  }
}
