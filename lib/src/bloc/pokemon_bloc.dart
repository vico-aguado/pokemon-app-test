import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/core/data/repositories/pokemon_repository.dart';
import 'package:orbi_test/src/domain/entities/evolutions_model.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this.repository) : super(const InitialState(PokemonModel())) {
    on<LoadPokemonsEvent>(_loadPokemons);
    on<UpdatePokemonItemEvent>(_updatePokemon);
    on<SetPokemonsListEvent>(_setListPokemon);
    on<ChangeTabEvent>(_changeTab);
    on<UpdateSpecieItemEvent>(_updateSpecie);
    on<UpdateEvolutionItemEvent>(_updateEvolution);
  }
  final PokemonRepository repository;

  Future<void> _loadPokemons(
    LoadPokemonsEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(
      LoadingState(state.model),
    );

    try {
      final result = await repository.getPokemons(
        limit: event.limit,
        offset: event.offset,
      );

      var list = <Pokemon>[];
      var speciesList = <Species>[];
      var evolutionsList = <Evolutions>[];

      if (event.offset != 0) {
        list = List<Pokemon>.from(state.model.pokemonsList);
        speciesList = List<Species>.from(state.model.speciesList);
        evolutionsList = List<Evolutions>.from(state.model.evolutionsList);
      }

      list.addAll(result);
      speciesList.addAll(List<Species>.generate(25, (index) => Species()));
      evolutionsList
          .addAll(List<Evolutions>.generate(25, (index) => const Evolutions()));

      final model = state.model.copyWith(
        actualOffset: event.offset + 25,
        pokemonsList: list,
        speciesList: speciesList,
        evolutionsList: evolutionsList,
      );

      emit(PokemonsLoadedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }

  Future<void> _updatePokemon(
    UpdatePokemonItemEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      final list = List<Pokemon>.from(state.model.pokemonsList);

      list[event.index] = event.data;

      final model = state.model.copyWith(pokemonsList: list);

      emit(PokemonUpdatedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }

  Future<void> _setListPokemon(
    SetPokemonsListEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      final model = state.model.copyWith(pokemonsList: event.data);
      emit(PokemonUpdatedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }

  Future<void> _changeTab(
    ChangeTabEvent event,
    Emitter<PokemonState> emit,
  ) async {
    var result = <Pokemon>[];

    emit(TabChangedState(state.model.copyWith(isFavourites: event.tab == 1)));

    if (event.tab == 1) {
      emit(
        LoadingState(state.model),
      );

      await Future.delayed(const Duration(milliseconds: 100), () {});

      result = await repository.getFavourites();

      final model = state.model.copyWith(favoriteList: result);

      emit(PokemonsLoadedState(model));
    } else {
      if (state.model.pokemonsList.isEmpty ||
          state.model.pokemonsList.length < 10) {
        add(const LoadPokemonsEvent(25, 0));
      }
    }
  }

  Future<void> _updateSpecie(
    UpdateSpecieItemEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      final list = List<Species>.from(state.model.speciesList);

      list[event.index] = event.data;

      final model = state.model.copyWith(speciesList: list);

      emit(SpecieUpdatedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }

  Future<void> _updateEvolution(
    UpdateEvolutionItemEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      final list = List<Evolutions>.from(state.model.evolutionsList);

      list[event.index] = event.data;

      final model = state.model.copyWith(evolutionsList: list);

      emit(EvolutionUpdatedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }
}
