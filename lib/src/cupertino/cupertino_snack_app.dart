import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoSnackApp extends StatelessWidget {
  const CupertinoSnackApp({
    Key? key,
    this.widgetKey,
    this.navigatorKey,
    this.home,
    this.theme,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.routes = const <String, WidgetBuilder>{},
    this.onGenerateTitle,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.scaffoldMessengerKey,
  }) : super(key: key);

  final Key? widgetKey;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final CupertinoThemeData? theme;
  final String? initialRoute;
  final Route Function(RouteSettings)? onGenerateRoute;
  final List<Route> Function(String)? onGenerateInitialRoutes;
  final Route Function(RouteSettings)? onUnknownRoute;
  final Map<String, Widget Function(BuildContext)> routes;
  final String Function(BuildContext)? onGenerateTitle;
  final List<NavigatorObserver> navigatorObservers;
  final Widget Function(BuildContext, Widget?)? builder;
  final String title;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      key: widgetKey,
      navigatorKey: navigatorKey,
      navigatorObservers: navigatorObservers,
      home: home,
      theme: theme,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      builder: _build,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      localeListResolutionCallback: localeListResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
    );
  }

  Widget _build(BuildContext context, Widget? child) {
    final builderMethod = builder;
    if (builderMethod != null) {
      child = builderMethod(context, child);
    }
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(body: child),
    );
  }
}
