import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';

abstract class StatementRepo {
  Future<Either<PFailure, GenerateReport>> generateReport({
    required int year,
    required bool all,
  });
  Future<Either<PFailure, ApiResponse<Statement>>> generateReportV2({
    required int year,
    required bool all,
  });
  Future<Either<PFailure, ApiResponse<ReportDownload>>> downloadReport({
    required int reportId,
  });
  Future<Either<PFailure, ReportStatus>> checkReportStatus({
    required int reportId,
  });
  Future<Either<PFailure, ApiResponse<List<Statement>>>> getReports();
}
