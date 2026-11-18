import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

part 'custom_dua.freezed.dart';
part 'custom_dua.g.dart';

/// A dua the user wrote ("My duas"), kept only on the phone. It shows on
/// the Dua screen of each window in [windows], after the sourced duas.
@freezed
abstract class CustomDua with _$CustomDua {
  const CustomDua._();

  const factory CustomDua({
    required String id,
    required String text,
    @Default([]) List<DuaWindowType> windows,
  }) = _CustomDua;

  factory CustomDua.fromJson(Json json) => _$CustomDuaFromJson(json);

  /// The windows a new dua joins unless changed: those where dua is most
  /// likely answered, not the morning and evening adhkar.
  static const defaultWindows = [
    DuaWindowType.lastThirdOfNight,
    DuaWindowType.adhanToIqama,
    DuaWindowType.afterPrayer,
    DuaWindowType.fridayHour,
  ];

  /// As the Dua screen and Library read duas: no source, transliteration or
  /// meaning — just the user's words.
  Dua toDua() => Dua(
    id: id,
    arabic: text,
    transliteration: '',
    meaning: const {},
    windows: windows,
    mine: true,
  );
}
