// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  final PokemonModel model;
  const PokemonState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends PokemonState {
  const InitialState(super.model);
}

class LoadingState extends PokemonState {
  const LoadingState(super.model);
}

class FailState extends PokemonState {
  final String error;
  const FailState(super.model, this.error);
}

class PokemonsLoadedState extends PokemonState {
  const PokemonsLoadedState(super.model);
}

class PokemonUpdatedState extends PokemonState {
  const PokemonUpdatedState(super.model);
}

class SpecieUpdatedState extends PokemonState {
  const SpecieUpdatedState(super.model);
}

class EvolutionUpdatedState extends PokemonState {
  const EvolutionUpdatedState(super.model);
}

class TabChangedState extends PokemonState {
  const TabChangedState(super.model);
}

class PokemonModel extends Equatable {
  final bool isFavourites;
  final int actualOffset;
  final List<Pokemon> pokemonsList;
  final List<Pokemon> favoriteList;
  final List<Species> speciesList;
  final List<Evolutions> evolutionsList;

  const PokemonModel({
    this.isFavourites = false,
    this.actualOffset = 0,
    this.pokemonsList = const [],
    this.favoriteList = const [],
    this.speciesList = const [],
    this.evolutionsList = const [],
  });

  PokemonModel copyWith({
    bool? isFavourites,
    int? actualOffset,
    List<Pokemon>? pokemonsList,
    List<Pokemon>? favoriteList,
    List<Species>? speciesList,
    List<Evolutions>? evolutionsList,
  }) {
    return PokemonModel(
      isFavourites: isFavourites ?? this.isFavourites,
      actualOffset: actualOffset ?? this.actualOffset,
      pokemonsList: pokemonsList ?? this.pokemonsList,
      favoriteList: favoriteList ?? this.favoriteList,
      speciesList: speciesList ?? this.speciesList,
      evolutionsList: evolutionsList ?? this.evolutionsList,
    );
  }

  @override
  List<Object> get props => [
        isFavourites,
        actualOffset,
        pokemonsList,
        favoriteList,
        speciesList,
        evolutionsList,
      ];
}
