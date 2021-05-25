import 'package:quran_test/data/model/quran/surah_model/surah_model.dart';

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'quran_data.g.dart';

@JsonSerializable()
class QuranData extends Equatable {
  final List<SurahModel>? surahs;

  QuranData({this.surahs});

  factory QuranData.fromJson(Map<String, dynamic> json) =>
      _$QuranDataFromJson(json);

  Map<String, dynamic> toJson() => _$QuranDataToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [surahs];
}
