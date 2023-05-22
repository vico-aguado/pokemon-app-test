import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/domain/entities/evolutions_model.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';

part 'pokemon_item_event.dart';
part 'pokemon_item_state.dart';

class PokemonItemBloc extends Bloc<PokemonItemEvent, PokemonItemState> {
  PokemonItemBloc(
    this.pokemonBloc,
    this.data,
    this.index,
  ) : super(
          InitialItemState(
            PokemonItemModel(
              data: data,
              index: index,
            ),
          ),
        ) {
    on<LoadItemDataEvent>(_loadData);
    on<SaveItemEvent>(_saveItem);
  }
  final PokemonBloc pokemonBloc;
  final Pokemon data;
  final int index;

  Future<void> _saveItem(
    SaveItemEvent event,
    Emitter<PokemonItemState> emit,
  ) async {
    if (state.model.data.isFavourite) {
      final success = await pokemonBloc.repository
          .deletePokemon(state.model.data.id.toString());

      pokemonBloc
        ..add(
          UpdatePokemonItemEvent(
            state.model.data.id - 1,
            state.model.data.copyWith(isFavourite: false),
          ),
        )
        ..add(ChangeTabEvent(pokemonBloc.state.model.isFavourites ? 1 : 0));

      if (success) {
        emit(
          DeletedItemState(
            state.model
                .copyWith(data: state.model.data.copyWith(isFavourite: false)),
          ),
        );
      } else {
        emit(FailedItemState(state.model, 'Save data error'));
      }
    } else {
      final success =
          await pokemonBloc.repository.savePokemon(state.model.data);

      pokemonBloc.add(
        UpdatePokemonItemEvent(
          index,
          state.model.data.copyWith(isFavourite: true),
        ),
      );

      if (success) {
        emit(
          SavedItemState(
            state.model
                .copyWith(data: state.model.data.copyWith(isFavourite: true)),
          ),
        );
      } else {
        emit(FailedItemState(state.model, 'Save data error'));
      }
    }
  }

  Future<void> _loadData(
    LoadItemDataEvent event,
    Emitter<PokemonItemState> emit,
  ) async {
    if (!state.model.data.loaded) {
      emit(
        LoadingItemState(state.model),
      );

      try {
        var pokemonResult = await pokemonBloc.repository.getPokemon(
          data.id.toString(),
        );

        if (pokemonResult != null) {
          pokemonResult = pokemonResult.copyWith(loaded: true);

          final model = state.model.copyWith(data: pokemonResult);
          pokemonBloc.add(UpdatePokemonItemEvent(index, pokemonResult));
          emit(LoadedItemState(model));

          final specieResult = await pokemonBloc.repository.getPokemonSpecie(
            data.id.toString(),
          );

          if (specieResult != null) {
            final modelSpecie = state.model.copyWith(specie: specieResult);
            pokemonBloc.add(UpdateSpecieItemEvent(index, specieResult));
            emit(LoadedSpecieState(modelSpecie));

            if (specieResult.evolutionChain != null) {
              final evolutionResult =
                  await pokemonBloc.repository.getPokemonEvolutions(
                data.id.toString(),
                specieResult.evolutionChain!.url,
              );

              if (evolutionResult != null) {
                final modelEvolution =
                    state.model.copyWith(evolution: evolutionResult);
                pokemonBloc
                    .add(UpdateEvolutionItemEvent(index, evolutionResult));
                emit(LoadedEvolutionState(modelEvolution));
              }
            }
          }
        } else {
          emit(FailedItemState(state.model, 'No data'));
        }
      } catch (e) {
        emit(FailedItemState(state.model, e.toString()));
      }
    }
  }
}
