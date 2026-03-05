import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/enums/app.enums.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class ApiStatusChecker {
  final String sessionId;
  final Duration interval;
  Timer? _timer;

  // Stream to broadcast status updates
  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get statusStream => _controller.stream;

  ApiStatusChecker({
    required this.sessionId,
    this.interval = const Duration(seconds: 10),
  });

  void start(BuildContext context) {
    // Avoid starting multiple timers
    stop();

    _timer = Timer.periodic(interval, (_) async {
      final res = await authService.checkCardVerificationStatus(
        sessionId: sessionId,
      );
      res.fold(
        (err) {
          _controller.add(false);
          PPopupDialog(
            context,
          ).errorMessage(title: err.title ?? 'error'.tr, message: err.getMessage());
        },
        (res) {
          if (res.data == LoadingState.completed.name) {
            _controller.add(true);
            dispose();
          } else {
            _controller.add(false);
          }
        },
      );
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
    _controller.close();
  }
}
