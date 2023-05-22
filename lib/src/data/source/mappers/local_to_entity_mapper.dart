import 'package:orbi_test/src/data/source/local/models/pokemon.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_stats.dart';
import 'package:orbi_test/src/domain/entities/general_model.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/stat_model.dart';
import 'package:orbi_test/src/domain/entities/type_model.dart';
import 'package:orbi_test/src/utils/methods.dart';

extension PokemonHiveModelX on PokemonHiveModel {
  Pokemon toEntity() => Pokemon(
        id: int.parse(number.trim()),
        name: name.trim(),
        types: types.map(PokemonTypesX.parse).toList(),
        baseExperience: baseExp.toInt(),
        height: int.parse(height.trim()),
        weight: int.parse(weight.trim()),
        loaded: true,
        isFavourite: true,
        stats: stats.toEntity(),
      );
}

extension PokemonTypesX on Type {
  String get value => getEnumValue(this).capitalize();

  static Type parse(String rawValue) {
    return Type(
      slot: 0,
      type: GeneralData(
        name: rawValue,
        url: '',
      ),
    );
  }
}

extension PokemonStatsHiveModelX on PokemonStatsHiveModel {
  List<Stat> toEntity() {
    final list = <Stat>[
      Stat(
        baseStat: attack,
        effort: 0,
        stat: const GeneralData(url: '', name: 'attack'),
      ),
      Stat(
        baseStat: specialAttack,
        effort: 0,
        stat: const GeneralData(url: '', name: 'special-attack'),
      ),
      Stat(
        baseStat: defense,
        effort: 0,
        stat: const GeneralData(url: '', name: 'defense'),
      ),
      Stat(
        baseStat: specialDefense,
        effort: 0,
        stat: const GeneralData(url: '', name: 'special-defense'),
      ),
      Stat(
        baseStat: attack,
        effort: 0,
        stat: const GeneralData(url: '', name: 'hp'),
      ),
      Stat(
        baseStat: speed,
        effort: 0,
        stat: const GeneralData(url: '', name: 'speed'),
      ),
    ];

    return list;
  }
}

class PokemonStats {
  const PokemonStats({
    required this.attack,
    required this.specialAttack,
    required this.defense,
    required this.specialDefense,
    required this.hp,
    required this.speed,
  });

  final int attack;
  final int specialAttack;
  final int defense;
  final int specialDefense;
  final int hp;
  final int speed;

  int get total =>
      attack + specialAttack + defense + specialDefense + hp + speed;
}
