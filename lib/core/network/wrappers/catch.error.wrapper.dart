import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

final CatchApiErrorWrapper catchApiErrorWrapper = Get.put(
  CatchApiErrorWrapperImpl(),
);

abstract class CatchApiErrorWrapper {
  dynamic handleError({dynamic err, dynamic stackTrace});
}

// @LazySingleton(as: CatchApiErrorWrapper)
class CatchApiErrorWrapperImpl implements CatchApiErrorWrapper {
  @override
  dynamic handleError({err, stackTrace}) {
    pensionAppLogger.e('Error: ${err.toString()}');

    String? errorMessage = '';
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
        if (err.response!.statusCode != 500) {
          if (err.response?.data['status'] == 'error' &&
              err.response?.statusCode == 200) {
            errorMessage = err.response!.data['data'];
          } else if (err.response?.statusCode == 400) {
            errorMessage = extractError(err.response?.data);
            //errorMessage = err.response?.data['error'];
          } else if (err.response?.statusCode == 401) {
            if (Get.currentRoute != Routes.loginPage) {
              Get.put(PSettingsVm()).signout();
            }
            errorMessage =
                err.response?.data['error'] ?? 'Unauthorized request';
            pensionAppLogger.e(err.response?.data);
          } else if (err.response?.statusCode == 403) {
            if (Get.currentRoute != Routes.loginPage) {
              Get.put(PSettingsVm()).signout();
            } else {
              errorMessage =
                  err.response?.data['message'] ?? 'Forbidden Access';
            }
            pensionAppLogger.e(err.response?.data);
          } else if (err.response?.statusCode == 404) {
            errorMessage =
                err.response?.data['message'] ??
                'Requested resource is not found';
          } else if (err.response?.statusCode == 422) {
            // ApiErrorResponse error =
            //     ApiErrorResponse.fromJson(err.response?.data);
            pensionAppLogger.e(err.response?.data);
            errorMessage = err.response?.data['message'] ?? 'Bad request';
          } else if (err.response?.statusCode == 429) {
            if (Get.currentRoute != Routes.loginPage) {
              Get.put(PSettingsVm()).signout();
            }
            // ApiErrorResponse error =
            //     ApiErrorResponse.fromJson(err.response?.data);
            pensionAppLogger.e(err.response?.data);
            // errorMessage = err.response?.data['message'] ?? 'Bad request';
          } else if (err.response?.data is Map &&
              err.response!.data.containsKey('data')) {
            final error = err.response!.data['data'];
            // final error = errorMessageFromJson(e.response!.data.toString()).message;
            // Check the type of message and handle accordingly
            if (error is List) {
              List<String> messages = error.cast<String>();
              errorMessage = messages.first.toString();
              // Handle list of messages
            } else if (error is String) {
              // Handle single string message
              errorMessage = error;
            } else if (error is int) {
              // Handle integer message
            } else {
              // Handle other types of messages
            }
          } else if (err.response?.statusCode == 412) {
            errorMessage = err.message;
          }
        } else {
          errorMessage = err.response?.data['error'];
        }
      } else {
        errorMessage = ServerException.getErrorMessage(err);
      }
      return PFailure(message: errorMessage ?? err.toString());
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
