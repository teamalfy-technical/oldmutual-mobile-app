import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

class PInactivityWrapper extends StatelessWidget {
  final Widget child;
  const PInactivityWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        Get.find<PInactivityService>().resetTimer();
      },
      child: child,
    );
  }
}
