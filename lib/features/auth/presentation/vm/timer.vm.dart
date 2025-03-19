import 'dart:async';

import 'package:get/get.dart';

class PTimerVm extends GetxController {
  RxInt seconds = 59.obs;
  Timer? _timer;
  var completed = false.obs;

  void startCountdown() {
    _timer?.cancel(); // Ensure previous timer is cancelled
    seconds.value = 59;

    completed.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
        onCountdownFinished();
      }
    });
  }

  void onCountdownFinished() {
    completed.value = true;
    // 👇 Trigger your event here
    print("Countdown complete");
    // Example: You could update a state, navigate, or call another function
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
