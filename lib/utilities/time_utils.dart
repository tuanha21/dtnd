class TimeUtilities {
  static bool isLeapYear(DateTime dateTime) {
    if (dateTime.year % 4 == 0) {
      return true;
    }
    return false;
  }

  static Duration week(int weeks) {
    if (weeks <= 0) {
      return const Duration();
    }
    return Duration(days: weeks * 7);
  }

  static Duration month(int months) {
    final now = DateTime.now();
    DateTime day;
    final month = months;
    day = DateTime(now.year, now.month - month, now.day);
    if (day.month != now.month - month && day.day != now.day) {
      day = DateTime(day.year, day.month - (month - 1), 0);
    }
    return now.difference(day);
  }

  static Duration year(int years) {
    final now = DateTime.now();
    DateTime day;
    if (now.month == 2 && now.day == 29) {
      day = DateTime(now.year - 1, 2, 28);
    } else {
      day = DateTime(now.year - 1, now.month, now.day);
    }
    return now.difference(day);
  }

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

  static DateTime getPreviousDateTime(Duration duration) {
    final now = DateTime.now();
    final previous = now.subtract(duration);
    return previous;
  }

  static DateTime getAfterDateTime(Duration duration) {
    final now = DateTime.now();
    final after = now.add(duration);
    return after;
  }
}

// abstract class Time {
//   abstract final int quantities;
// }

// class Minute implements Time {
//   Minute(this.minutes);

//   late final int minutes;

//   @override
//   int get quantities => minutes;
// }

// class Hour implements Time {
//   Hour(this.hours);

//   late final int hours;

//   @override
//   int get quantities => hours;
// }

// class Day implements Time {
//   Day(this.days);

//   late final int days;

//   @override
//   int get quantities => days;
// }

// class Week implements Time {
//   Week(this.weeks);

//   late final int weeks;

//   @override
//   int get quantities => weeks;
// }