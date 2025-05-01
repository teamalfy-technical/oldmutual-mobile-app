import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';

final DashboardService dashboardService = Get.put(DashboardServiceImpl());

class DashboardServiceImpl implements DashboardService {
  @override
  Future<Either<PFailure, ApiResponse<List<Scheme>>>> getMemberSchemes() {
    return homeRepo.getMemberSchemes();
  }

  @override
  Future<Either<PFailure, ApiResponse<SelectedScheme>>>
  getSelectedMemberScheme({
    required String employerNumber,
    required String ssnitNumber,
    required String memberNumber,
    required String masterScheme,
    required String schemeType,
  }) {
    return homeRepo.getSelectedMemberScheme(
      employerNumber: employerNumber,
      ssnitNumber: ssnitNumber,
      memberNumber: memberNumber,
      masterScheme: masterScheme,
      schemeType: schemeType,
    );
  }
}
