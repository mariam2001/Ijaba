import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/core/utils/ordinal.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/dua_selection.dart';
import 'package:ijaba/features/duas/presentation/library_categories.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// What finishing a set of duas means for the completion screen (Figma
/// ١٤): what was finished, and the noun for "this month's Nth …".
class Completion {
  const Completion._({
    required this.key,
    required this.count,
    required this.done,
    required this.adhkar,
    _Streak? streak,
  }) : _streak = streak;

  /// For finishing [selection]'s [count] duas; null for one search result.
  static Completion? of(DuaSelection selection, int count) =>
      switch (selection) {
        WindowDuas(:final window?) => Completion._(
          key: 'window.${window.name}',
          count: count,
          adhkar:
              window == DuaWindowType.morningAdhkar ||
              window == DuaWindowType.eveningAdhkar,
          done: (context) => context.tr(
            window == DuaWindowType.morningAdhkar ||
                    window == DuaWindowType.eveningAdhkar
                ? LocaleKeys.completion_done_shelf
                : LocaleKeys.completion_done_window,
            namedArgs: {'name': context.tr(windowNameKey(window))},
          ),
          streak: switch (window) {
            DuaWindowType.lastThirdOfNight => _Streak.night,
            DuaWindowType.fridayHour => _Streak.friday,
            _ => _Streak.day,
          },
        ),
        WindowDuas() => null,
        CategoryDuas(:final category) => Completion._(
          key: 'shelf.${category.name}',
          count: count,
          adhkar: category.countKey == LocaleKeys.library_adhkar_count,
          done: (context) => switch (category) {
            LibraryCategory.mine => context.tr(LocaleKeys.completion_done_mine),
            LibraryCategory.saved => context.tr(
              LocaleKeys.completion_done_saved,
            ),
            _ => context.tr(
              LocaleKeys.completion_done_shelf,
              namedArgs: {'name': context.tr(category.titleKey)},
            ),
          },
          // A habit to count: not the saved, ma'thur or user's own duas.
          streak: switch (category) {
            LibraryCategory.lastThird || LibraryCategory.sleep => _Streak.night,
            LibraryCategory.morning ||
            LibraryCategory.evening ||
            LibraryCategory.waking => _Streak.day,
            _ => null,
          },
        ),
        OneDua() => null,
      };

  /// What the completion log counts under.
  final String key;

  /// How many duas were read.
  final int count;

  /// Morning or evening adhkar, sleep, waking: counted as adhkar.
  final bool adhkar;

  /// "أتممت أدعية الثلث الأخير من الليل".
  final String Function(BuildContext context) done;

  final _Streak? _streak;

  /// "ليلتك الرابعة هذا الشهر", for the [nth] time this month.
  String? streakText(BuildContext context, int nth) {
    final streak = _streak;
    if (streak == null) return null;
    final language = context.locale.languageCode;
    return context.tr(
      streak.key,
      namedArgs: {
        'ordinal': ordinal(nth, language, feminine: streak.feminine),
      },
    );
  }

  /// "٧ أدعية" / "١٥ ذكرًا".
  String countText(BuildContext context) => context.plural(
    adhkar ? LocaleKeys.library_adhkar_count : LocaleKeys.library_duas_count,
    count,
    args: [localizedDigits(count, context.locale.languageCode)],
  );
}

enum _Streak {
  night(LocaleKeys.completion_streak_night, feminine: true),
  friday(LocaleKeys.completion_streak_friday, feminine: true),
  day(LocaleKeys.completion_streak_day, feminine: false)
  ;

  const _Streak(this.key, {required this.feminine});

  final String key;

  /// ليلة and جمعة take the feminine ordinal; يوم the masculine.
  final bool feminine;
}
