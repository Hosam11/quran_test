import 'package:equatable/equatable.dart';
import 'package:quran_test/data/model/quran/quran_data/quran_data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'quran_model.g.dart';

@JsonSerializable()
class QuranModel extends Equatable {
  final int? code;
  final String? status;
  final QuranData? data;

  QuranModel({this.code, this.status, this.data});

  factory QuranModel.fromJson(Map<String, dynamic> json) =>
      _$QuranModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuranModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        code,
        status,
        data,
      ];
}
