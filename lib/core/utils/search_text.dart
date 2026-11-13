final _marks = RegExp('[ً-ٰٟـۖ-ۭ]');

/// Text as search compares it: lowercase, without Arabic harakat, tatweel or
/// Quranic marks, and with one form of alef, yaa and taa marbuta — so
/// "الاسكندريه" finds "الإسكندرية" and "عفو" finds "عَفُوٌّ".
String searchable(String text) => text
    .toLowerCase()
    .replaceAll(_marks, '')
    .replaceAll(RegExp('[إأآٱ]'), 'ا')
    .replaceAll('ى', 'ي')
    .replaceAll('ة', 'ه')
    .trim();
