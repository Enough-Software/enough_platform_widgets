import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../cupertino.dart';

class PlatformDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final List<Widget> Function(BuildContext context)? selectedItemBuilder;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final void Function(T? value)? onChanged;
  final void Function()? onTap;
  final int elevation;
  final TextStyle? style;
  final Widget? underline;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? dropdownColor;
  final double? menuMaxHeight;

  const PlatformDropdownButton({
    Key? key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onTap,
    this.elevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (context, platform) => DropdownButton<T>(
        items: items,
        selectedItemBuilder: selectedItemBuilder,
        value: value,
        hint: hint,
        disabledHint: disabledHint,
        onChanged: onChanged,
        onTap: onTap,
        elevation: elevation,
        style: style,
        underline: underline,
        icon: icon,
        iconDisabledColor: iconDisabledColor,
        iconEnabledColor: iconEnabledColor,
        iconSize: iconSize,
        isDense: isDense,
        isExpanded: isExpanded,
        itemHeight: itemHeight,
        focusColor: focusColor,
        focusNode: focusNode,
        autofocus: autofocus,
        dropdownColor: dropdownColor,
        menuMaxHeight: menuMaxHeight,
      ),
      cupertino: (context, platform) => CupertinoDropdownButton(
        items: items,
        selectedItemBuilder: selectedItemBuilder,
        value: value,
        itemExtent: itemHeight ?? 12.0,
        hint: hint,
        onChanged: onChanged,
      ),
    );
  }
}
