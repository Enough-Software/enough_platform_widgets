## 0.7.0
- Thanks again to [Dmytro Korotchenko](https://github.com/chitkiu) the `PlatformDropdownButton` is now more flexible.
- Re-added `PlatformListTile`, this time based on the Flutter's official `CupertinoListTile` widget.

## 0.6.0
- Thanks again to [Brendan](https://github.com/definitelyme) enough_platform_widgets is now compatible with Flutter 3.7.

## 0.5.0
- Thanks to [Brendan](https://github.com/definitelyme) enough_platform_widgets is now compatible with Flutter 3.3.

## 0.4.0
- Thanks to [fotiDim](https://github.com/fotiDim) `PlatformInkWell.pressColor` is now available to add tap effects visible on iOS.
- `PlatformStepper` now supports specifying the `controlBuilder`. 
- Add some additional `CommonPlatformIcons`.
- Tested with Flutter 3.0.0.
- Align with flutter_platform_widgets latest releases.

## 0.3.0
- Support Flutter 2.8.x.
- Align with flutter_platform_widgets latest releases.

## 0.2.2
- Removes dependency on `dart:io` to become compatible with flutter web.

## 0.2.1
- Removes dependency on `dart:io` to become compatible with flutter web.
- Add `CommonPlatformIcons.info`
- Improve `PlatformDropdownButton` rendering on cupertino 

## 0.2.0

* New widgets:
  - `CupertinoSearchFlowTextField` displays a CupertinoSearchTextField with the expected UX flow that switches to a full-screen experience once editing starts
  - `CupertinoInkWell` is a rectangular area of a that responds to touch
  - `PlatformInkWell` is a rectangular area of a that responds to touch and is based either on `InkWell` or on `CupertinoInkWell`
  - `PlatformDialogActionText` provides a platform aware dialog action text
  
* Improvements:
  - `PlatformProgressIndicator` now allows to display the progress percentage.
  - `CupertinoMultipleSegmentedControl` now centers contents automatically and reduces the default font-size to 12.

* Other
  - `PlatformInfo.isCupertino` now allows you to check for cupertino platform without relying on `dart:io`.
  - Makes the `cupertino_progress_bar` package / `CupertinoProgressBar` widget available

## 0.1.0

* Collection of Cupertino and platform aware widgets & helpers
