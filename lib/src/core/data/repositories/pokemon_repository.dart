import 'package:flutter/foundation.dart';
import 'package:orbi_test/src/data/source/local/local_source.dart';
import 'package:orbi_test/src/data/source/mappers/local_to_entity_mapper.dart';
import 'package:orbi_test/src/data/source/mappers/remote_to_local_mapper.dart';
import 'package:orbi_test/src/data/source/remote/api_source.dart';
import 'package:orbi_test/src/domain/entities/evolutions_model.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({required int limit, required int offset});
  Future<Pokemon?> getPokemon(String number);
  Future<bool> savePokemon(Pokemon pokemon);
  Future<bool> deletePokemon(String number);
  Future<List<Pokemon>> getFavourites();
  Future<Species?> getPokemonSpecie(String id);
  Future<Evolutions?> getPokemonEvolutions(String id, String url);
}

class PokemonDefaultRepository extends PokemonRepository {
  PokemonDefaultRepository({
    required this.apiDataSource,
    required this.localDataSource,
  });

  final ApiDataSource apiDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<List<Pokemon>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    final pokemonApiModels = await apiDataSource.getPokemons(limit, offset);
    return pokemonApiModels;
  }

  @override
  Future<Pokemon?> getPokemon(String number) async {
    try {
      final pokemonLocalModel = await localDataSource.getPokemon(number);

      if (pokemonLocalModel == null) {
        final pokemonApiModel = await apiDataSource.getPokemon(number);
        return pokemonApiModel;
      } else {
        return pokemonLocalModel
            .toEntity()
            .copyWith(isFavourite: true, loaded: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  @override
  Future<bool> savePokemon(Pokemon pokemon) async {
    try {
      await localDataSource.savePokemons([pokemon.toHiveModel()]);
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  @override
  Future<bool> deletePokemon(String number) async {
    try {
      await localDataSource.deletePokemon(number);
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  @override
  Future<List<Pokemon>> getFavourites() async {
    try {
      final pokemonLocalModels = await localDataSource.getAllPokemons();

      if (pokemonLocalModels.isNotEmpty) {
        return pokemonLocalModels
            .map((e) => e.toEntity().copyWith(isFavourite: true, loaded: true))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  @override
  Future<Species?> getPokemonSpecie(String id) async {
    try {
      final specieApiModel = await apiDataSource.getPokemonSpecie(id);
      return specieApiModel;
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  @override
  Future<Evolutions?> getPokemonEvolutions(String id, String url) async {
    try {
      final evolutionApiModel =
          await apiDataSource.getPokemonEvolutions(id, url);
      return evolutionApiModel;
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}
