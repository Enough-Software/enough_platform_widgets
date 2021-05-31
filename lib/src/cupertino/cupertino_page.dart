import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CupertinoPageWithBar extends StatelessWidget {
  final Widget child;
  final Widget bar;
  final Alignment alignment;

  const CupertinoPageWithBar({
    Key? key,
    required this.child,
    required this.bar,
    this.alignment = Alignment.bottomCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 44.0),
          child: child,
        )),
        Align(
          alignment: alignment,
          child: bar,
        ),
      ],
    );
  }
}
