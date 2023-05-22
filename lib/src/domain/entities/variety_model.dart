import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/domain/entities/general_model.dart';

class Variety extends Equatable {
  const Variety({
    this.isDefault,
    this.pokemon,
  });

  factory Variety.fromMap(Map<String, dynamic> map) {
    return Variety(
      isDefault: map['is_default'] != null ? map['is_default'] as bool : null,
      pokemon: map['pokemon'] != null
          ? GeneralData.fromMap(map['pokemon'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Variety.fromJson(String source) =>
      Variety.fromMap(json.decode(source) as Map<String, dynamic>);
  final bool? isDefault;
  final GeneralData? pokemon;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDefault': isDefault,
      'pokemon': pokemon?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [isDefault, pokemon];
}
