import 'package:ijaba/core/utils/localized_digits.dart';

/// "الرابعة" / "4th": [n] as an ordinal word, to go after a noun ("ليلتك
/// الرابعة"). Arabic agrees with the noun's gender — [feminine] for ليلة
/// and جمعة, masculine for يوم — and runs to 31 (a month); past that, or
/// in English, it's the figure with a suffix.
String ordinal(int n, String languageCode, {bool feminine = false}) {
  if (languageCode == 'ar' && n >= 1 && n <= 31) {
    return (feminine ? _arabicFeminine : _arabicMasculine)[n - 1];
  }
  if (languageCode == 'ar') return localizedDigits(n, languageCode);
  final teens = n % 100 >= 11 && n % 100 <= 13;
  final suffix = teens
      ? 'th'
      : switch (n % 10) {
          1 => 'st',
          2 => 'nd',
          3 => 'rd',
          _ => 'th',
        };
  return '$n$suffix';
}

const _units = [
  'الحادي',
  'الثاني',
  'الثالث',
  'الرابع',
  'الخامس',
  'السادس',
  'السابع',
  'الثامن',
  'التاسع',
];
const _unitsF = [
  'الحادية',
  'الثانية',
  'الثالثة',
  'الرابعة',
  'الخامسة',
  'السادسة',
  'السابعة',
  'الثامنة',
  'التاسعة',
];

final _arabicMasculine = [
  'الأول',
  'الثاني',
  'الثالث',
  'الرابع',
  'الخامس',
  'السادس',
  'السابع',
  'الثامن',
  'التاسع',
  'العاشر',
  for (final unit in _units) '$unit عشر',
  'العشرون',
  for (final unit in _units) '$unit والعشرون',
  'الثلاثون',
  'الحادي والثلاثون',
];

final _arabicFeminine = [
  'الأولى',
  'الثانية',
  'الثالثة',
  'الرابعة',
  'الخامسة',
  'السادسة',
  'السابعة',
  'الثامنة',
  'التاسعة',
  'العاشرة',
  for (final unit in _unitsF) '$unit عشرة',
  'العشرون',
  for (final unit in _unitsF) '$unit والعشرون',
  'الثلاثون',
  'الحادية والثلاثون',
];
