import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

final CatchApiErrorWrapper catchApiErrorWrapper = Get.put(
  CatchApiErrorWrapperImpl(),
);

abstract class CatchApiErrorWrapper {
  dynamic handleError({dynamic err, dynamic stackTrace});
}

// @LazySingleton(as: CatchApiErrorWrapper)
class CatchApiErrorWrapperImpl implements CatchApiErrorWrapper {
  /// Check if the user is currently on an auth-related route (i.e. logged out).
  /// Used to suppress error popups from stale API calls after logout.
  bool _isOnAuthRoute() {
    final currentRoute = Get.currentRoute;
    return currentRoute == Routes.loginPage ||
        currentRoute == Routes.welcomeBackPage ||
        currentRoute == Routes.splashPage ||
        currentRoute == Routes.createAccountPage ||
        currentRoute == Routes.idEntryPage ||
        currentRoute == Routes.livenessInfoPage ||
        currentRoute == Routes.verifyOTPPage ||
        currentRoute == Routes.forgotPasswordPage;
  }

  @override
  dynamic handleError({err, stackTrace}) {
    pensionAppLogger.e('Error: ${err.toString()}');

    String? errorMessage = '';
    String? errorTitle;
    // if (err.runtimeType != NoInternetException) {
    //   unawaited(FirebaseCrashlytics.instance.recordError(err, stackTrace));
    // }
    if (err is DioException) {
      debugPrint('DioException caught-----------');
      if (err.response != null) {
        FirebaseCrashlytics.instance.recordError(
          err.response?.data,
          StackTrace.current,
        );
        final statusCode = err.response!.statusCode ?? 0;

        // Suppress 401 errors when user is already on an auth route (logged out).
        // This prevents stale in-flight API calls from showing error popups
        // after the user has already been navigated away from authenticated pages.
        if (statusCode == 401 && _isOnAuthRoute()) {
          pensionAppLogger.w(
            '401 suppressed on auth route: ${Get.currentRoute}',
          );
          return PFailure(message: '', silent: true);
        }

        // Handle 5xx server errors explicitly
        if (statusCode >= 500) {
          pensionAppLogger.e('Server error $statusCode: ${err.response?.data}');
          errorTitle = 'server_error_title'.tr;
          errorMessage = 'error_occurred_msg'.tr;
        } else if (err.response?.data['status'] == 'error' &&
            statusCode == 200) {
          errorMessage = err.response!.data['data'];
        } else if (statusCode == 400) {
          errorMessage = extractError(err.response?.data);
        } else if (statusCode == 401) {
          errorMessage = err.response?.data['error'] ?? 'Unauthorized request';
          pensionAppLogger.e(err.response?.data);
        } else if (statusCode == 403) {
          if (Get.currentRoute != Routes.loginPage) {
            errorMessage =
                err.response?.data['message'] ??
                err.response?.data['data']['error'] ??
                'Forbidden Access';
          } else {
            errorMessage =
                err.response?.data['message'] ??
                err.response?.data['data']['error'] ??
                'Forbidden Access';
          }
          pensionAppLogger.e(err.response?.data);
        } else if (statusCode == 404) {
          pensionAppLogger.e(err.response?.data);
          errorMessage = extractError(err.response?.data);
        } else if (statusCode == 422) {
          pensionAppLogger.e(err.response?.data);
          errorMessage = err.response?.data['message'] ?? 'Bad request';
        } else if (statusCode == 429) {
          if (Get.currentRoute != Routes.loginPage) {
            // Get.put(PSettingsVm()).signout(soft: true);
          }
          pensionAppLogger.e(err.response?.data);
          errorMessage = extractError(err.response?.data);
        } else if (statusCode == 412) {
          errorMessage = extractError(err.response?.data);
        } else if (err.response?.data is Map &&
            err.response!.data.containsKey('data')) {
          final error = err.response!.data['data'];
          if (error is List) {
            List<String> messages = error.cast<String>();
            errorMessage = messages.first.toString();
          } else if (error is String) {
            errorMessage = error;
          }
        }
      } else {
        errorMessage = ServerException.getErrorMessage(err);
      }
      return PFailure(
        message: errorMessage ?? 'error_occurred_msg'.tr,
        title: errorTitle,
      );
    } else {
      return UnknownFailure();
    }
  }

  String extractError(Map<String, dynamic> response) {
    pensionAppLogger.e(response);
    if (response.containsKey("data")) {
      for (var entry in response["data"].entries) {
        if (entry.value is List && entry.value.isNotEmpty) {
          return entry.value.first; // Return the first error message found
        }
        if (entry.value is String && entry.value.isNotEmpty) {
          return entry.value; // Return the error message found
        }
      }
    } else if (response.containsKey("error")) {
      return response['error'];
    } else if (response.containsKey("message")) {
      final message = response['message'];
      if (message is Map) {
        return message['message'] ?? "Bad Request";
      } else if (message is String) {
        return message;
      }
    } else {
      for (var entry in response.entries) {
        if (entry.value is List && entry.value.isNotEmpty) {
          return entry.value.first; // Return the first error message found
        }
      }
    }
    return "Bad Request"; // Return an empty string if no error is found
  }
}
