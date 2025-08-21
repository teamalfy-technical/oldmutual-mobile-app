import 'dart:async';

import 'package:get/get.dart';

class PTimerVm extends GetxController {
  RxInt secondsRemaining = 120.obs;
  Timer? _timer;
  var completed = false.obs;

  void startCountdown() {
    _timer?.cancel(); // Ensure previous timer is cancelled
    secondsRemaining.value = 59;

    completed.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
        onCountdownFinished();
      }
    });
  }

  // String get formattedTime {
  //   int minutes = secondsRemaining.value ~/ 60;
  //   int seconds = secondsRemaining.value % 60;
  //   return "$minutes:${seconds.toString().padLeft(2, '0')}";
  // }

  String get formattedTime {
    int seconds = secondsRemaining.value % 60;
    return seconds.toString().padLeft(2, '0');
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
