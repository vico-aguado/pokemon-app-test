part of 'pokemon_item_bloc.dart';

abstract class PokemonItemState extends Equatable {
  const PokemonItemState(this.model);
  final PokemonItemModel model;

  @override
  List<Object> get props => [];
}

class InitialItemState extends PokemonItemState {
  const InitialItemState(super.model);
}

class LoadingItemState extends PokemonItemState {
  const LoadingItemState(super.model);
}

class LoadedItemState extends PokemonItemState {
  const LoadedItemState(super.model);
}

class LoadedSpecieState extends PokemonItemState {
  const LoadedSpecieState(super.model);
}

class LoadedEvolutionState extends PokemonItemState {
  const LoadedEvolutionState(super.model);
}

class FailedItemState extends PokemonItemState {
  const FailedItemState(super.model, this.error);
  final String error;
}

class SavedItemState extends PokemonItemState {
  const SavedItemState(super.model);
}

class DeletedItemState extends PokemonItemState {
  const DeletedItemState(super.model);
}

class PokemonItemModel extends Equatable {
  const PokemonItemModel({
    required this.data,
    required this.index,
    this.specie,
    this.evolution,
  });
  final Pokemon data;
  final Species? specie;
  final Evolutions? evolution;
  final int index;

  PokemonItemModel copyWith({
    Pokemon? data,
    int? index,
    Species? specie,
    Evolutions? evolution,
  }) {
    return PokemonItemModel(
      data: data ?? this.data,
      index: index ?? this.index,
      specie: specie ?? this.specie,
      evolution: evolution ?? this.evolution,
    );
  }

  @override
  List<Object?> get props => [
        data,
        index,
        specie,
        evolution,
      ];
}
