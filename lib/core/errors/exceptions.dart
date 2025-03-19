import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NoInternetException implements Exception {
  @override
  String toString() => 'no_internet_msg'.tr;
}

class TimeoutException implements Exception {
  const TimeoutException({required this.message});
  final String message;
}

class BadRequestException implements Exception {
  const BadRequestException({
    required this.message,
  });
  final String message;
}

class UnauthorisedException implements Exception {
  const UnauthorisedException({
    required this.message,
  });
  final String message;
}

// class ServerException implements Exception {
//   const ServerException({
//     required this.message,
//   });
//   final String message;
// }

class ServerException implements Exception {
  const ServerException({required this.message});

  final String message;

  static String? getErrorMessage(DioException e) {
    String? message;
    if (e.type == DioExceptionType.connectionError) {
      message =
          'Oops, something is not right.\nPlease check your internet connection';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      message = 'Request took so long and has timed out';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = 'Server took soo long respond.\nPlease try again';
    } else if (e.type == DioExceptionType.badResponse) {
      message = 'Service unavailable';
    } else if (e.type == DioExceptionType.cancel) {
      message = 'Request Cancelled';
    }
    return message!;
  }
}
