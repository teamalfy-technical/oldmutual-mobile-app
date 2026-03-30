import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A reusable skeleton loading wrapper powered by Skeletonizer.
/// Automatically generates skeleton layouts from the child widget tree.
class PShimmerWrapper extends StatelessWidget {
  final bool loading;
  final Widget child;

  const PShimmerWrapper({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: loading,
      effect: ShimmerEffect(
        baseColor: PAppColor.coolGrey.withOpacityExt(PAppSize.s0_2),
        highlightColor: PAppColor.coolGrey.withOpacityExt(PAppSize.s0_1),
      ),
      child: child,
    );
  }
}

/// A skeleton-friendly placeholder box.
/// Uses Skeletonizer's Bone widget to render proper shimmer bones.
class PShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final BoxShape shape;

  const PShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Bone(
      width: width,
      height: height,
      shape: shape,
      borderRadius: shape == BoxShape.rectangle
          ? BorderRadius.circular(borderRadius)
          : null,
    );
  }
}
