// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/domain/entities/general_model.dart';

class Name extends Equatable {
  final GeneralData? language;
  final String? name;

  const Name({
    this.language,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language?.toMap(),
      'name': name,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      language: map['language'] != null
          ? GeneralData.fromMap(map['language'] as Map<String, dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) =>
      Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [language, name];
}
