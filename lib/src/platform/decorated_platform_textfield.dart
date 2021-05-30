import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecoratedPlatformTextField extends StatelessWidget {
  final Key? widgetKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool autocorrect;
  final bool obscureText;
  final Function(String value)? onChanged;

  const DecoratedPlatformTextField({
    Key? key,
    this.widgetKey,
    this.controller,
    this.keyboardType,
    this.decoration,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.autocorrect = true,
    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (context, platform) => TextField(
        key: widgetKey,
        controller: controller,
        decoration: decoration,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        autofocus: autofocus,
        autocorrect: autocorrect,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
      cupertino: (context, platform) => CupertinoTextField(
        key: widgetKey,
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        autocorrect: autocorrect,
        obscureText: obscureText,
        onChanged: onChanged,
        placeholder: decoration?.labelText ?? decoration?.hintText,
        prefix: decoration?.prefix,
        suffix: decoration?.suffix,
        clearButtonMode: OverlayVisibilityMode.editing,
      ),
    );
  }
}
