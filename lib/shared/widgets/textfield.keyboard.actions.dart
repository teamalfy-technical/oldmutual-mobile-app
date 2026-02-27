import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PKeyboardActions extends StatelessWidget {
  final Widget? child;
  final FocusNode focusNode;
  const PKeyboardActions({super.key, this.child, required this.focusNode});
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return KeyboardActions(
      autoScroll: false,
      config: KeyboardActionsConfig(
        keyboardBarColor: isDark
            ? CupertinoColors
                  .systemGroupedBackground
                  .darkHighContrastElevatedColor
            : CupertinoColors.systemGroupedBackground.highContrastElevatedColor,
        actions: [
          KeyboardActionsItem(
            focusNode: focusNode,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(), // Dismiss the keyboard
                  child: Text(
                    'done'.tr,
                    style: TextStyle(
                      color: isDark
                          ? PAppColor.whiteColor
                          : PAppColor.textColorDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ).all(PAppSize.s8),
                );
              },
            ],
          ),
        ],
      ),
      child: child,
    );
  }
}
