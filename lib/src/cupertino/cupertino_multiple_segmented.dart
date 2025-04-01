// Derrived from https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/segmented_control.dart
// Original file: Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

// Minimum padding from edges of the segmented control to edges of
// encompassing widget.
const EdgeInsetsGeometry _kHorizontalItemPadding =
    EdgeInsets.symmetric(horizontal: 16.0);

// Minimum height of the segmented control.
const double _kMinSegmentedControlHeight = 28.0;

// The duration of the fade animation used to transition when a new widget
// is selected.
const Duration _kFadeDuration = Duration(milliseconds: 165);

/// An iOS-style segmented control that allows multiple children selected or none.
///
/// Displays the widgets provided in the [Map] of [children] in a
/// horizontal list. Used to select between a number of
/// options. When one option in the segmented control is selected, the other
/// options in the segmented control keep their selected state.
///
/// A segmented control can feature any [Widget] as one of the values in its
/// [Map] of [children]. The type T is the type of the keys used
/// to identify each widget and determine which widget is selected. As
/// required by the [Map] class, keys must be of consistent types
/// and must be comparable. The ordering of the keys will determine the order
/// of the widgets in the segmented control.
///
/// When the state of the segmented control changes, the widget calls the
/// [onValueChanged] callback. The map key associated with the newly selected
/// widget is returned in the [onValueChanged] callback. Typically, widgets
/// that use a segmented control will listen for the [onValueChanged] callback
/// and rebuild the segmented control with a new [groupValue] to update which
/// option is currently selected.
///
/// The [children] will be displayed in the order of the keys in the [Map].
/// The height of the segmented control is determined by the height of the
/// tallest widget provided as a value in the [Map] of [children].
/// The width of each child in the segmented control will be equal to the width
/// of widest child, unless the combined width of the children is wider than
/// the available horizontal space. In this case, the available horizontal space
/// is divided by the number of provided [children] to determine the width of
/// each widget. The selection area for each of the widgets in the [Map] of
/// [children] will then be expanded to fill the calculated space, so each
/// widget will appear to have the same dimensions.
///
/// A segmented control may optionally be created with custom colors. The
/// [unselectedColor], [selectedColor], [borderColor], and [pressedColor]
/// arguments can be used to override the segmented control's colors from
/// [CupertinoTheme] defaults.
///
/// See also:
///
///  * [CupertinoSegmentedControl](https://api.flutter.dev/flutter/cupertino/CupertinoSegmentedControl-class.html), a segmented control widget in the style used
///    up until iOS 13.
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/controls/segmented-controls/>
class CupertinoMultipleSegmentedControl extends StatefulWidget {
  /// Creates an iOS-style segmented control bar.
  ///
  /// The [children] and [onValueChanged] arguments must not be null. The
  /// [children] argument must be an ordered [Map] such as a [LinkedHashMap].
  /// Further, the length of the [children] list must be greater than one.
  ///
  /// Each widget value in the map of [children] must have an associated key
  /// that uniquely identifies this widget. This key is what will be returned
  /// in the [onValueChanged] callback when a new value from the [children] map
  /// is selected.
  ///
  /// The [groupValue] is the currently selected value for the segmented control.
  /// If no [groupValue] is provided, or the [groupValue] is null, no widget will
  /// appear as selected. The [groupValue] must be either null or one of the keys
  /// in the [children] map.
  const CupertinoMultipleSegmentedControl({
    Key? key,
    required this.children,
    required this.isSelected,
    required this.onPressed,
    this.unselectedColor,
    this.selectedColor,
    this.borderColor,
    this.pressedColor,
    this.padding,
  })  : assert(children.length == isSelected.length,
            'The children and isSelected parameters must have the same length'),
        super(key: key);

  /// The identifying keys and corresponding widget values in the
  /// segmented control.
  ///
  /// The map must have more than one entry.
  /// This attribute must be an ordered [Map] such as a [LinkedHashMap].
  final List<Widget> children;

