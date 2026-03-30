import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCategoryPills extends StatelessWidget {
  const PCategoryPills({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);
    return SizedBox(
      height: PAppSize.s50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => PAppSize.s12.horizontalSpace,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: _buildPill(context, index, isSelected, isDarkMode),
          );
        },
      ),
    );
  }

  static const _gradient = LinearGradient(
    colors: [PAppColor.primaryDark, PAppColor.primary],
  );

  Widget _buildPill(
    BuildContext context,
    int index,
    bool isSelected,
    bool isDarkMode,
  ) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: isSelected
          ? PAppColor.whiteColor
          : isDarkMode
          ? PAppColor.whiteColor
          : PAppColor.primary,
      fontWeight: FontWeight.w600,
    );

    final child = Center(child: Text(categories[index], style: textStyle));

    // Dark mode: solid colors, no gradient
    if (isDarkMode) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s28,
          vertical: PAppSize.s8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? PAppColor.cardDarkColor : Colors.transparent,
          borderRadius: BorderRadius.circular(PAppSize.s24),
          border: Border.all(
            color: isSelected
                ? PAppColor.cardDarkColor
                : PAppColor.fillColor4.withOpacityExt(PAppSize.s0_4),
            width: PAppSize.s1,
          ),
        ),
        child: child,
      );
    }

    // Light mode selected: gradient background
    if (isSelected) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s28,
          vertical: PAppSize.s8,
        ),
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: BorderRadius.circular(PAppSize.s24),
        ),
        child: child,
      );
    }

    // Light mode unselected: gradient border
    return Container(
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(PAppSize.s24),
      ),
      padding: EdgeInsets.all(PAppSize.s1),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s28 - PAppSize.s1,
          vertical: PAppSize.s8 - PAppSize.s1,
        ),
        decoration: BoxDecoration(
          color: PAppColor.fillColor,
          borderRadius: BorderRadius.circular(PAppSize.s24 - PAppSize.s1),
        ),
        child: child,
      ),
    );
  }
}
