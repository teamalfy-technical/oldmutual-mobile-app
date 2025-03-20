import 'package:get/get.dart';

class PSettingsVm extends GetxController {
  static PSettingsVm get instance => Get.find();

  var notification = true.obs;

  onNotificationChanged(bool? value) => notification.value = value ?? false;
}