  /// Callback when an element has been pressed
  final Function(int index)? onPressed;

  /// Each children element is either selected or not selected, in which case this elements isSelected value is true or false respectively.
  final List<bool> isSelected;

  /// The callback that is called when a new option is tapped.
  ///
  /// This attribute must not be null.
  ///
  /// The segmented control passes the newly selected widget's associated key
  /// to the callback but does not actually change state until the parent
  /// widget rebuilds the segmented control with the new [groupValue].
  ///
  /// The callback provided to [onValueChanged] should update the state of
  /// the parent [StatefulWidget] using the [State.setState] method, so that
  /// the parent gets rebuilt; for example:
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// class MultipleSegmentedControlExample extends StatefulWidget {
  ///   const SegmentedControlExample({Key? key}) : super(key: key);
  ///
  ///   @override
  ///   State createState() => MultipleSegmentedControlExampleState();
  /// }
  ///
  /// class MultipleSegmentedControlExampleState extends State<MultipleSegmentedControlExample> {
  ///   final _children = const <Widget>[
  ///     Text('Child 1'),
  ///     Text('Child 2'),
  ///   ];
  ///   final _isSelected = [false, false];
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return CupertinoMultipleSegmentedControl(
  ///       children: _children,
  ///       isSelected: _isSelected,
  ///       onPressed: (int index) {
  ///         setState(() {
  ///           _isSelected[index] = !_isSelected[index];
  ///         });
  ///       },
  ///     );
  ///   }
  /// }
  /// ```
  /// {@end-tool}

  /// The color used to fill the backgrounds of unselected widgets and as the
  /// text color of the selected widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryContrastingColor` if null.
  final Color? unselectedColor;

  /// The color used to fill the background of the selected widget and as the text
  /// color of unselected widgets.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? selectedColor;

  /// The color used as the border around each widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? borderColor;

  /// The color used to fill the background of the widget the user is
  /// temporarily interacting with through a long press or drag.
  ///
  /// Defaults to the selectedColor at 20% opacity if null.
  final Color? pressedColor;

  /// The CupertinoMultipleSegmentedControl will be placed inside this padding.
  ///
  /// Defaults to EdgeInsets.symmetric(horizontal: 16.0)
  final EdgeInsetsGeometry? padding;

  @override
  State<CupertinoMultipleSegmentedControl> createState() =>
      _SegmentedControlState();
}

class _SegmentedControlState extends State<CupertinoMultipleSegmentedControl>
    with TickerProviderStateMixin<CupertinoMultipleSegmentedControl> {
  int? _pressedKey;

  final List<AnimationController> _selectionControllers =
      <AnimationController>[];
  final List<ColorTween> _childTweens = <ColorTween>[];

  late ColorTween _forwardBackgroundColorTween;
  late ColorTween _reverseBackgroundColorTween;
  late ColorTween _textColorTween;

  Color? _selectedColor;
  Color? _unselectedColor;
  Color? _borderColor;
  Color? _pressedColor;

  AnimationController createAnimationController() {
    return AnimationController(
      duration: _kFadeDuration,
      vsync: this,
    )..addListener(() {
        setState(() {
          // State of background/text colors has changed
        });
      });
  }

  bool _updateColors() {
    assert(mounted, 'This should only be called after didUpdateDependencies');
    bool changed = false;
    final Color selectedColor =
        widget.selectedColor ?? CupertinoTheme.of(context).primaryColor;
    if (_selectedColor != selectedColor) {
      changed = true;
      _selectedColor = selectedColor;
    }
    final Color unselectedColor = widget.unselectedColor ??
        CupertinoTheme.of(context).primaryContrastingColor;
    if (_unselectedColor != unselectedColor) {
      changed = true;
      _unselectedColor = unselectedColor;
    }
    final Color borderColor =
        widget.borderColor ?? CupertinoTheme.of(context).primaryColor;
    if (_borderColor != borderColor) {
      changed = true;
      _borderColor = borderColor;
    }
    final Color pressedColor = widget.pressedColor ??
        CupertinoTheme.of(context).primaryColor.withOpacity(0.2);
    if (_pressedColor != pressedColor) {
      changed = true;
      _pressedColor = pressedColor;
    }

    _forwardBackgroundColorTween = ColorTween(
      begin: _pressedColor,
      end: _selectedColor,
    );
    _reverseBackgroundColorTween = ColorTween(
      begin: _unselectedColor,
      end: _selectedColor,
    );
    _textColorTween = ColorTween(
      begin: _selectedColor,
      end: _unselectedColor,
    );
    return changed;
  }

  void _updateAnimationControllers() {
    assert(mounted, 'This should only be called after didUpdateDependencies');
    for (final AnimationController controller in _selectionControllers) {
      controller.dispose();
    }
    _selectionControllers.clear();
    _childTweens.clear();

    for (final selected in widget.isSelected) {
      final AnimationController animationController =
          createAnimationController();
      if (selected) {
        _childTweens.add(_reverseBackgroundColorTween);
        animationController.value = 1.0;
      } else {
        _childTweens.add(_forwardBackgroundColorTween);
      }
      _selectionControllers.add(animationController);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_updateColors()) {
      _updateAnimationControllers();
    }
  }

  @override
  void didUpdateWidget(CupertinoMultipleSegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_updateColors() ||
        oldWidget.children.length != widget.children.length) {
      _updateAnimationControllers();
    }

    if (oldWidget.isSelected != widget.isSelected) {
      int index = 0;
      for (final selected in widget.isSelected) {
        if (selected) {
          _childTweens[index] = _forwardBackgroundColorTween;
          _selectionControllers[index].forward();
        } else {
          _childTweens[index] = _reverseBackgroundColorTween;
          _selectionControllers[index].reverse();
        }
        index += 1;
      }
    }
  }

