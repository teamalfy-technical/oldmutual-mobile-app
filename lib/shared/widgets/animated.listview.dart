import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PAnimatedListView<T> extends StatelessWidget {
  final Widget Function(int index, T item) itemBuilder;
  final int duration;
  final List<T> items;
  final bool shrinkWrap;
  final bool animate;
  final ScrollPhysics physics;
  final ScrollController? scrollController;
  final Widget Function(BuildContext, int) separatorBuilder;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final AnimateType animateType;
  const PAnimatedListView({
    super.key,
    required this.itemBuilder,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.duration = PAppSize.s700,
    this.shrinkWrap = false,
    this.animate = true,
    required this.items,
    this.physics = const BouncingScrollPhysics(),
    this.animateType = AnimateType.slideUp,
    required this.separatorBuilder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return animate
        ? animateType == AnimateType.slideUp
              ? AnimationLimiter(
                  child: ListView.separated(
                    separatorBuilder: separatorBuilder,
                    itemCount: items.length,
                    shrinkWrap: shrinkWrap,
                    controller: scrollController,
                    scrollDirection: scrollDirection,
                    physics: physics,
                    padding: padding,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: duration),
                        child: SlideAnimation(
                          verticalOffset: PAppSize.s50,
                          child: FadeInAnimation(
                            child: itemBuilder(index, items[index]),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : AnimationLimiter(
                  child: ListView.separated(
                    separatorBuilder: separatorBuilder,
                    itemCount: items.length,
                    shrinkWrap: shrinkWrap,
                    controller: scrollController,
                    scrollDirection: scrollDirection,
                    physics: physics,
                    padding: padding,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: duration),
                        child: SlideAnimation(
                          horizontalOffset: PAppSize.s50,
                          child: FadeInAnimation(
                            child: itemBuilder(index, items[index]),
                          ),
                        ),
                      );
                    },
                  ),
                )
        : ListView.separated(
            separatorBuilder: (context, index) => PAppSize.s16.verticalSpace,
            itemCount: items.length,
            shrinkWrap: shrinkWrap,
            controller: scrollController,
            physics: physics,
            padding: padding,
            itemBuilder: (BuildContext context, int index) =>
                itemBuilder(index, items[index]),
          );
  }
}
