import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PHighlightedContentCard extends StatelessWidget {
  const PHighlightedContentCard({
    super.key,
    required this.title,
    required this.description,
    this.thumbnail,
    this.onTap,
  });

  final String title;
  final String description;
  final String? thumbnail;
  final VoidCallback? onTap;

  Widget _placeholder(BuildContext context) {
    return Container(
      width: PDeviceUtil.getDeviceWidth(context),
      color: PAppColor.greyColor.withValues(alpha: PAppSize.s0_2),
      child: Icon(
        Icons.image_outlined,
        size: PAppSize.s40,
        color: PAppColor.greyColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: PAppSize.s20),
        width: PDeviceUtil.getDeviceWidth(context) * 0.70,
        decoration: BoxDecoration(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.cardDarkColor
              : PAppColor.whiteColor,
          borderRadius: BorderRadius.circular(PAppSize.s20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(PAppSize.s20),
                  topRight: Radius.circular(PAppSize.s20),
                ),
                child: thumbnail != null
                    ? Image.network(
                        thumbnail!,
                        width: PDeviceUtil.getDeviceWidth(context),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _placeholder(context),
                      )
                    : _placeholder(context),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ).all(PAppSize.s20),
          ],
        ),
      ),
    );
  }
}
