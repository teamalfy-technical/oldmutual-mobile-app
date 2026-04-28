import 'package:get/get.dart';

enum ClaimType {
  instant,
  standard,
  partialWithdrawal,
  refund;

  String get label {
    switch (this) {
      case ClaimType.instant:
        return 'instant_claim'.tr;
      case ClaimType.standard:
        return 'standard_claim'.tr;
      case ClaimType.partialWithdrawal:
        return 'partial_withdrawal'.tr;
      case ClaimType.refund:
        return 'refund_claim'.tr;
    }
  }
}
