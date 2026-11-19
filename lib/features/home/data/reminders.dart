import 'package:ijaba/generated/locale_keys.g.dart';

/// A verse for Home's reminder card. The Arabic is cut from the Quran text
/// (api.alquran.cloud, "quran-simple"), ending at a pause mark.
class Reminder {
  const Reminder({
    required this.arabic,
    required this.sourceKey,
    required this.meaningKey,
  });

  final String arabic;
  final String sourceKey;

  /// English only: Arabic mode shows the verse alone.
  final String meaningKey;
}

/// The card shows one, a different one each time the app opens (the
/// design's "يتجدّد كلما فتحت التطبيق"); the first is the design's.
const reminders = [
  Reminder(
    // Al-Baqarah 2:186, to the first pause.
    arabic: 'وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ',
    sourceKey: LocaleKeys.reminders_near_source,
    meaningKey: LocaleKeys.reminders_near_meaning,
  ),
  Reminder(
    // Ghafir 40:60, to the first pause.
    arabic: 'وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ',
    sourceKey: LocaleKeys.reminders_call_source,
    meaningKey: LocaleKeys.reminders_call_meaning,
  ),
  Reminder(
    // Al-A'raf 7:55, to the first pause.
    arabic: 'ادْعُوا رَبَّكُمْ تَضَرُّعًا وَخُفْيَةً',
    sourceKey: LocaleKeys.reminders_humbly_source,
    meaningKey: LocaleKeys.reminders_humbly_meaning,
  ),
];
