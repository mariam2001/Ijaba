/// Writes [number] in the locale's digits: "٣" in Arabic, "3" otherwise.
/// (intl's plain "ar" locale formats numbers with Latin digits.)
String localizedDigits(int number, String languageCode) {
  final latin = '$number';
  if (languageCode != 'ar') return latin;
  return String.fromCharCodes(
    latin.codeUnits.map((unit) => unit - 0x30 + 0x0660),
  );
}
