import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

abstract class Failure extends Equatable {
  const Failure();

  String getMessage();

  @override
  List<Object?> get props => [];
}

class PFailure extends Failure {
  const PFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String getMessage() => message;
}

class NoInternetFailure extends Failure {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'no_internet_msg'.tr;

  @override
  String getMessage() => 'no_internet_msg'.tr;
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [];

  @override
  String toString() => message;

  @override
  String getMessage() => message;
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String getMessage() => message;
}

class UnauthorisedFailure extends Failure {
  const UnauthorisedFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String getMessage() => message;
}

class ServerFailure extends Failure {
  const ServerFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String getMessage() => message;
}

class SessionTimeOut extends Failure {
  const SessionTimeOut({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String getMessage() => message;
}

class UnknownFailure extends Failure {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'unexpected_error'.tr;

  @override
  String getMessage() => 'unexpected_error'.tr;
}
