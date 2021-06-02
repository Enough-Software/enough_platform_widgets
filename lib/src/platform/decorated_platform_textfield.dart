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
  final Function(String value)? onSubmitted;
  final Function()? onEditingComplete;

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
    this.onSubmitted,
    this.onEditingComplete,
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
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
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
        prefix: decoration?.prefix ?? decoration?.prefixIcon,
        suffix: decoration?.suffix ?? decoration?.suffixIcon,
        clearButtonMode: OverlayVisibilityMode.editing,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
