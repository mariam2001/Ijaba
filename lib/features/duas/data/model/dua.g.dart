// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dua _$DuaFromJson(Map<String, dynamic> json) => _Dua(
  id: json['id'] as String,
  arabic: json['arabic'] as String,
  transliteration: json['transliteration'] as String,
  meaning: Map<String, String>.from(json['meaning'] as Map),
  source:
      (json['source'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  verified: json['verified'] as bool? ?? false,
  repeat: (json['repeat'] as num?)?.toInt() ?? 1,
  windows:
      (json['windows'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DuaWindowTypeEnumMap, e))
          .toList() ??
      const [],
);

Map<String, dynamic> _$DuaToJson(_Dua instance) => <String, dynamic>{
  'id': instance.id,
  'arabic': instance.arabic,
  'transliteration': instance.transliteration,
  'meaning': instance.meaning,
  'source': instance.source,
  'verified': instance.verified,
  'repeat': instance.repeat,
  'windows': instance.windows.map((e) => _$DuaWindowTypeEnumMap[e]!).toList(),
};

const _$DuaWindowTypeEnumMap = {
  DuaWindowType.lastThirdOfNight: 'lastThirdOfNight',
  DuaWindowType.adhanToIqama: 'adhanToIqama',
  DuaWindowType.afterPrayer: 'afterPrayer',
  DuaWindowType.fridayHour: 'fridayHour',
  DuaWindowType.morningAdhkar: 'morningAdhkar',
  DuaWindowType.eveningAdhkar: 'eveningAdhkar',
};
