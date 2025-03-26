import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final bool centered;

  const PCustomLoadingIndicator({
    super.key,
    this.size = PAppSize.s20,
    this.color = PAppColor.primary,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    return centered
        ? Center(
          child:
              Platform.isIOS
                  ? CupertinoActivityIndicator(color: color, radius: size / 2)
                  : SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(color: color),
                  ),
        )
        : CircularProgressIndicator.adaptive(backgroundColor: color);

    // Platform.isIOS
    //     ? CupertinoActivityIndicator(
    //         color: color,
    //         radius: size / 2,
    //       )
    //     : SizedBox(
    //         width: size,
    //         height: size,
    //         child: CircularProgressIndicator(
    //           color: color,
    //         ));
  }
}
