import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

abstract class DashboardRepo {
  Future<Either<PFailure, ApiResponse<List<Scheme>>>> getMemberSchemes();
  Future<Either<PFailure, ApiResponse<SelectedScheme>>>
  getSelectedMemberScheme({
    required String employerNumber,
    required String ssnitNumber,
    required String memberNumber,
  });
}
