import 'dart:async';

import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';

class PInactivityService extends GetxService {
  static PInactivityService get instance => Get.find();
  static const Duration timeoutDuration = Duration(hours: 1);
  Timer? _inactivityTimer;
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(timeoutDuration, _handleInactivity);
  }

  void resetTimer() {
    _startTimer();
  }

  void _handleInactivity() {
    // You can show a dialog or directly log out
    logoutUser();
  }

  void logoutUser() {
    Get.put(PSettingsVm()).signout();
    // Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    _inactivityTimer?.cancel();
    super.onClose();
  }
}
