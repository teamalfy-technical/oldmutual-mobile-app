import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';

final StatementRepo statementRepo = Get.put(StatementRepoImpl());

class StatementRepoImpl implements StatementRepo {
  @override
  Future<Either<PFailure, ReportStatus>> checkReportStatus({
    required int reportId,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await statementDs.checkReportStatus(reportId: reportId),
    );
  }

  @override
  Future<Either<PFailure, GenerateReport>> generateReport({
    required int year,
    required bool all,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await statementDs.generateReport(year: year, all: all),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<ReportDownload>>> downloadReport({
    required int reportId,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await statementDs.downloadReport(reportId: reportId),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Statement>>>> getReports() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await statementDs.getReports(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Statement>>> generateReportV2({
    required int year,
    required bool all,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await statementDs.generateReportV2(year: year, all: all),
    );
  }
}
