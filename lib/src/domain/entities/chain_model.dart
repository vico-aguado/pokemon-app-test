import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/domain/entities/evolution_detail_model.dart';
import 'package:orbi_test/src/domain/entities/general_model.dart';

class Chain extends Equatable {
  const Chain({
    this.evolutionDetails,
    this.evolvesTo,
    this.isBaby,
    this.species,
  });

  factory Chain.fromMap(Map<String, dynamic> map) {
    return Chain(
      evolutionDetails: map['evolution_details'] != null
          ? List<EvolutionDetail>.from(
              (map['evolution_details'] as List<dynamic>).map<EvolutionDetail?>(
                (x) => EvolutionDetail.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      evolvesTo: map['evolves_to'] != null
          ? List<Chain>.from(
              (map['evolves_to'] as List<dynamic>).map<Chain?>(
                (x) => Chain.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isBaby: map['is_baby'] != null ? map['is_baby'] as bool : null,
      species: map['species'] != null
          ? GeneralData.fromMap(map['species'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Chain.fromJson(String source) =>
      Chain.fromMap(json.decode(source) as Map<String, dynamic>);
  final List<EvolutionDetail>? evolutionDetails;
  final List<Chain>? evolvesTo;
  final bool? isBaby;
  final GeneralData? species;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'evolutionDetails': evolutionDetails?.map((x) => x.toMap()).toList(),
      'evolvesTo': evolvesTo?.map((x) => x.toMap()).toList(),
      'isBaby': isBaby,
      'species': species?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, isBaby, species];
}
