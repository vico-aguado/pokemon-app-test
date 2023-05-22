import 'package:orbi_test/src/config/constants.dart';
import 'package:orbi_test/src/core/network.dart';
import 'package:orbi_test/src/domain/entities/evolutions_model.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';

class ApiDataSource {
  ApiDataSource(this.networkManager);

  final NetworkManager networkManager;

  Future<List<Pokemon>> getPokemons(int limit, int offset) async {
    final response = await networkManager.request<Map<String, dynamic>>(
      RequestMethod.get,
      '${AppConstants.urlBase}pokemon?limit=$limit&offset=$offset',
    );

    if (response.statusCode == 200 &&
        response.data != null &&
        response.data!['results'] != null) {
      final results = response.data!['results'] as List;
      if (results.isNotEmpty) {
        return results
            .map(
              (item) => Pokemon.fromMap(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Ocurrio un error, vuelva a intentar por favor');
    }
  }

  Future<Pokemon> getPokemon(String id) async {
    final response = await networkManager.request<Map<String, dynamic>>(
      RequestMethod.get,
      '${AppConstants.urlBase}pokemon/$id',
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = Pokemon.fromMap(response.data!);
      return data;
    } else {
      throw Exception('Ocurrio un error, vuelva a intentar por favor');
    }
  }

  Future<Species> getPokemonSpecie(String id) async {
    final response = await networkManager.request<Map<String, dynamic>>(
      RequestMethod.get,
      '${AppConstants.urlBase}pokemon-species/$id',
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = Species.fromMap(response.data!);
      return data;
    } else {
      throw Exception('Ocurrio un error, vuelva a intentar por favor');
    }
  }

  Future<Evolutions> getPokemonEvolutions(String id, String url) async {
    final response = await networkManager.request<Map<String, dynamic>>(
      RequestMethod.get,
      url,
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = Evolutions.fromMap(response.data!);
      return data;
    } else {
      throw Exception('Ocurrio un error, vuelva a intentar por favor');
    }
  }
}
