import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class RedactedWidget extends StatelessWidget {
  const RedactedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(PAppSize.s12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PAppSize.s4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(PAppSize.s50.toInt()),
                blurRadius: PAppSize.s10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PAppSize.s8,
                  vertical: PAppSize.s4,
                ),
                // margin: const EdgeInsets.symmetric(vertical: 6),
                width: MediaQuery.of(context).size.width,
                height: PAppSize.s200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PAppSize.s4),
                  color: Colors.red.shade400,
                ),
                child:
                    const Text(
                      "Status",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: PAppSize.s12,
                      ),
                    ).hide,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PAppSize.s8,
                  vertical: PAppSize.s4,
                ),
                margin: const EdgeInsets.symmetric(vertical: PAppSize.s8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PAppSize.s4),
                  color: Colors.red.shade400,
                ),
                child:
                    const Text(
                      "Status",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: PAppSize.s12,
                      ),
                    ).hide,
              ),
              Container(
                width: PAppSize.s120,
                height: PAppSize.s20,
                padding: const EdgeInsets.symmetric(vertical: PAppSize.s4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PAppSize.s4),
                  color: Colors.transparent,
                ),
                child: const Text(
                  "Headphone name",
                  style: TextStyle(
                    fontSize: PAppSize.s14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: PAppSize.s8),
              Container(
                width: PAppSize.s60,
                height: PAppSize.s12,
                padding: const EdgeInsets.symmetric(vertical: PAppSize.s4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PAppSize.s4),
                  color: Colors.transparent,
                ),
                child: const Text(
                  "product type",
                  style: TextStyle(
                    fontSize: PAppSize.s10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: PAppSize.s8),
              Container(
                width: PAppSize.s60,
                height: PAppSize.s22,
                padding: const EdgeInsets.symmetric(vertical: PAppSize.s4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PAppSize.s4),
                  color: Colors.transparent,
                ),
                child: const Text(
                  "\$00.00",
                  style: TextStyle(
                    fontSize: PAppSize.s16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: PAppSize.s8),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: PAppSize.s150,
                  height: PAppSize.s10,
                  padding: const EdgeInsets.symmetric(vertical: PAppSize.s4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s4),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PAppSize.s8,
              vertical: PAppSize.s4,
            ),
            margin: const EdgeInsets.all(PAppSize.s28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PAppSize.s4),
              color: Colors.orange.shade100,
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.orange.shade300, size: 16),
                const SizedBox(width: PAppSize.s4),
                Text(
                  "0.0",
                  style: TextStyle(
                    color: Colors.orange.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: PAppSize.s12,
                  ),
                ).hide,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.all(PAppSize.s16),
            width: PAppSize.s40,
            height: PAppSize.s40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.shade400,
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
