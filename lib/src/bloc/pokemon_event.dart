part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemonsEvent extends PokemonEvent {
  const LoadPokemonsEvent(
    this.limit,
    this.offset,
  );
  final int limit;
  final int offset;
}

class UpdatePokemonItemEvent extends PokemonEvent {
  const UpdatePokemonItemEvent(
    this.index,
    this.data,
  );
  final int index;
  final Pokemon data;
}

class UpdateSpecieItemEvent extends PokemonEvent {
  const UpdateSpecieItemEvent(
    this.index,
    this.data,
  );
  final int index;
  final Species data;
}

class UpdateEvolutionItemEvent extends PokemonEvent {
  const UpdateEvolutionItemEvent(
    this.index,
    this.data,
  );
  final int index;
  final Evolutions data;
}

class SetPokemonsListEvent extends PokemonEvent {
  const SetPokemonsListEvent(
    this.data,
  );
  final List<Pokemon> data;
}

class ChangeTabEvent extends PokemonEvent {
  const ChangeTabEvent(
    this.tab,
  );
  final int tab;
}