  @override
  void dispose() {
    for (final AnimationController animationController
        in _selectionControllers) {
      animationController.dispose();
    }
    super.dispose();
  }

  void _onTapDown(int index) {
    if (_pressedKey == null) {
      setState(() {
        _pressedKey = index;
      });
    }
  }

  void _onTapCancel() {
    setState(() {
      _pressedKey = null;
    });
  }

  void _onTap(int index) {
    if (index != _pressedKey) return;
    final callback = widget.onPressed;
    if (callback != null) {
      callback(index);
    }
    _pressedKey = null;
  }

  Color? getTextColor(int index) {
    if (_selectionControllers[index].isAnimating)
      return _textColorTween.evaluate(_selectionControllers[index]);
    if (widget.isSelected[index]) return _unselectedColor;
    return _selectedColor;
  }

  Color? getBackgroundColor(int index) {
    if (_selectionControllers[index].isAnimating)
      return _childTweens[index].evaluate(_selectionControllers[index]);
    if (widget.isSelected[index]) return _selectedColor;
    if (_pressedKey == index) return _pressedColor;
    return _unselectedColor;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _gestureChildren = <Widget>[];
    final List<Color> _backgroundColors = <Color>[];
    //int? selectedIndex;
    final int? pressedIndex = _pressedKey;
    for (var i = 0; i < widget.children.length; i++) {
      final selected = widget.isSelected[i];

      final TextStyle textStyle = DefaultTextStyle.of(context).style.copyWith(
            color: getTextColor(i),
            fontSize: 12,
          );
      final IconThemeData iconTheme = IconThemeData(
        color: getTextColor(i),
      );

      final child = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (event) => _onTapDown(i),
        onTapCancel: _onTapCancel,
        onTap: () => _onTap(i),
        child: IconTheme(
          data: iconTheme,
          child: DefaultTextStyle(
            style: textStyle,
            child: Semantics(
              button: true,
              //inMutuallyExclusiveGroup: true,
              selected: selected,
              child: Center(
                child: widget.children[i],
              ),
            ),
          ),
        ),
      );

      _backgroundColors.add(getBackgroundColor(i)!);
      _gestureChildren.add(child);
    }

