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

    /// By language code: "ar" (a plain-Arabic rendering) and "en".
    required Map<String, String> meaning,

    /// The attribution, by language code. Shown with a "verify" flag until
    /// [verified] — Mariam checks every source before release.
    @Default({}) Map<String, String> source,
    @Default(false) bool verified,

    /// Times to repeat it (the tasbih counter's target).
    @Default(1) int repeat,

    /// Windows it belongs to; none means any window.
    @Default([]) List<DuaWindowType> windows,
  }) = _Dua;

  factory Dua.fromJson(Json json) => _$DuaFromJson(json);

  String meaningIn(String languageCode) =>
      meaning[languageCode] ?? meaning['ar'] ?? '';

  String? sourceIn(String languageCode) => source[languageCode] ?? source['ar'];
}
