import 'package:equatable/equatable.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah_model.g.dart';

@JsonSerializable()
class SurahModel extends Equatable {
  final int? number;
  final String? name;
  final String? englishName;
  final String? englishNameTranslation;
  final String? revelationType;
  final List<AyahModel>? ayahs;

  SurahModel({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurahModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        ayahs,
      ];
}
