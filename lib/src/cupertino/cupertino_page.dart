import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CupertinoPageWithBar extends StatelessWidget {
  final Widget child;
  final Widget bar;
  final Alignment alignment;
  final bool blurBackground;
  final double backgroundOpacity;

  const CupertinoPageWithBar({
    Key? key,
    required this.child,
    required this.bar,
    this.alignment = Alignment.bottomCenter,
    this.blurBackground = false,
    this.backgroundOpacity = 1.0,
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
        : (backgroundOpacity < 1.0)
            ? Container(
                color: CupertinoTheme.of(context)
                    .barBackgroundColor
                    .withOpacity(backgroundOpacity),
                child: bar,
              )
            : bar;
    return Stack(
      children: [
        Positioned.fill(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 44.0),
          child: child,
        )),
        Align(
          alignment: alignment,
          child: wrappedBar,
        ),
      ],
    );
  }
}
