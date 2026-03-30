import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PAnimatedGridView extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final Duration animationDuration;
  final AnimateType animateType;

  const PAnimatedGridView({
    super.key,
    required this.children,
    required this.crossAxisCount,
    this.shrinkWrap = false,
    this.physics,
    this.mainAxisSpacing = PAppSize.s0,
    this.crossAxisSpacing = PAppSize.s0,
    this.childAspectRatio = PAppSize.s1,
    this.animateType = AnimateType.scaleOut,
    this.padding,
    this.animationDuration = const Duration(milliseconds: PAppSize.s700),
  });

  @override
  Widget build(BuildContext context) {
    return animateType == AnimateType.scaleIn ||
            animateType == AnimateType.scaleOut
        ? AnimationLimiter(
            child: GridView.count(
              shrinkWrap: shrinkWrap,
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: childAspectRatio,
              padding: padding,
              physics: physics,
              children: List.generate(children.length, (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: animationDuration,
                  columnCount: crossAxisCount,
                  child: ScaleAnimation(
                    child: FadeInAnimation(child: children[index]),
                  ),
                );
              }),
            ),
          )
        : AnimationLimiter(
            child: GridView.count(
              shrinkWrap: shrinkWrap,
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: childAspectRatio,
              padding: padding,
              physics: physics,
              children: List.generate(children.length, (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: animationDuration,
                  columnCount: crossAxisCount,
                  child: SlideAnimation(
                    verticalOffset: PAppSize.s50,
                    child: FadeInAnimation(child: children[index]),
                  ),
                );
              }),
            ),
          );
  }
}
