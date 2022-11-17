class TimeUtilities {
  static int timeToEpoch(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch ~/ 1000;

  static DateTime epochToTime(int epoch) =>
      DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
}
