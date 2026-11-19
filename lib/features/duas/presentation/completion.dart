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
/// ١٤): what was finished, how many duas, and — told the same way as the
/// week on Home (Figma ١٨) — which day of the week this is.
class Completion {
  const Completion._({
    required this.count,
    required this.done,
    required this.adhkar,
  });

  /// For finishing [selection]'s [count] duas; null for one search result.
  static Completion? of(DuaSelection selection, int count) =>
      switch (selection) {
        WindowDuas(:final window?) => Completion._(
          count: count,
          adhkar: _isAdhkar(window),
          done: (context) => context.tr(
            _isAdhkar(window)
                ? LocaleKeys.completion_done_shelf
                : LocaleKeys.completion_done_window,
            namedArgs: {'name': context.tr(windowNameKey(window))},
          ),
        ),
        WindowDuas() => null,
        CategoryDuas(:final category) => Completion._(
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
        ),
        OneDua() => null,
      };

  static bool _isAdhkar(DuaWindowType window) =>
      window == DuaWindowType.morningAdhkar ||
      window == DuaWindowType.eveningAdhkar;

  /// How many duas were read.
  final int count;

  /// Morning or evening adhkar, sleep, waking: counted as adhkar.
  final bool adhkar;

  /// "أتممت أدعية الثلث الأخير من الليل".
  final String Function(BuildContext context) done;

  /// "يومك الرابع هذا الأسبوع", for the [nth] day done this week.
  String weekText(BuildContext context, int nth) => context.tr(
    LocaleKeys.completion_streak_week,
    namedArgs: {'ordinal': ordinal(nth, context.locale.languageCode)},
  );

  /// "٧ أدعية" / "١٥ ذكرًا".
  String countText(BuildContext context) => context.plural(
    adhkar ? LocaleKeys.library_adhkar_count : LocaleKeys.library_duas_count,
    count,
    args: [localizedDigits(count, context.locale.languageCode)],
  );
}
