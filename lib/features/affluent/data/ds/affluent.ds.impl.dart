import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

final AffluentDs affluentDs = Get.put(AffluentDsImpl());

class AffluentDsImpl implements AffluentDs {
  @override
  Future<ApiResponse<Affluent>> getAffluentStatus() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: 'Env.getAffluentStatus', // TODO: Add endpoint to Env
      );
      return ApiResponse<Affluent>.fromJson(
        res,
        (data) => Affluent.fromJson(data),
      );
    });
  }
}
