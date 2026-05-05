import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

/// Modal promo dialog for the Legacy Transition Plan. The flyer image
/// fills the dialog; a circular white close button overlaps the
/// top-right corner. Tap on the flyer is intentionally a no-op.
Future<void> showLegacyTransitionPromoDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const _LegacyTransitionPromoDialog(),
  );
}

class _LegacyTransitionPromoDialog extends StatelessWidget {
  const _LegacyTransitionPromoDialog();

  @override
  Widget build(BuildContext context) {
    final width = PDeviceUtil.getDeviceWidth(context) * 0.85;
    return Dialog(
      backgroundColor: PAppColor.transparentColor,
      surfaceTintColor: PAppColor.transparentColor,
      shadowColor: PAppColor.transparentColor,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: PAppSize.s20,
        vertical: PAppSize.s24,
      ),
      child: SizedBox(
        width: width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(PAppSize.s16),
              child: Assets.images.legacyTransition.image(
                width: width,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: PAppSize.s10,
              right: PAppSize.s10,
              child: Material(
                color: PAppColor.whiteColor,
                shape: const CircleBorder(),
                elevation: PAppSize.s2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: EdgeInsets.all(PAppSize.s8),
                    child: Icon(
                      Icons.close,
                      size: PAppSize.s20,
                      color: PAppColor.text700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
