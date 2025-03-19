import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PAnnotatedRegion extends StatelessWidget {
  final Widget child;
  const PAnnotatedRegion({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          PHelperFunction.isDarkMode(context)
              ? SystemUiOverlayStyle.light
              : const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: PAppColor.transparentColor,
                systemNavigationBarColor: PAppColor.whiteColor,
                systemNavigationBarIconBrightness: Brightness.light,
                systemNavigationBarDividerColor: PAppColor.transparentColor,
              ),
      child: child,
    );
  }
}
