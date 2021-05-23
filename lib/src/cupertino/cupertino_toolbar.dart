import 'package:flutter/cupertino.dart';

class CupertinoToolbar extends StatelessWidget {
  final List<Widget> children;
  const CupertinoToolbar({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Container();
    }
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 44.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    );
  }
}
