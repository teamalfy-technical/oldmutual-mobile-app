import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PHelperFunction {
  //HHelperFunction._();

  ///Navigate to page
  ///[replace] determines whether to remove page from stack or to push
  ///[destination] is the route
  ///[args] Passes data to page
  static Future<dynamic>? switchScreen({
    required String destination,
    bool replace = false,
    bool popAndPush = false,
    dynamic args,
  }) {
    return replace
        ? Get.offAllNamed(destination, arguments: args)
        //? Get.until(destination, arguments: args)
        : popAndPush
        ? Get.offAndToNamed(destination, arguments: args)
        : Get.toNamed(destination, arguments: args);
  }

  /// --- Go back
  static void pop<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    Get.back(
      result: result,
      closeOverlays: closeOverlays,
      canPop: canPop,
      id: id,
    );
  }

  // check if device is in dark mode
  static bool isDarkMode(BuildContext context) =>
      // MediaQuery.of(context).platformBrightness == Brightness.dark;
      Theme.of(context).brightness == Brightness.dark;

  // check if device is in light mode
  static isLightMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;

  static List<T> removeDuplicates<T>(List<T> list) => list.toSet().toList();

  static Map<String, String> appTokenHeader() {
    String? token = PSecureStorage().getAuthResponse()?.token;
    pensionAppLogger.d('Token: $token');
    return {
      'Authorization': 'Bearer $token',
      //'Content-Type': 'application/json'
    };
  }

  static bool isEmail(String value) {
    return value.contains('@') && value.contains('.');
  }

  static bool isPhone(String value) {
    final phoneRegExp = RegExp(r'^\d[\d*]+$');
    return phoneRegExp.hasMatch(value);
  }

  static String formatPhoneNumber(String phone) {
    // Remove any spaces or dashes the user might enter
    phone = phone.trim().replaceAll(RegExp(r'\s+|-'), '');

    // If phone starts with "0" (e.g. 054xxxxxxx)
    if (phone.startsWith('0')) {
      return '233${phone.substring(1)}';
    }

    // If phone already starts with "233"
    if (phone.startsWith('233')) {
      return phone;
    }

    // If it's not valid, just return original (or throw an error)
    return '233$phone';
  }

  static Future<File> compressFile(File file) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.absolute.path}_compressed.jpg',
      quality: 70, // You can adjust compression ratio
    );
    return File(compressedFile?.path ?? file.path);
  }

  static String maskEmailDomain(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email; // invalid email, return as is
    return '${parts[0]}****';
  }

  static String maskPhoneNumber(String phone) {
    if (phone.length <= 3) return phone; // if too short, return as is

    final visiblePart = phone.substring(0, 3); // keep first 3
    final maskedPart = '*' * (phone.length - 3); // mask the rest

    return '$visiblePart$maskedPart';
  }

  static Future<String> getFileSize(File file) async {
    // Get file size in bytes
    int fileSizeInBytes = await file.length();

    // Convert to MB for easy reading
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

    pensionAppLogger.w('File size: ${fileSizeInMB.toStringAsFixed(2)} MB');

    return '${fileSizeInMB.toStringAsFixed(2)} MB';
  }

  static double findMaxValue({required List<String> values}) {
    // Convert string values to integers
    List<int> intValues = values.map((value) => int.parse(value)).toList();

    // Find the maximum value
    int maxValue = intValues.reduce((a, b) => a > b ? a : b);

    return maxValue.toDouble();
  }

  // encode String to base 64
  static String encodeStringToBase64(String input) =>
      base64Encode(utf8.encode(input));

  static String kmbGenerator(double num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)}K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)}K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)}M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)}B";
    } else {
      return num.toInt().toString();
    }
  }

  // Helper for month abbreviation
  static String monthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  static Widget getBadgeIcon(String status) {
    if (status.toLowerCase().contains(BadgeType.beneficiary.name)) {
      return Assets.icons.personBlack.svg(
        color: isDarkMode(Get.context!)
            ? PAppColor.whiteColor
            : PAppColor.darkBgColor,
      );
    }
    if (status.toLowerCase().contains(BadgeType.report.name)) {
      return Assets.icons.document.svg(
        color: isDarkMode(Get.context!)
            ? PAppColor.whiteColor
            : PAppColor.darkBgColor,
      );
    }
    if (status.toLowerCase().contains(BadgeType.contribution.name)) {
      return Assets.icons.contributionAlert.svg(
        color: isDarkMode(Get.context!)
            ? PAppColor.whiteColor
            : PAppColor.darkBgColor,
      );
    }
    if (status.toLowerCase().contains(BadgeType.maintenance.name)) {
      return Assets.icons.maintenance.svg(
        color: isDarkMode(Get.context!)
            ? PAppColor.whiteColor
            : PAppColor.darkBgColor,
      );
    }
    return Assets.icons.contributionAlert.svg(
      color: isDarkMode(Get.context!)
          ? PAppColor.whiteColor
          : PAppColor.darkBgColor,
    );
  }

  static Future<void> openFile({
    required Map<String, dynamic> pdfData,
    required String name,
  }) async {
    // pensionAppLogger.e(url);

    final String fileName = '${name.toLowerCase().split(' ').join('-')}.pdf';
    //pdfData['fileName'];
    final String base64String = pdfData['data'];
    final bytes = base64Decode(base64String);

    // Get a writable directory on the device
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    // Write the file
    await file.writeAsBytes(bytes);

    pensionAppLogger.d('PDF saved at: ${file.path}');

    // Open the file
    //   await OpenFilex.open(file.path);
    // if (file == null) return;
    OpenFile.open(file.path);
  }

  // static BadgeType getBadgeType(String status) {
  //   if (status.toLowerCase().contains(BadgeType.beneficiary.name)) {
  //     return BadgeType.beneficiary;
  //   }
  //   if (status.toLowerCase().contains(BadgeType.report.name)) {
  //     return BadgeType.report;
  //   }
  //   if (status.toLowerCase().contains(BadgeType.contribution.name)) {
  //     return BadgeType.contribution;
  //   }
  //   return BadgeType.contribution;
  // }

  // static Future<void> setStatusBarColorForIOS(BuildContext context,
  //     [Color statusBarColor = PAppColor.primaryDark]) async {
  //   if (Platform.isIOS && isLightMode(context)) {
  //     await FlutterStatusbarcolor.setStatusBarColor(statusBarColor);
  //     if (useWhiteForeground(statusBarColor)) {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  //     } else {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //     }
  //   }
  //   if (Platform.isIOS && isDarkMode(context)) {
  //     await FlutterStatusbarcolor.setStatusBarColor(GAppColor.blackColor);
  //     if (useWhiteForeground(GAppColor.blackColor)) {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  //     } else {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //     }
  //   }
  // }
}
