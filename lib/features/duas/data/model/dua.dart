import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

part 'dua.freezed.dart';
part 'dua.g.dart';

/// One dua from the bundled `assets/data/duas.json`. The Arabic never
/// changes with the language; the meaning and source come in each language.
@freezed
abstract class Dua with _$Dua {
  const Dua._();

  const factory Dua({
    required String id,
    required String arabic,

    /// Simple Latin spelling, shown in English mode.
    required String transliteration,

    /// By language code: "en", and optionally "ar" (a plain-Arabic
    /// rendering; none yet for most duas, so Arabic mode shows none).
    required Map<String, String> meaning,

    /// The attribution, by language code. Shown with a "verify" flag until
    /// [verified] — Mariam checks every source before release.
    @Default({}) Map<String, String> source,
    @Default(false) bool verified,

    /// Where to check the source (sunnah.com, quran.com) — for review, not
    /// shown in the app.
    String? url,

    /// Times to repeat it (the tasbih counter's target).
    @Default(1) int repeat,

    /// Windows it belongs to; none means any window.
    @Default([]) List<DuaWindowType> windows,

    /// A general supplication, for any time — the Library's "ma'thur duas".
    @Default(false) bool general,
  }) = _Dua;

  factory Dua.fromJson(Json json) => _$DuaFromJson(json);

  /// The meaning in [languageCode]; empty when there's none in it.
  String meaningIn(String languageCode) => meaning[languageCode] ?? '';

  String? sourceIn(String languageCode) => source[languageCode] ?? source['ar'];
}
