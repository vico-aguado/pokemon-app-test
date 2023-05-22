import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/utils/methods.dart';

part 'poke_desk_event.dart';
part 'poke_desk_state.dart';

class PokeDeskBloc extends Bloc<PokeDeskEvent, PokeDeskState> {
  PokeDeskBloc(this.pokemonBloc)
      : super(
          InitialPokeDeskState(
            PokeDeskModel(
              scrollController: ScrollController(),
              searchController: TextEditingController(),
              isFilter: false,
            ),
          ),
        ) {
    on<LoadMoreEvent>(_loadMore);
    on<InitEvent>(_init);
    on<SearchPokemonEvent>(_search);
    on<ClearFilterEvent>(_clear);
  }
  final PokemonBloc pokemonBloc;

  @override
  Future<void> close() async {
    state.model.searchController.dispose();
    state.model.scrollController.removeListener(_scrollListener);
    await super.close();
  }

  void _scrollListener() {
    if (state.model.scrollController.position.atEdge) {
      final isTop = state.model.scrollController.position.pixels == 0;

      if (!isTop) {
        pokemonBloc
            .add(LoadPokemonsEvent(25, pokemonBloc.state.model.actualOffset));
      }
    }
  }

  Future<void> _init(
    InitEvent event,
    Emitter<PokeDeskState> emit,
  ) async {
    state.model.scrollController.addListener(_scrollListener);
  }

  Future<void> _loadMore(
    LoadMoreEvent event,
    Emitter<PokeDeskState> emit,
  ) async {}

  Future<void> _search(
    SearchPokemonEvent event,
    Emitter<PokeDeskState> emit,
  ) async {
    var results = <Pokemon>[];
    var filter = '';

    if (state.model.searchController.text.parseDouble() != 0) {
      filter =
          state.model.searchController.text.parseDouble().ceil().toString();
      results = pokemonBloc.state.model.pokemonsList
          .where(
            (element) =>
                element.id == state.model.searchController.text.parseDouble(),
          )
          .toList();
    } else {
      filter = state.model.searchController.text.trim().toLowerCase();
      results = pokemonBloc.state.model.pokemonsList
          .where(
            (element) =>
                element.name == state.model.searchController.text.toLowerCase(),
          )
          .toList();
    }

    if (results.isEmpty) {
      try {
        final result = await pokemonBloc.repository
            .getPokemon(filter.replaceAll('.0', ''));
        if (result != null) {
          results.add(result.copyWith(loaded: true));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    pokemonBloc.add(SetPokemonsListEvent(results));

    emit(FilterPokeDeskState(state.model.copyWith(isFilter: true)));
  }

  Future<void> _clear(
    ClearFilterEvent event,
    Emitter<PokeDeskState> emit,
  ) async {
    pokemonBloc.add(const LoadPokemonsEvent(25, 0));
    state.model.searchController.text = '';
    emit(FilterPokeDeskState(state.model.copyWith(isFilter: false)));
  }
}
