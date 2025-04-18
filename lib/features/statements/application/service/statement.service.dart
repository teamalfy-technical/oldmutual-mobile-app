import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

abstract class StatementService {
  Future<Either<PFailure, GenerateReport>> generateReport({required int year});
  Future<Either<PFailure, ApiResponse<Message>>> getReport({
    required int reportId,
  });
  Future<Either<PFailure, ReportStatus>> checkReportStatus({
    required int reportId,
  });
}
