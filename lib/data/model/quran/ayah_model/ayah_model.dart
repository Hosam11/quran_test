import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'ayah_model.g.dart';

@JsonSerializable()
class AyahModel extends Equatable {
  final int? number;
  final String? text;
  final int? numberInSurah;
  final int? juz;
  final int? manzil;
  final int? page;
  final int? ruku;
  final int? hizbQuarter;
  final dynamic sajda;
  String? surahName;

  AyahModel({
    this.number,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
    this.surahName,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) =>
      _$AyahModelFromJson(json);

  Map<String, dynamic> toJson() => _$AyahModelToJson(this);

  @override
  bool get stringify => true;

  String? calcAyahWithQuarter() {
    var ayahWordList = text?.split(' ');
    var halfLen = (ayahWordList!.length / 2).round();

    var firAyahs = ayahWordList.sublist(0, halfLen + 1);
    return '$hizbQuarter - ${firAyahs.join(' ')}';
  }

  @override
  String toString() {
    return 'AyahModel{number: $number, text: $text, numberInSurah: $numberInSurah, juz: $juz, manzil: $manzil, page: $page, ruku: $ruku, hizbQuarter: $hizbQuarter, sajda: $sajda, surahName: $surahName}';
  }

  @override
  List<Object?> get props => [
        number,
        text,
        numberInSurah,
        juz,
        manzil,
        page,
        ruku,
        hizbQuarter,
        sajda,
        surahName,
      ];
}
