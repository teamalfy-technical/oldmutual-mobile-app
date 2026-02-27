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
    return KeyboardActions(
      autoScroll: false,
      config: KeyboardActionsConfig(
        actions: [
          KeyboardActionsItem(
            focusNode: focusNode,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(), // Dismiss the keyboard
                  child: Text('done'.tr).all(PAppSize.s8),
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
