class DurationLogger {
  DateTime? _startTime;

  void startTiming() {
    _startTime = DateTime.now();
  }

  void logPageDuration() {
    if (_startTime != null) {
      final duration = DateTime.now().difference(_startTime!);
      print("Page Stayed for: ${duration.inSeconds} seconds");
      _sendDurationToBackend(duration.inSeconds);
      _startTime = null; // Reset start time after logging
    }
  }

  void _sendDurationToBackend(int duration) async {
    // // Simulate a network call asynchronously without awaiting
    // Future.delayed(Duration(seconds: 1), () async {
    //   final response = await http.post(
    //     Uri.parse('https://your-backend-endpoint.com/log_duration'),
    //     body: {'duration': duration.toString()},
    //   );
    //
    //   if (response.statusCode == 200) {
    //     print('Duration logged successfully');
    //   } else {
    //     print('Failed to log duration');
    //   }
    // });

    print("将数据发送至后台");
  }
}