import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

abstract class DashboardDs {
  Future<ApiResponse<List<Scheme>>> getMemberSchemes();
  Future<ApiResponse<SelectedScheme>> getSelectedMemberScheme({
    required String employerNumber,
    required String ssnitNumber,
    required String memberNumber,
    required String masterScheme,
  });
}
