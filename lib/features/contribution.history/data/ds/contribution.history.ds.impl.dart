import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/data/ds/contribution.history.ds.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contribution.history.model.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contribution.summary.model.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contribution.year.model.dart';

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
  Future<ApiResponse<List<ContributionYear>>> getContributionYears() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getContributionsYears,
      );
      return ApiResponse<List<ContributionYear>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => ContributionYear.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<ContributionHistory>> getContributions({
    required String employerNumber,
    required String staffNumber,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {
          'employer_number': employerNumber,
          'staff_number': staffNumber,
        },
        endPoint: Env.getContributions,
      );
      return ApiResponse<ContributionHistory>.fromJson(
        res,
        (data) => ContributionHistory.fromJson(data),
      );
    });
  }
}
