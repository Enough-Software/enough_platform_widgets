import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CupertinoPageWithBar extends StatelessWidget {
  final Widget child;
  final Widget bar;
  final Alignment alignment;
  final bool blurBackground;

  const CupertinoPageWithBar({
    Key? key,
    required this.child,
    required this.bar,
    this.alignment = Alignment.bottomCenter,
    this.blurBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wrappedBar = blurBackground
        ? ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: bar),
          )
        : bar;
    return Stack(
      children: [
        Positioned.fill(child: child),
        Align(
          alignment: alignment,
          child: wrappedBar,
        ),
      ],
    );
  }
}
