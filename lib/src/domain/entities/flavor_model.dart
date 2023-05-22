// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:orbi_test/src/domain/entities/general_model.dart';

class FlavorTextEntry extends Equatable {
  final String? flavorText;
  final GeneralData? language;
  final GeneralData? version;

  const FlavorTextEntry({
    this.flavorText,
    this.language,
    this.version,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flavorText': flavorText,
      'language': language?.toMap(),
      'version': version?.toMap(),
    };
  }

  factory FlavorTextEntry.fromMap(Map<String, dynamic> map) {
    return FlavorTextEntry(
      flavorText:
          map['flavor_text'] != null ? map['flavor_text'] as String : null,
      language: map['language'] != null
          ? GeneralData.fromMap(map['language'] as Map<String, dynamic>)
          : null,
      version: map['version'] != null
          ? GeneralData.fromMap(map['version'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorTextEntry.fromJson(String source) =>
      FlavorTextEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        flavorText,
        language,
        version,
      ];
}
