import 'package:orbi_test/src/data/source/local/models/pokemon.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_stats.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';

extension ApiPokemonModelToLocalX on Pokemon {
  PokemonHiveModel toHiveModel() => PokemonHiveModel()
    ..number = id.toString()
    ..name = name.trim()
    ..types = types != null ? types!.map((e) => e.type.name ?? '').toList() : []
    ..height = height?.toString().trim() ?? ''
    ..weight = weight?.toString().trim() ?? ''
    ..baseExp = baseExperience?.toDouble() ?? 0
    ..stats = (PokemonStatsHiveModel()
      ..hp =
          stats?.firstWhere((element) => element.stat.name == 'hp').baseStat ??
              0
      ..speed = stats
              ?.firstWhere((element) => element.stat.name == 'speed')
              .baseStat ??
          0
      ..attack = stats
              ?.firstWhere((element) => element.stat.name == 'attack')
              .baseStat ??
          0
      ..defense = stats
              ?.firstWhere((element) => element.stat.name == 'defense')
              .baseStat ??
          0
      ..specialAttack = stats
              ?.firstWhere((element) => element.stat.name == 'special-attack')
              .baseStat ??
          0
      ..specialDefense = stats
              ?.firstWhere((element) => element.stat.name == 'special-defense')
              .baseStat ??
          0);
}
