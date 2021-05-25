// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahModel _$SurahModelFromJson(Map<String, dynamic> json) {
  return SurahModel(
    number: json['number'] as int?,
    name: json['name'] as String?,
    englishName: json['englishName'] as String?,
    englishNameTranslation: json['englishNameTranslation'] as String?,
    revelationType: json['revelationType'] as String?,
    ayahs: (json['ayahs'] as List<dynamic>?)
        ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SurahModelToJson(SurahModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'englishName': instance.englishName,
      'englishNameTranslation': instance.englishNameTranslation,
      'revelationType': instance.revelationType,
      'ayahs': instance.ayahs,
    };
