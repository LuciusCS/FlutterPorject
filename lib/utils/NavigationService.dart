import 'package:flutter/material.dart';

import 'DurationLogger.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final DurationLogger durationLogger = DurationLogger();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) async {
    // await durationLogger.logPageDuration();
    // durationLogger.startTiming();
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndReplace(String routeName, {Object? arguments}) async {
    // await durationLogger.logPageDuration();
    // durationLogger.startTiming();
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }
  // void goBack({Object? result}) async {
  //   await durationLogger.logPageDuration();
  //   navigatorKey.currentState!.pop(result);
  //   durationLogger.startTiming(); // Start timing again for the previous page
  // }
}

// class DurationLogger {
//   DateTime? _startTime;
//
//   void startTiming() {
//     _startTime = DateTime.now();
//   }
//
//   Future<void> logPageDuration() async {
//     if (_startTime != null) {
//       final duration = DateTime.now().difference(_startTime!);
//       print("Page Stayed for: ${duration.inSeconds} seconds");
//       await _sendDurationToBackend(duration.inSeconds);
//     }
//   }
//
//   Future<void> _sendDurationToBackend(int duration) async {
//     // Simulate a network call
//     await Future.delayed(Duration(seconds: 1));
//     print('Duration sent to backend: $duration seconds');
//   }
// }