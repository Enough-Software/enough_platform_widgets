import 'package:flutter/cupertino.dart';

class CupertinoChip extends StatelessWidget {
  final Widget label;
  final Widget? deleteIcon;
  final void Function()? onDeleted;
  const CupertinoChip(
      {Key? key, required this.label, this.deleteIcon, this.onDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delIcon = deleteIcon;
    final content = delIcon != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              label,
              CupertinoButton(
                child: delIcon,
                onPressed: onDeleted,
              ),
            ],
          )
        : label;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: content,
      ),
    );
  }
}
