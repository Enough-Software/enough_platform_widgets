import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final List<TextInputFormatter>? inputFormatters;
  final bool cupertinoShowLabel;
  final bool cupertinoAlignLabelOnTop;
  final TextCapitalization textCapitalization;

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
    this.inputFormatters,
    this.cupertinoShowLabel = true,
    this.cupertinoAlignLabelOnTop = false,
    this.textCapitalization = TextCapitalization.none,
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
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        autofocus: autofocus,
        autocorrect: autocorrect,
        obscureText: obscureText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
        textCapitalization: textCapitalization,
      ),
      cupertino: (context, platform) {
        final icon = decoration?.icon;
        Widget content = CupertinoTextField(
          key: widgetKey,
          controller: controller,
          keyboardType: keyboardType,
          focusNode: focusNode,
          autofocus: autofocus,
          autocorrect: autocorrect,
          obscureText: obscureText,
          onChanged: onChanged,
          placeholder: cupertinoShowLabel
              ? decoration?.hintText
              : decoration?.labelText ?? decoration?.hintText,
          prefix: decoration?.prefix ??
              decoration?.prefixIcon ??
              (cupertinoShowLabel ? null : icon),
          suffix: decoration?.suffix ?? decoration?.suffixIcon,
          clearButtonMode: OverlayVisibilityMode.editing,
          onSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
        );
        final labelText = decoration?.labelText;
        if (cupertinoShowLabel &&
            cupertinoAlignLabelOnTop &&
            labelText != null) {
          if (icon != null) {
            content = Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: icon,
                ),
                Expanded(child: content),
              ],
            );
          }
          content = Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelText,
                  style: decoration?.labelStyle,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: content,
                ),
              ],
            ),
          );
        } else if (cupertinoShowLabel && (labelText != null || icon != null)) {
          content = Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (labelText != null) ...{
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      labelText,
                      style: decoration?.labelStyle,
                    ),
                  ),
                },
                if (icon != null) ...{
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: icon,
                  ),
                },
                Expanded(child: content),
              ],
            ),
          );
        } else {
          content = Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: content,
          );
        }
        return content;
      },
    );
  }
}
