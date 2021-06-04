import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../cupertino.dart';

class PlatformChip extends StatelessWidget {
  final Widget label;
  final Widget? deleteIcon;
  final void Function()? onDeleted;

  const PlatformChip(
      {Key? key, required this.label, this.deleteIcon, this.onDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (context, platform) => Chip(
        label: label,
        deleteIcon: deleteIcon,
        onDeleted: onDeleted,
      ),
      cupertino: (context, platform) => CupertinoChip(
        label: label,
        deleteIcon: deleteIcon,
        onDeleted: onDeleted,
      ),
    );
  }
}

class PlatformActionChip extends StatelessWidget {
  final Widget label;
  final Function() onPressed;
  const PlatformActionChip({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (context, platform) => ActionChip(
        label: label,
        onPressed: onPressed,
      ),
      cupertino: (context, platform) => CupertinoButton(
        child: CupertinoChip(
          label: label,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
