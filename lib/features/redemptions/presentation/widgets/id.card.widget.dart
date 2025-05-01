import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PIdCardWidget extends StatelessWidget {
  final File file;
  final String label;
  final Function()? onGalleryTap;
  final Function()? onCameraTap;
  const PIdCardWidget({
    super.key,
    required this.file,
    this.onGalleryTap,
    this.onCameraTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                text: ' ( ${'ghana_card'.tr} )',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: PAppColor.text300),
              ),
            ],
          ),
        ),
        PAppSize.s4.verticalSpace,
        Container(
          width: PDeviceUtil.getDeviceWidth(context),
          height: PAppSize.s220,
          decoration: BoxDecoration(
            color: PAppColor.fillColor2,
            borderRadius: BorderRadius.circular(PAppSize.s5),
            image: DecorationImage(
              fit: file.path.isEmpty ? BoxFit.none : BoxFit.cover,
              image:
                  file.path.isEmpty
                      ? AssetImage(Assets.images.placeholderImg.path)
                      : FileImage(file),
            ),
          ),
        ),
        PAppSize.s4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'upload_from_gallery'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: PAppColor.primary,
              ),
            ).onPressed(onTap: onGalleryTap),
            PAppSize.s20.horizontalSpace,
            Expanded(
              child: ElevatedButton(
                onPressed: onCameraTap,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: PAppColor.whiteColor,
                  backgroundColor: Color(0xFF979797),
                  side: BorderSide.none,
                  minimumSize: Size.fromHeight(PAppSize.s36),
                ),
                child: Text(
                  'camera'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: PAppColor.offWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
