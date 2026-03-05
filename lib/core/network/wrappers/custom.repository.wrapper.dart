import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

typedef AsyncFunction<T> = Future<T> Function();

typedef CustomError = String? Function(Object e, StackTrace stackTrace);

typedef StringFunction = String? Function(String);

final CustomRepositoryWrapper customRepositoryWrapper = Get.put(
  CustomRepositoryWrapperImpl(),
);

abstract class CustomRepositoryWrapper {
  // returns an error or anything else
  Future<Either<PFailure, T>> wrapRepositoryFunction<T>({
    required AsyncFunction<T> function,
    CustomError? customError,
  });
}

class CustomRepositoryWrapperImpl implements CustomRepositoryWrapper {
  final CatchApiErrorWrapper customErrorWrapper = Get.put(
    CatchApiErrorWrapperImpl(),
  );

  @override
  Future<Either<PFailure, T>> wrapRepositoryFunction<T>({
    required AsyncFunction<T> function,
    CustomError? customError,
  }) async {
    try {
      final result = await function();
      return Right(result);
    } catch (err, stackTrace) {
      try {
        return Left(
          await catchApiErrorWrapper.handleError(
            err: err,
            stackTrace: stackTrace,
          ),
        );
      } catch (handlerError) {
        // Ensure we always return a failure, even if error handling itself fails
        pensionAppLogger.e(
          'Error in error handler: $handlerError | Original: $err',
        );
        return Left(PFailure(message: 'error_occurred_msg'.tr));
      }
    }
  }
}
