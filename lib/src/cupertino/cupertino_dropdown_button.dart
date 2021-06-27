import 'dart:math';

import 'package:enough_platform_widgets/src/platform/platform_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Maps the basic dropdown feature to a CupertinoPicker
class CupertinoDropdownButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final List<Widget> Function(BuildContext context)? selectedItemBuilder;
  final T? value;
  final void Function(T? value)? onChanged;
  final double itemExtent;
  final Widget? hint;

  const CupertinoDropdownButton({
    Key? key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.onChanged,
    this.hint,
    required this.itemExtent,
  }) : super(key: key);

  @override
  _CupertinoDropdownButtonState<T> createState() =>
      _CupertinoDropdownButtonState<T>();
}

class _CupertinoDropdownButtonState<T>
    extends State<CupertinoDropdownButton<T>> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final itms = widget.items;
    if (itms == null || itms.isEmpty) {
      return Container();
    }
    final builder = widget.selectedItemBuilder;
    final children = (builder != null)
        ? builder(context)
            .map((widget) => Center(
                  child: widget,
                ))
            .toList()
        : itms.map((itm) => Center(child: itm.child)).toList();
    final currentValue = widget.value;

    final currentIndex =
        max(itms.indexWhere((item) => item.value == currentValue), 0);
    final child = currentValue == null
        ? widget.hint ?? Icon(CupertinoIcons.arrow_down)
        : children[currentIndex];
    return CupertinoButton(
      padding: EdgeInsets.all(8.0),
      child: child,
      onPressed: () async {
        final scrollController = (currentValue == null)
            ? null
            : FixedExtentScrollController(
                initialItem: currentIndex,
              );
        final result = await showCupertinoModalPopup<bool>(
          context: context,
          builder: (context) => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: SafeArea(
              child: Container(
                color: CupertinoTheme.of(context).barBackgroundColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                            child: Icon(CommonPlatformIcons.cancel),
                            onPressed: () => Navigator.of(context).pop(false)),
                        CupertinoButton(
                            child: Icon(CommonPlatformIcons.ok),
                            onPressed: () => Navigator.of(context).pop(true)),
                      ],
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: widget.itemExtent,
                        onSelectedItemChanged: (index) =>
                            _selectedIndex = index,
                        scrollController: scrollController,
                        children: children,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        if (result == true && _selectedIndex != null) {
          final callback = widget.onChanged;
          if (callback != null) {
            callback(widget.items![_selectedIndex!].value);
          }
        }
      },
    );
  }
}
