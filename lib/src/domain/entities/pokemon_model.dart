import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/domain/entities/move_model.dart';
import 'package:orbi_test/src/domain/entities/stat_model.dart';
import 'package:orbi_test/src/domain/entities/type_model.dart';

class Pokemon extends Equatable {
  const Pokemon({
    this.baseExperience,
    this.height,
    required this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    required this.name,
    this.order,
    this.stats,
    this.types,
    this.weight,
    this.loaded = false,
    this.isFavourite = false,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    final idTMP = (map['url'] ?? '').toString().split('/');

    return Pokemon(
      id: idTMP.length > 1 ? int.parse(idTMP[6]) : map['id'] as int,
      name: map['name'] as String,
      baseExperience: (map['base_experience'] ?? 0) as int,
      height: (map['height'] ?? 0) as int,
      isDefault: (map['is_default'] ?? false) as bool,
      locationAreaEncounters: (map['location_area_encounters'] ?? '') as String,
      moves: map['moves'] != null
          ? List<Move>.from(
              (map['moves'] as List<dynamic>).map<Move>(
                (x) => Move.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      order: (map['order'] ?? 0) as int,
      stats: map['stats'] != null
          ? List<Stat>.from(
              (map['stats'] as List<dynamic>).map<Stat>(
                (x) => Stat.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      types: map['types'] != null
          ? List<Type>.from(
              (map['types'] as List<dynamic>).map<Type>(
                (x) => Type.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      weight: (map['weight'] ?? 0) as int,
    );
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);
  final int? baseExperience;
  final int? height;
  final int id;
  final bool? isDefault;
  final String? locationAreaEncounters;
  final List<Move>? moves;
  final String name;
  final int? order;
  final List<Stat>? stats;
  final List<Type>? types;
  final int? weight;
  final bool loaded;
  final bool isFavourite;

  @override
  List<Object?> get props {
    return [
      baseExperience,
      height,
      id,
      isDefault,
      locationAreaEncounters,
      moves,
      name,
      order,
      stats,
      types,
      weight,
      loaded,
      isFavourite,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseExperience': baseExperience,
      'height': height,
      'id': id,
      'isDefault': isDefault,
      'locationAreaEncounters': locationAreaEncounters,
      'moves': moves?.map((x) => x.toMap()).toList(),
      'name': name,
      'order': order,
      'stats': stats?.map((x) => x.toMap()).toList(),
      'types': types?.map((x) => x.toMap()).toList(),
      'weight': weight,
    };
  }

  String toJson() => json.encode(toMap());

  Pokemon copyWith({
    int? baseExperience,
    int? height,
    int? id,
    bool? isDefault,
    String? locationAreaEncounters,
    List<Move>? moves,
    String? name,
    int? order,
    List<Stat>? stats,
    List<Type>? types,
    int? weight,
    bool? loaded,
    bool? isFavourite,
  }) {
    return Pokemon(
      baseExperience: baseExperience ?? this.baseExperience,
      height: height ?? this.height,
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
      locationAreaEncounters:
          locationAreaEncounters ?? this.locationAreaEncounters,
      moves: moves ?? this.moves,
      name: name ?? this.name,
      order: order ?? this.order,
      stats: stats ?? this.stats,
      types: types ?? this.types,
      weight: weight ?? this.weight,
      loaded: loaded ?? this.loaded,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
