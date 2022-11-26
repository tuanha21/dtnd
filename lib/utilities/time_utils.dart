class TimeUtilities {
  static int timeToEpoch(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch ~/ 1000;

  static DateTime epochToTime(int epoch) =>
      DateTime.fromMillisecondsSinceEpoch(epoch * 1000);

  static DateTime get beginningOfDay {
    final now = DateTime.now();
    int day = now.day;
    if (now.weekday > 5) {
      final diff = now.weekday - 5;
      day -= diff;
    }
    final lastMidnight = DateTime(now.year, now.month, day);
    return lastMidnight;
  }
}
