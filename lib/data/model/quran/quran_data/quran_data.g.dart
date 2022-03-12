// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranData _$QuranDataFromJson(Map<String, dynamic> json) => QuranData(
      surahs: (json['surahs'] as List<dynamic>?)
          ?.map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuranDataToJson(QuranData instance) => <String, dynamic>{
      'surahs': instance.surahs,
    };
