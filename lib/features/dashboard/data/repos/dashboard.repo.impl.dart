import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

final DashboardRepo homeRepo = Get.put(DashboardRepoImpl());

class DashboardRepoImpl implements DashboardRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Scheme>>>> getMemberSchemes() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await homeDs.getMemberSchemes(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<SelectedScheme>>>
  getSelectedMemberScheme({
    required String employerNumber,
    required String ssnitNumber,
    required String memberNumber,
    required String masterScheme,
    required String schemeType,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await homeDs.getSelectedMemberScheme(
            employerNumber: employerNumber,
            ssnitNumber: ssnitNumber,
            memberNumber: memberNumber,
            masterScheme: masterScheme,
            schemeType: schemeType,
          ),
    );
  }
}
