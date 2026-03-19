import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/shared/widgets/shimmer.wrapper.dart';

class PShimmerListView<T> extends StatelessWidget {
  final bool loading;
  final List<T> items;
  final T placeholderItem;
  final int placeholderCount;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  const PShimmerListView({
    super.key,
    required this.loading,
    required this.items,
    required this.placeholderItem,
    required this.itemBuilder,
    this.placeholderCount = 10,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = true,
    this.physics,
    this.scrollController,
    this.padding,
    required this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveItems = loading
        ? List.generate(placeholderCount, (_) => placeholderItem)
        : items;

    return PShimmerWrapper(
      loading: loading,
      child: ListView.separated(
        separatorBuilder: separatorBuilder,
        shrinkWrap: shrinkWrap,
        itemCount: effectiveItems.length,
        scrollDirection: scrollDirection,
        physics: physics,
        controller: scrollController,
        padding: padding,
        itemBuilder: (context, index) {
          return itemBuilder(context, index, effectiveItems[index]);
        },
      ),
    );
  }
}
