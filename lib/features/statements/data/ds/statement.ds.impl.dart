import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/statements/domain/models/generate.report.dart';
import 'package:oldmutual_pensions_app/features/statements/domain/models/report.status.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';

final StatementDs statementDs = Get.put(StatementDsImpl());

class StatementDsImpl implements StatementDs {
  @override
  Future<ReportStatus> checkReportStatus({required int reportId}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.checkReportStatus}/$reportId',
      );
      return ReportStatus.fromJson(res);
    });
  }

  @override
  Future<GenerateReport> generateReport({required int year}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        queryParams: {'year': year},
        endPoint: Env.generateReport,
      );
      return GenerateReport.fromJson(res);
    });
  }

  @override
  Future<ApiResponse<Message>> downloadReport({required int reportId}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.downloadReport}/$reportId',
      );
      return ApiResponse<Message>.fromJson(
        res,
        (data) => Message.fromJson(data),
      );
    });
  }
}
