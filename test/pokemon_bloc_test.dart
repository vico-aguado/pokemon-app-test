import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/core/data/repositories/pokemon_repository.dart';
import 'package:orbi_test/src/domain/entities/evolutions_model.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  group('[ Pokemon Bloc ]', () {
    late PokemonBloc blocTMP;
    late MockPokemonRepository mockRepository;

    setUp(() {
      mockRepository = MockPokemonRepository();
      blocTMP = PokemonBloc(mockRepository);
    });

    tearDown(() {
      blocTMP.close();
    });

    test('=> Initial call state', () {
      expect(
        blocTMP.state,
        const InitialState(
          PokemonModel(),
        ),
      );
    });

    test('test LoadPokemonsEvent', () {
      const event = LoadPokemonsEvent(25, 0);
      expect(event, equals(const LoadPokemonsEvent(25, 0)));
      expect(event.props, equals([]));
    });

    test('test state', () {
      const model = PokemonModel();
      const state = InitialState(
        model,
      );
      expect(
        state,
        equals(
          const InitialState(
            model,
          ),
        ),
      );
      expect(
          state.props,
          equals([
            model,
          ]));

      final stateCopy = state.model.copyWith();
      expect(stateCopy, equals(model));
    });

    blocTest<PokemonBloc, PokemonState>(
      '=> Initial Bloc',
      build: () => blocTMP,
      verify: (bloc) {
        expect(bloc, equals(blocTMP));
      },
    );

    blocTest<PokemonBloc, PokemonState>(
      '=> UpdatePokemonItemEvent -  State',
      build: () {
        return PokemonBloc(mockRepository);
      },
      act: (bloc) {
        bloc.add(const UpdatePokemonItemEvent(0, Pokemon(id: 1, name: 'test')));
      },
      expect: () => [
        FailState(blocTMP.state.model, ''),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      '=> UpdateSpecieItemEvent -  State',
      build: () {
        return PokemonBloc(mockRepository);
      },
      act: (bloc) {
        bloc.add(UpdateSpecieItemEvent(0, Species()));
      },
      expect: () => [
        FailState(blocTMP.state.model, ''),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      '=> UpdateEvolutionItemEvent -  State',
      build: () {
        return PokemonBloc(mockRepository);
      },
      act: (bloc) {
        bloc.add(const UpdateEvolutionItemEvent(0, Evolutions()));
      },
      expect: () => [
        FailState(blocTMP.state.model, ''),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      '=> SetPokemonsListEvent -  State',
      build: () {
        return PokemonBloc(mockRepository);
      },
      act: (bloc) {
        bloc.add(const SetPokemonsListEvent([]));
      },
      expect: () => [
        PokemonUpdatedState(blocTMP.state.model),
      ],
    );
  });
}
