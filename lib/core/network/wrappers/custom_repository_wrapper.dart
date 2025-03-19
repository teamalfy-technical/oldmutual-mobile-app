import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';

typedef AsyncFunction<T> = Future<T> Function();

typedef CustomError = String? Function(Object e, StackTrace stackTrace);

typedef StringFunction = String? Function(String);

final CustomRepositoryWrapper customRepositoryWrapper = Get.put(
  CustomRepositoryWrapperImpl(),
);

abstract class CustomRepositoryWrapper {
  // returns an error or anything else
  Future<Either<OFailure, T>> wrapRepositoryFunction<T>({
    required AsyncFunction<T> function,
    CustomError? customError,
  });
}

class CustomRepositoryWrapperImpl implements CustomRepositoryWrapper {
  final CatchApiErrorWrapper customErrorWrapper = Get.put(
    CatchApiErrorWrapperImpl(),
  );

  @override
  Future<Either<OFailure, T>> wrapRepositoryFunction<T>({
    required AsyncFunction<T> function,
    CustomError? customError,
  }) async {
    try {
      final result = await function();
      return Right(result);
    } catch (err, stackTrace) {
      if (customError == null) {
        return Left(
          await catchApiErrorWrapper.handleError(
            err: err,
            stackTrace: stackTrace,
          ),
        );
      } else {
        return Left(
          await catchApiErrorWrapper.handleError(
            err: err,
            stackTrace: stackTrace,
          ),
        );
        //return Left( customError(err, stackTrace)!);
      }
    }
  }
}
