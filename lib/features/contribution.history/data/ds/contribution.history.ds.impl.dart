import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/data/ds/contribution.history.ds.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contributed.year.model.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contribution.history.model.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contribution.summary.model.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/generate.report.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/report.status.dart';

final ContributionHistoryDs contributionHistoryDs = Get.put(
  ContributionHistoryDsImpl(),
);

class ContributionHistoryDsImpl implements ContributionHistoryDs {
  @override
  Future<ApiResponse<ContributionHistory>> filterContributions({
    required String month,
    required String year,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {'month': month, 'year': year},
        endPoint: Env.getContributions,
      );
      return ApiResponse<ContributionHistory>.fromJson(
        res,
        (data) => ContributionHistory.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<ContributionHistory>> getAllContributions() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,

        endPoint: Env.getContributions,
      );
      return ApiResponse<ContributionHistory>.fromJson(
        res,
        (data) => ContributionHistory.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<ContributionSummary>> getContributionSummary() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,

        endPoint: Env.getContributionsSummary,
      );
      return ApiResponse<ContributionSummary>.fromJson(
        res,
        (data) => ContributionSummary.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<List<ContributedYear>>> getContributionYears() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getContributedYears,
      );
      return ApiResponse<List<ContributedYear>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => ContributedYear.fromJson(e)).toList(),
      );
    });
  }

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
  Future<ApiResponse<Message>> getReport({required int reportId}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getReport}/$reportId',
      );
      return ApiResponse<Message>.fromJson(
        res,
        (data) => Message.fromJson(data),
      );
    });
  }
}
