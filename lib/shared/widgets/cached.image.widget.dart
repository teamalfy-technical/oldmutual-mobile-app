import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class PCachedImageWidget extends StatelessWidget {
  final String url;
  final double height;
  final double? width;
  final bool showProgressLoading;
  final fitType;

  const PCachedImageWidget({
    required this.url,
    required this.height,
    this.showProgressLoading = true,
    this.width,
    this.fitType = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? height,
      height: height,
      fit: fitType == 1 ? BoxFit.cover : BoxFit.contain,
      imageUrl: url,
      imageBuilder:
          (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(width: TAppSize.s4, color: TAppColor.kLightGrey),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
      progressIndicatorBuilder:
          (context, url, downloadProgress) =>
              showProgressLoading
                  ? Shimmer.fromColors(
                    baseColor: PAppColor.greyColorShade300,
                    highlightColor: PAppColor.greyColorShade100,
                    child: Container(
                      width: width ?? height,
                      height: height,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: PAppColor.whiteColor,
                      ),
                    ),
                  )
                  : CircleAvatar(
                    radius: width ?? height,
                    backgroundColor: PAppColor.primary.withOpacityExt(
                      PAppSize.s0_1,
                    ),
                    child: TAppAssets.getIconPath(profileIcon).svg(
                      width: width ?? height,
                      height: height,
                      fit: BoxFit.contain,
                    ),
                  ),
      errorWidget:
          (context, url, error) => CircleAvatar(
            radius: width ?? height,
            backgroundColor: PAppColor.primary.withOpacityExt(PAppSize.s0_1),
            child: TAppAssets.getIconPath(
              profileIcon,
            ).svg(width: width ?? height, height: height, fit: BoxFit.contain),
          ),
    );
  }
}
