import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Uses a `CircularProgressIndicator` on material and a `CupertinoActivityIndicator` - or the 'CupertinoProgressBar' from the `cupertino_progress_bar` package when the given value is not null - on cupertino
class PlatformProgressIndicator extends StatelessWidget {
  final double? value;
  const PlatformProgressIndicator({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final v = value;
    return PlatformWidget(
        material: (context, platform) => CircularProgressIndicator(value: v),
        cupertino: (context, platform) => (v == null)
            ? CupertinoActivityIndicator()
            : CupertinoProgressBar(value: v));
  }
}
