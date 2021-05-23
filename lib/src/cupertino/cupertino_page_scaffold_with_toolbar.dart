import 'package:flutter/cupertino.dart';

class CupertinoPageScaffoldWithToolbar extends StatelessWidget {
  final Widget child;
  final ObstructingPreferredSizeWidget? navigationBar;
  final Color? backgroundColor;
  final Widget? toolbar;

  const CupertinoPageScaffoldWithToolbar({
    Key? key,
    required this.child,
    this.navigationBar,
    this.backgroundColor,
    this.toolbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      backgroundColor: backgroundColor,
      child: toolbar == null
          ? child
          : Column(
              children: [Expanded(child: child), toolbar!],
            ),
    );
  }
}
