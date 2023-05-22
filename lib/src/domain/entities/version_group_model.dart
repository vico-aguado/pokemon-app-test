// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:orbi_test/src/domain/entities/general_model.dart';

class VersionGroupDetail extends Equatable {
  final int levelLearnedAt;
  final GeneralData moveLearnMethod;
  final GeneralData versionGroup;

  const VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  @override
  List<Object> get props => [levelLearnedAt, moveLearnMethod, versionGroup];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'levelLearnedAt': levelLearnedAt,
      'moveLearnMethod': moveLearnMethod.toMap(),
      'versionGroup': versionGroup.toMap(),
    };
  }

  factory VersionGroupDetail.fromMap(Map<String, dynamic> map) {
    return VersionGroupDetail(
      levelLearnedAt: map['level_learned_at'] as int,
      moveLearnMethod:
          GeneralData.fromMap(map['move_learn_method'] as Map<String, dynamic>),
      versionGroup:
          GeneralData.fromMap(map['version_group'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionGroupDetail.fromJson(String source) =>
      VersionGroupDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
