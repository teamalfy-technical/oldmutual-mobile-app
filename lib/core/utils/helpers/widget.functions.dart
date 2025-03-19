import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

var oldmutualLogger = Logger(printer: PrettyPrinter(lineLength: 500));

Future showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  bool enableDrag = false,
  bool useSafeArea = true,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet(
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    // shape: customRectShape,
    context: context,
    builder: (context) => child,
  );
}

// show option popup menu
void showOptionsMenu(
  BuildContext context,
  TapDownDetails details,
  List<PopupMenuEntry<String>> items,
  Function(String?) onItemSelected,
) {
  showMenu<String>(
    context: context,
    color:
        PHelperFunction.isDarkMode(context)
            ? PAppColor.lightBlackColor
            : PAppColor.whiteColor,
    shadowColor: PAppColor.shadowColor,
    surfaceTintColor:
        PHelperFunction.isDarkMode(context)
            ? PAppColor.lightBlackColor
            : PAppColor.whiteColor,
    elevation: PAppSize.s3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PAppSize.s8),
    ),
    position: RelativeRect.fromLTRB(
      details.globalPosition.dx,
      details.globalPosition.dy,
      details.globalPosition.dx,
      details.globalPosition.dy,
    ), //position where you want to show the menu on screen
    items: items,
  ).then<void>(onItemSelected);
}

// 0597191559
Future showConfirmDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  bool hideNegBtn = false,
  String? negativeText,
  required Function() onPostiveTap,
  Function()? onNegativeTap,
}) {
  // final l10n = AppLocalizations.of(context)!;
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: hideNegBtn ? false : true,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor:
            PHelperFunction.isDarkMode(context)
                ? PAppColor.lightBlackColor
                : PAppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PAppSize.s10),
        ),
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: onPostiveTap,
            child: Text(
              negativeText ?? 'contnue'.tr,
              style: const TextStyle(color: PAppColor.primaryDark),
            ),
          ),
          hideNegBtn
              ? const SizedBox.shrink()
              : TextButton(
                onPressed: onNegativeTap ?? () => PHelperFunction.pop(),
                child: Text(
                  negativeText ?? 'cancel'.tr,
                  style: const TextStyle(color: PAppColor.errorColor),
                ),
              ),
        ],
      );
    },
  );
}

Future showLoadingdialog({
  required BuildContext context,
  required Widget content,
}) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor:
            PHelperFunction.isDarkMode(context)
                ? PAppColor.lightBlackColor
                : PAppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PAppSize.s10),
        ),

        content: SizedBox(
          height: PDeviceUtil.getDeviceHeight(context) * 0.25,
          child: content.centered(),
        ),
      );
    },
  );
}

Future showSucccessdialog({
  required BuildContext context,
  required String title,
}) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor:
            PHelperFunction.isDarkMode(context)
                ? PAppColor.lightBlackColor
                : PAppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PAppSize.s10),
        ),
        content: SizedBox(
          height: PDeviceUtil.getDeviceHeight(context) * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              Assets.icons.successIcon.svg(),
            ],
          ),
        ),
      );
    },
  );
}

// showLoadingDialog(BuildContext context, [String? message]) {
//   // return showAnimatedDialog(
//   return showAdaptiveDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (dialogContex) {
//       return const Scaffold(
//         backgroundColor: Colors.black45,
//         body: Center(
//           child: HCustomLoadingIndicator(size: HAppSize.s32),
//         ),
//       );
//     },
//   );
// }

Future<DateTime?> showDatePickerModal(
  BuildContext context, {
  DateTime? initialDateTime,
  DateTime? minimumDate,
  DateTime? maximumDate,
}) async {
  DateTime? dateTime;
  PDeviceUtil.isIOS()
      ? await showCupertinoModalPopup<void>(
        context: context,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              color:
                  PHelperFunction.isDarkMode(context)
                      ? PAppColor.text500
                      : PAppColor.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(PAppSize.s12),
                topRight: Radius.circular(PAppSize.s12),
              ),
            ),
            height: PDeviceUtil.getDeviceHeight(context) * 0.27,
            child: Stack(
              children: [
                CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime:
                      initialDateTime ??
                      DateTime.now().subtract(const Duration(days: 4751)),
                  minimumDate: minimumDate ?? DateTime(1950),
                  maximumDate:
                      maximumDate ??
                      DateTime.now().subtract(const Duration(days: 4751)),
                  onDateTimeChanged: (value) {
                    dateTime = value;
                  },
                ),
                Positioned(
                  right: 0,
                  child: TextButton(
                    onPressed: () => PHelperFunction.pop(),
                    child: Text(
                      'ok'.tr,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        color: PAppColor.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
      : dateTime = await showDatePicker(
        context: context,
        initialDate:
            initialDateTime ??
            DateTime.now().subtract(const Duration(days: 4751)),
        firstDate: minimumDate ?? DateTime(1950),
        lastDate:
            maximumDate ?? DateTime.now().subtract(const Duration(days: 4751)),
        //helpText: 'Select Date of birth',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
      );
  return dateTime;
}

Future<TimeOfDay?> showTimePickerModal(BuildContext context) async {
  return await showTimePicker(context: context, initialTime: TimeOfDay.now());
}
