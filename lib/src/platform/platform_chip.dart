import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlatformChip extends StatelessWidget {
  final Widget label;
  const PlatformChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (context, platform) => Chip(
        label: label,
      ),
      cupertino: (context, platform) => Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: label,
        ),
      ),
    );
  }
}
