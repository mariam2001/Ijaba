/// One of the etiquette page's items (Figma ١٥): its title, the hadith or
/// advice, and where it's from — strings `etiquette.<id>_title` / `_body` /
/// `_source` (an empty source shows none). Sources checked in
/// docs/DUA_SOURCES.md ("Etiquette of dua").
class Etiquette {
  const Etiquette(this.id, {this.avoid = false});

  final String id;

  /// Under "ما يُجتنب" (what to avoid) rather than "ما يُستحب".
  final bool avoid;

  String get titleKey => 'etiquette.${id}_title';
  String get bodyKey => 'etiquette.${id}_body';
  String get sourceKey => 'etiquette.${id}_source';
}

const etiquette = [
  Etiquette('praise'),
  Etiquette('certain'),
  Etiquette('resolve'),
  Etiquette('hands'),
  Etiquette('repeat'),
  Etiquette('others'),
  Etiquette('times'),
  Etiquette('haste', avoid: true),
  Etiquette('sin', avoid: true),
  Etiquette('against', avoid: true),
];

/// "١٠ آداب" on Home's entry card.
final etiquetteCount = etiquette.length;

/// Until Mariam signs the sources off, the page keeps the design's footer
/// "المصادر تُراجَع قبل النشر".
const etiquetteVerified = false;
