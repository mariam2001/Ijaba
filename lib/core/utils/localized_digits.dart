/// Writes [number] in the locale's digits: "٣" in Arabic, "3" otherwise.
/// (intl's plain "ar" locale formats numbers with Latin digits.)
String localizedDigits(int number, String languageCode) =>
    localizedNumerals('$number', languageCode);

/// Replaces the Latin digits in [text] with Arabic-Indic ones in Arabic,
/// e.g. a countdown "1:18" → "١:١٨".
String localizedNumerals(String text, String languageCode) {
  if (languageCode != 'ar') return text;
  return String.fromCharCodes(
    text.codeUnits.map(
      (unit) => unit >= 0x30 && unit <= 0x39 ? unit - 0x30 + 0x0660 : unit,
    ),
  );
}
