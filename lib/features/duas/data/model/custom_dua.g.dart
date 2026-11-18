// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_dua.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomDua _$CustomDuaFromJson(Map<String, dynamic> json) => _CustomDua(
  id: json['id'] as String,
  text: json['text'] as String,
  windows:
      (json['windows'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DuaWindowTypeEnumMap, e))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CustomDuaToJson(
  _CustomDua instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
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
