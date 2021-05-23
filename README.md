# enough_platform_widgets

More cross platform widgets for Flutter developers.

Based on these great packages:
* [flutter_platform_widgets]()
* [cupertino_list_tile]()
* [cupertino_stepper]()


## Platform Widgets
Platform widgets use their material or cupertino equivalent based on the chosen platform.

* `PlatformChip` a simple cross-platform `Chip` replacement
* `PlatformIconButton` replaces the material `IconButon`
* `PlatformListTile` provides the material `TileBar`
* `PlatformPageScaffold` provides a `PlatformScaffold` with the additional option to define a bottom bar.
* `PlatformPopupButton` uses an action sheet on cupertino and a popup button on material.
* `PlatformStepper` abstracts the `Stepper` material widget
* `PlatformToolbar` provides a bottom bar option

## Cupertino Widgets
Currently the following cupertino widgets are provided:
* `CupertinoPageScaffoldWithToolbar` provides a scaffold that also supports a toolbar
* `CupertinoToolbar` a simple wrapper for a cupertino toolbar widget 

## Usage
Add this as a dependency to your `pubspec.yaml`:
```
enough_platform_widgets:
    git:
      url: https://github.com/Enough-Software/enough_platform_widgets.git
```