class AppUtils {
  static String getWeekDayString(int weekday) {
    return weekDays[weekday - 1];
  }
}

final List<String> weekDays = [
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
  "Sun",
];
