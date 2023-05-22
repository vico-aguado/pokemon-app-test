part of 'poke_desk_bloc.dart';

abstract class PokeDeskEvent extends Equatable {
  const PokeDeskEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreEvent extends PokeDeskEvent {
  const LoadMoreEvent();
}

class InitEvent extends PokeDeskEvent {
  const InitEvent();
}

class SearchPokemonEvent extends PokeDeskEvent {
  const SearchPokemonEvent();
}

class ClearFilterEvent extends PokeDeskEvent {
  const ClearFilterEvent();
}
