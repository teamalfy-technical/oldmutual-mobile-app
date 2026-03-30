import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PBadgeWidget extends StatelessWidget {
  const PBadgeWidget({super.key, required this.child, this.showBadge = true});
  final Widget child;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -4, end: -3),
      showBadge: showBadge,
      badgeStyle: badges.BadgeStyle(
        badgeColor: PAppColor.badgeColor,
        padding: EdgeInsets.all(PAppSize.s4),
      ),
      child: child,
    );
  }
}
