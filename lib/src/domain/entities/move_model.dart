// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:orbi_test/src/domain/entities/general_model.dart';
import 'package:orbi_test/src/domain/entities/version_group_model.dart';

class Move extends Equatable {
  final GeneralData move;
  final List<VersionGroupDetail> versionGroupDetails;

  const Move({
    required this.move,
    required this.versionGroupDetails,
  });

  @override
  List<Object> get props => [move, versionGroupDetails];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'move': move.toMap(),
      'versionGroupDetails': versionGroupDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      move: GeneralData.fromMap(map['move'] as Map<String, dynamic>),
      versionGroupDetails: List<VersionGroupDetail>.from(
        (map['version_group_details'] as List<dynamic>).map<VersionGroupDetail>(
          (x) => VersionGroupDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Move.fromJson(String source) =>
      Move.fromMap(json.decode(source) as Map<String, dynamic>);
}
