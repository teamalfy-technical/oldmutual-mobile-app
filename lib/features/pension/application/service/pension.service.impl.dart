import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';

final PensionService pensionService = Get.put(PensionServiceImpl());

class PensionServiceImpl implements PensionService {
  @override
  Future<Either<PFailure, ApiResponse<List<Scheme>>>> getMemberSchemes() {
    return pensionRepo.getMemberSchemes();
  }

  @override
  Future<Either<PFailure, ApiResponse<SelectedScheme>>>
  getSelectedMemberScheme({
    required String employerName,
    required String employerNumber,
    required String ssnitNumber,
    required String memberName,
    required String memberNumber,
    required String masterScheme,
    required String schemeType,
    required String email,
    required String dob,
    required String dateJoined,
    required String sex,
    required String nationality,
  }) {
    return pensionRepo.getSelectedMemberScheme(
      employerName: employerName,
      employerNumber: employerNumber,
      memberName: memberName,
      memberNumber: memberNumber,
      ssnitNumber: ssnitNumber,
      masterScheme: masterScheme,
      schemeType: schemeType,
      email: email,
      dob: dob,
      dateJoined: dateJoined,
      sex: sex,
      nationality: nationality,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PensionSummary>>> getPensionSummary() {
    return pensionRepo.getPensionSummary();
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPensionCertificate({
    required String employerNumber,
    required String staffNumber,
  }) => pensionRepo.downloadPensionCertificate(
    employerNumber: employerNumber,
    staffNumber: staffNumber,
  );
}