    final Widget box = _SegmentedControlRenderWidget(
      isSelected: widget.isSelected,
      pressedIndex: pressedIndex,
      backgroundColors: _backgroundColors,
      borderColor: _borderColor!,
      children: _gestureChildren,
    );

    return Padding(
      padding: widget.padding ?? _kHorizontalItemPadding,
      child: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        child: box,
      ),
    );
  }
}

class _SegmentedControlRenderWidget extends MultiChildRenderObjectWidget {
  const _SegmentedControlRenderWidget({
    Key? key,
    List<Widget> children = const <Widget>[],
    required this.isSelected,
    required this.pressedIndex,
    required this.backgroundColors,
    required this.borderColor,
  }) : super(
          key: key,
          children: children,
        );

  final List<bool> isSelected;
  final int? pressedIndex;
  final List<Color> backgroundColors;
  final Color borderColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSegmentedControl(
      textDirection: Directionality.of(context),
      isSelected: isSelected,
      pressedIndex: pressedIndex,
      backgroundColors: backgroundColors,
      borderColor: borderColor,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSegmentedControl renderObject) {
    renderObject
      ..textDirection = Directionality.of(context)
      ..isSelected = isSelected
      ..pressedIndex = pressedIndex
      ..backgroundColors = backgroundColors
      ..borderColor = borderColor;
  }
}

class _SegmentedControlContainerBoxParentData
    extends ContainerBoxParentData<RenderBox> {
  RRect? surroundingRect;
}

typedef _NextChild = RenderBox? Function(RenderBox child);

