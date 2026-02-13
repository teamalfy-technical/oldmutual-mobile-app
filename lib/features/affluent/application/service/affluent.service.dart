import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/affluent.model.dart';

abstract class AffluentService {
  Future<Either<PFailure, ApiResponse<Affluent>>> getAffluentStatus();
}
