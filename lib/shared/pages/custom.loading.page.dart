import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PCustomLoadingPage extends StatelessWidget {
  final String message;
  const PCustomLoadingPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: PDeviceUtil.getDeviceHeight(context) * 0.04,
                left: PAppSize.s0,
                right: PAppSize.s0,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: PCustomLoadingIndicator(
                  color: PAppColor.primary,
                  size: PAppSize.s28,
                ),
              ),
            ],
          ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
        ),
      ),
    );
  }
}
