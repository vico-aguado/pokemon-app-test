import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_adapter.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_stats.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_stats_adapter.dart';

class LocalDataSource {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter<PokemonHiveModel>(PokemonHiveModelAdapter());
    Hive.registerAdapter<PokemonStatsHiveModel>(PokemonStatsHiveModelAdapter());

    await Hive.openBox<PokemonHiveModel>(PokemonHiveModel.boxKey);
    await Hive.openBox<PokemonStatsHiveModel>(PokemonStatsHiveModel.boxKey);
  }

  Future<bool> hasData() async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);
    return pokemonBox.length > 0;
  }

  Future<void> savePokemons(Iterable<PokemonHiveModel> pokemons) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);
    final pokemonsMap = {for (var e in pokemons) e.number: e};
    await pokemonBox.putAll(pokemonsMap);
  }

  Future<void> deletePokemon(String number) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);
    await pokemonBox.delete(number);
  }

  Future<List<PokemonHiveModel>> getAllPokemons() async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);

    final pokemons = List.generate(pokemonBox.length, pokemonBox.getAt)
        .whereType<PokemonHiveModel>()
        .toList();

    return pokemons;
  }

  Future<List<PokemonHiveModel>> getPokemons({
    required int page,
    required int limit,
  }) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);
    final totalPokemons = pokemonBox.length;

    final start = (page - 1) * limit;
    final newPokemonCount = min(totalPokemons - start, limit);

    final pokemons = List.generate(
      newPokemonCount,
      (index) => pokemonBox.getAt(start + index),
    ).whereType<PokemonHiveModel>().toList();

    return pokemons;
  }

  Future<PokemonHiveModel?> getPokemon(String number) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);
    return pokemonBox.get(number);
  }
}
