import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class WebViewShimmerWidget extends StatelessWidget {
  const WebViewShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PShimmerBox(
          width: double.infinity,
          height: PAppSize.s200,
          borderRadius: PAppSize.s8,
        ),
        const SizedBox(height: PAppSize.s8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PShimmerBox(
                  width: PAppSize.s150,
                  height: PAppSize.s20,
                  borderRadius: PAppSize.s8,
                ),
                const SizedBox(height: PAppSize.s8),
                PShimmerBox(
                  width: PAppSize.s80,
                  height: PAppSize.s16,
                  borderRadius: PAppSize.s8,
                ),
                const SizedBox(height: PAppSize.s8),
                PShimmerBox(
                  width: PAppSize.s60,
                  height: PAppSize.s14,
                  borderRadius: PAppSize.s8,
                ),
              ],
            ),
            PShimmerBox(
              width: PAppSize.s50,
              height: PAppSize.s50,
              shape: BoxShape.circle,
            ),
          ],
        ),
      ],
    );
  }
}