class _RenderSegmentedControl<T> extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox,
            ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            ContainerBoxParentData<RenderBox>> {
  _RenderSegmentedControl({
    required List<bool> isSelected,
    required int? pressedIndex,
    required TextDirection textDirection,
    required List<Color> backgroundColors,
    required Color borderColor,
  })  : _textDirection = textDirection,
        _isSelected = isSelected,
        _pressedIndex = pressedIndex,
        _backgroundColors = backgroundColors,
        _borderColor = borderColor;

  List<bool> get isSelected => _isSelected;
  List<bool> _isSelected;
  set isSelected(List<bool> value) {
    if (_isSelected == value) {
      return;
    }
    _isSelected = value;
    markNeedsPaint();
  }

  int? get pressedIndex => _pressedIndex;
  int? _pressedIndex;
  set pressedIndex(int? value) {
    if (_pressedIndex == value) {
      return;
    }
    _pressedIndex = value;
    markNeedsPaint();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsLayout();
  }

  List<Color> get backgroundColors => _backgroundColors;
  List<Color> _backgroundColors;
  set backgroundColors(List<Color> value) {
    if (_backgroundColors == value) {
      return;
    }
    _backgroundColors = value;
    markNeedsPaint();
  }

  Color get borderColor => _borderColor;
  Color _borderColor;
  set borderColor(Color value) {
    if (_borderColor == value) {
      return;
    }
    _borderColor = value;
    markNeedsPaint();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    RenderBox? child = firstChild;
    double minWidth = 0.0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final double childWidth = child.getMinIntrinsicWidth(height);
      minWidth = math.max(minWidth, childWidth);
      child = childParentData.nextSibling;
    }
    return minWidth * childCount;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    RenderBox? child = firstChild;
    double maxWidth = 0.0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final double childWidth = child.getMaxIntrinsicWidth(height);
      maxWidth = math.max(maxWidth, childWidth);
      child = childParentData.nextSibling;
    }
    return maxWidth * childCount;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    RenderBox? child = firstChild;
    double minHeight = 0.0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final double childHeight = child.getMinIntrinsicHeight(width);
      minHeight = math.max(minHeight, childHeight);
      child = childParentData.nextSibling;
    }
    return minHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    RenderBox? child = firstChild;
    double maxHeight = 0.0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final double childHeight = child.getMaxIntrinsicHeight(width);
      maxHeight = math.max(maxHeight, childHeight);
      child = childParentData.nextSibling;
    }
    return maxHeight;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SegmentedControlContainerBoxParentData) {
      child.parentData = _SegmentedControlContainerBoxParentData();
    }
  }

  void _layoutRects(
      _NextChild nextChild, RenderBox? leftChild, RenderBox? rightChild) {
    RenderBox? child = leftChild;
    double start = 0.0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final Offset childOffset = Offset(start, 0.0);
      childParentData.offset = childOffset;
      final Rect childRect =
          Rect.fromLTWH(start, 0.0, child.size.width, child.size.height);
      final RRect rChildRect;
      if (child == leftChild) {
        rChildRect = RRect.fromRectAndCorners(
          childRect,
          topLeft: const Radius.circular(3.0),
          bottomLeft: const Radius.circular(3.0),
        );
      } else if (child == rightChild) {
        rChildRect = RRect.fromRectAndCorners(
          childRect,
          topRight: const Radius.circular(3.0),
          bottomRight: const Radius.circular(3.0),
        );
      } else {
        rChildRect = RRect.fromRectAndCorners(childRect);
      }
      childParentData.surroundingRect = rChildRect;
      start += child.size.width;
      child = nextChild(child);
    }
  }

  Size _calculateChildSize(BoxConstraints constraints) {
    double maxHeight = _kMinSegmentedControlHeight;
    double childWidth = constraints.minWidth / childCount;
    RenderBox? child = firstChild;
    while (child != null) {
      childWidth =
          math.max(childWidth, child.getMaxIntrinsicWidth(double.infinity));
      child = childAfter(child);
    }
    childWidth = math.min(childWidth, constraints.maxWidth / childCount);
    child = firstChild;
    while (child != null) {
      final double boxHeight = child.getMaxIntrinsicHeight(childWidth);
      maxHeight = math.max(maxHeight, boxHeight);
      child = childAfter(child);
    }
    return Size(childWidth, maxHeight);
  }

  Size _computeOverallSizeFromChildSize(Size childSize) {
    return constraints
        .constrain(Size(childSize.width * childCount, childSize.height));
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Size childSize = _calculateChildSize(constraints);
    return _computeOverallSizeFromChildSize(childSize);
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final Size childSize = _calculateChildSize(constraints);

    final BoxConstraints childConstraints = BoxConstraints.tightFor(
      width: childSize.width,
      height: childSize.height,
    );

    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(childConstraints, parentUsesSize: true);
      child = childAfter(child);
    }

    switch (textDirection) {
      case TextDirection.rtl:
        _layoutRects(
          childBefore,
          lastChild,
          firstChild,
        );
        break;
      case TextDirection.ltr:
        _layoutRects(
          childAfter,
          firstChild,
          lastChild,
        );
        break;
    }

    size = _computeOverallSizeFromChildSize(childSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    int index = 0;
    while (child != null) {
      _paintChild(context, offset, child, index);
      child = childAfter(child);
      index += 1;
    }
  }

  void _paintChild(
      PaintingContext context, Offset offset, RenderBox child, int childIndex) {
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData! as _SegmentedControlContainerBoxParentData;

    context.canvas.drawRRect(
      childParentData.surroundingRect!.shift(offset),
      Paint()
        ..color = backgroundColors[childIndex]
        ..style = PaintingStyle.fill,
    );
    context.canvas.drawRRect(
      childParentData.surroundingRect!.shift(offset),
      Paint()
        ..color = borderColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke,
    );

    context.paintChild(child, childParentData.offset + offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = lastChild;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      if (childParentData.surroundingRect!.contains(position)) {
        return result.addWithPaintOffset(
          offset: childParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset localOffset) {
            assert(localOffset == position - childParentData.offset);
            return child!.hitTest(result, position: localOffset);
          },
        );
      }
      child = childParentData.previousSibling;
    }
    return false;
  }
}
