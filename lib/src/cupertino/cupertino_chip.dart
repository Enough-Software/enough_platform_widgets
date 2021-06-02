import 'package:flutter/cupertino.dart';

class CupertinoChip extends StatelessWidget {
  final Widget label;
  const CupertinoChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: label,
      ),
    );
  }
}
