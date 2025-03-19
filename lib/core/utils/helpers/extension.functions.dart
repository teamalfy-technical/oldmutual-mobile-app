import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// extensions on any [Widget]
extension AppWidgetExtension on Widget {
  Widget horizontal(double spacing) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: spacing), child: this);

  Widget vertical(double spacing) =>
      Padding(padding: EdgeInsets.symmetric(vertical: spacing), child: this);

  Widget bottom(double spacing) =>
      Padding(padding: EdgeInsets.only(bottom: spacing), child: this);

  Widget top(double spacing) =>
      Padding(padding: EdgeInsets.only(top: spacing), child: this);

  Widget left(double spacing) =>
      Padding(padding: EdgeInsets.only(left: spacing), child: this);

  Widget right(double spacing) =>
      Padding(padding: EdgeInsets.only(right: spacing), child: this);

  Widget all(double spacing) =>
      Padding(padding: EdgeInsets.all(spacing), child: this);

  // Decoration boxDecoration({Color? color, bool showBorder = false}) =>
  //     BoxDecoration(
  //       color: color,
  //       border: Border.all(
  //           width: showBorder ? TAppSize.s1 : TAppSize.s0,
  //           color: showBorder ? TAppColor.text300 : TAppColor.transparentColor),
  //       borderRadius: BorderRadius.circular(TAppSize.s8),
  //     );

  Widget symmetric({double vertical = 0.0, double horizontal = 0.0}) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    child: this,
  );
  Widget only({
    double top = 0.0,
    double bottom = 0.0,
    double left = 0.0,
    double right = 0.0,
  }) => Padding(
    padding: EdgeInsets.only(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    ),
    child: this,
  );

  Widget onPressed({
    required Function()? onTap,
    Function()? onDoubleTap,
    Function()? onLongTap,
    BorderRadius? radius,
    Color? overlayColor,
    Color? color,
    InteractiveInkFeatureFactory? splashFactory,
  }) => InkWell(
    onTap: onTap,
    onDoubleTap: onDoubleTap,
    onLongPress: onLongTap,
    borderRadius: radius,
    splashFactory: splashFactory ?? InkSplash.splashFactory,
    splashColor: color,
    child: this,
  );

  Widget hero({required Object tag}) => Hero(
    tag: tag,
    child: Material(color: PAppColor.transparentColor, child: this),
  );
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);
  Widget centered() => Center(child: this);
  Widget scrollable({
    Axis scrollDirection = Axis.vertical,
    ScrollPhysics physics = const BouncingScrollPhysics(),
  }) => SingleChildScrollView(
    scrollDirection: scrollDirection,
    physics: physics,
    child: this,
  );
}

extension SvgExtension on String {
  Widget svg({
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}

extension NumericChecker on String {
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
}

extension ColorwithOpacityExt on Color {
  Color withOpacityExt(val) {
    return withValues(alpha: val);
  }
}

/// Return expiry date option
extension ExpiryDateChecker on int {
  String? getExpiryDate({int? year, int? month, int? day}) {
    switch (this) {
      case 0:
        // return null;
        return DateTime.fromMicrosecondsSinceEpoch(
          0,
        ).add(const Duration(days: 100000)).toIso8601String();
      case 1:
        return DateTime.now().add(const Duration(days: 30)).toIso8601String();
      case 2:
        return DateTime.now().add(const Duration(days: 60)).toIso8601String();
      case 3:
        return DateTime(year!, month!, day!).toIso8601String();
      default:
        return null;
    }
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}

extension StringExtension on String {
  String displayTimeAgoFromTimestamp() {
    final year = int.parse(substring(0, 4));
    final month = int.parse(substring(5, 7));
    final day = int.parse(substring(8, 10));
    final hour = int.parse(substring(11, 13));
    final minute = int.parse(substring(14, 16));

    final DateTime postDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(postDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    final diffInSeconds = DateTime.now().difference(postDate).inSeconds;
    if (diffInSeconds > 1 && diffInSeconds < 60) {
      timeValue = diffInSeconds;
      timeUnit = 'second';
    } else if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(postDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = '$timeValue $timeUnit';
    timeAgo += timeValue > 1 ? 's' : '';

    return '$timeAgo ago';
  }
}
