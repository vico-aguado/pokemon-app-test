// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:orbi_test/src/domain/entities/general_model.dart';

class Genus extends Equatable {
  final String? genus;
  final GeneralData? language;

  const Genus({
    this.genus,
    this.language,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genus': genus,
      'language': language?.toMap(),
    };
  }

  factory Genus.fromMap(Map<String, dynamic> map) {
    return Genus(
      genus: map['genus'] != null ? map['genus'] as String : null,
      language: map['language'] != null
          ? GeneralData.fromMap(map['language'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Genus.fromJson(String source) =>
      Genus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        genus,
        language,
      ];
}
