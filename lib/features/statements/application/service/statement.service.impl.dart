import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';

final StatementService statementService = Get.put(StatementServiceImpl());

class StatementServiceImpl implements StatementService {
  @override
  Future<Either<PFailure, ReportStatus>> checkReportStatus({
    required int reportId,
  }) {
    return statementRepo.checkReportStatus(reportId: reportId);
  }

  @override
  Future<Either<PFailure, GenerateReport>> generateReport({
    required int year,
    required bool all,
  }) {
    return statementRepo.generateReport(year: year, all: all);
  }

  @override
  Future<Either<PFailure, ApiResponse<ReportDownload>>> downloadReport({
    required int reportId,
  }) {
    return statementRepo.downloadReport(reportId: reportId);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Statement>>>> getReports() async {
    return statementRepo.getReports();
  }
}
