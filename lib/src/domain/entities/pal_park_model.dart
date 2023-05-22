// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/domain/entities/general_model.dart';

class PalParkEncounter extends Equatable {
  final GeneralData? area;
  final int? baseScore;
  final int? rate;

  const PalParkEncounter({
    this.area,
    this.baseScore,
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'area': area?.toMap(),
      'baseScore': baseScore,
      'rate': rate,
    };
  }

  factory PalParkEncounter.fromMap(Map<String, dynamic> map) {
    return PalParkEncounter(
      area: map['area'] != null
          ? GeneralData.fromMap(map['area'] as Map<String, dynamic>)
          : null,
      baseScore: map['base_score'] != null ? map['base_score'] as int : null,
      rate: map['rate'] != null ? map['rate'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PalParkEncounter.fromJson(String source) =>
      PalParkEncounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [area, baseScore, rate];
}
