// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranModel _$QuranModelFromJson(Map<String, dynamic> json) => QuranModel(
      code: json['code'] as int?,
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : QuranData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuranModelToJson(QuranModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
