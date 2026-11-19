/// How a day shows in "أسبوعك مع الدعاء" (Figma ١٨).
enum DayMark {
  /// Finished at least one set of duas: a honey circle with the logo's star.
  done,

  /// Today, not yet: a green ring.
  today,

  /// Today, and done: the honey circle inside the ring.
  todayDone,

  /// Gone by without: a quiet sand dot — no red, no ✕.
  missed,

  /// Still to come: a faint dashed circle.
  future,
}

/// The line under the week.
enum WeekLine {
  /// «أحبُّ الأعمال إلى الله أدومُها وإن قلّ».
  midWeek,

  /// "أسبوع كامل — تقبّل الله منك وزادك من فضله".
  full,

  /// "أسبوع جديد، وصفحة جديدة — ابدأها بدعوة".
  saturday,
}

/// The week (Saturday to Friday) around a day, from the days a set of duas
/// was finished. Local calendar days; pure, for testing.
class DuaWeek {
  DuaWeek(DateTime now, Set<DateTime> doneDays)
    : today = _date(now),
      start = weekStart(now) {
    marks = [
      for (var i = 0; i < 7; i++)
        _mark(DateTime(start.year, start.month, start.day + i), doneDays),
    ];
  }

  /// Saturday 00:00 of [now]'s week (Dart counts Monday as 1, Saturday 6).
  static DateTime weekStart(DateTime now) {
    final day = _date(now);
    return DateTime(day.year, day.month, day.day - (day.weekday - 6) % 7);
  }

  final DateTime today;
  final DateTime start;

  /// Saturday first.
  late final List<DayMark> marks;

  int get done => marks
      .where((mark) => mark == DayMark.done || mark == DayMark.todayDone)
      .length;

  WeekLine get line => done == 7
      ? WeekLine.full
      : today.weekday == DateTime.saturday
      ? WeekLine.saturday
      : WeekLine.midWeek;

  DayMark _mark(DateTime day, Set<DateTime> doneDays) {
    final isDone = doneDays.contains(day);
    if (day == today) return isDone ? DayMark.todayDone : DayMark.today;
    if (day.isAfter(today)) return DayMark.future;
    return isDone ? DayMark.done : DayMark.missed;
  }

  static DateTime _date(DateTime t) {
    final local = t.toLocal();
    return DateTime(local.year, local.month, local.day);
  }
}
