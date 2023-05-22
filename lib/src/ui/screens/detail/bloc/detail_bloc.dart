import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this.pokemonBloc, this.index)
      : super(InitialDetailState(DetailModel(focusIndex: index))) {
    on<SelectItemEvent>(_init);
    on<ChangeScrollPositionEvent>(_changeScroll);
  }
  final PokemonBloc pokemonBloc;
  final int index;

  Future<void> _init(
    SelectItemEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(ItemSelectedState(state.model.copyWith(focusIndex: event.index)));
  }

  Future<void> _changeScroll(
    ChangeScrollPositionEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(
      ScrollPositionChangedState(
        state.model.copyWith(panelScrollPosition: event.value),
      ),
    );
  }
}
