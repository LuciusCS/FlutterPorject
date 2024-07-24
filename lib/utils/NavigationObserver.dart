

import 'package:flutter/cupertino.dart';

import 'DurationLogger.dart';

class NavigationObserver extends NavigatorObserver {
  final DurationLogger durationLogger = DurationLogger();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    print(
        'didPush route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
    durationLogger.startTiming();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print(
        'didPush route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
    durationLogger.logPageDuration();
    durationLogger.startTiming(); // Start timing again for the previous page
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    print(
        'didPush route: ${newRoute?.settings.name},  previousRoute:${oldRoute?.settings.name}');
    durationLogger.logPageDuration();
    durationLogger.startTiming();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    durationLogger.logPageDuration();
  }
}
