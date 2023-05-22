// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:orbi_test/src/domain/entities/general_model.dart';

class Stat extends Equatable {
  final int baseStat;
  final int effort;
  final GeneralData stat;

  const Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  @override
  List<Object> get props => [baseStat, effort, stat];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseStat': baseStat,
      'effort': effort,
      'stat': stat.toMap(),
    };
  }

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      baseStat: map['base_stat'] as int,
      effort: map['effort'] as int,
      stat: GeneralData.fromMap(map['stat'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Stat.fromJson(String source) =>
      Stat.fromMap(json.decode(source) as Map<String, dynamic>);
}
