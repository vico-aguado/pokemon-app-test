// ignore_for_file: deprecated_member_use

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/ui/screens/pokedex/bloc/poke_desk_bloc.dart';
import 'package:orbi_test/src/ui/screens/pokedex/widgets/search_modal.dart';
import 'package:orbi_test/src/ui/widgets/gridItem/grid_item_widget.dart';
import 'package:orbi_test/src/ui/widgets/no_data_widget.dart';
import 'package:orbi_test/src/ui/widgets/rotate_pokeball_widget.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class PokedeskScreen extends StatelessWidget {
  const PokedeskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonBloc = context.read<PokemonBloc>();

    return BlocProvider<PokeDeskBloc>(
      create: (context) => PokeDeskBloc(pokemonBloc)..add(const InitEvent()),
      child: BlocBuilder<PokeDeskBloc, PokeDeskState>(
        builder: (context, stateDesk) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showSearchModal(
                  context,
                  stateDesk.model.searchController,
                  context.read<PokeDeskBloc>(),
                );
              },
              backgroundColor: AppColors.fab,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  width: 270,
                  height: 270,
                  top: -58,
                  right: -86,
                  child: SvgPicture.asset(
                    'assets/images/pokeball.svg',
                    color: AppColors.primary.withOpacity(0.05),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: BlocBuilder<PokemonBloc, PokemonState>(
                      builder: (context, statePokemon) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Row(
                              children: [
                                const TextWidget(
                                  text: 'Pokedex',
                                  style: TextStyles.titleMedium,
                                ),
                                const Spacer(),
                                if (stateDesk.model.isFilter)
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<PokeDeskBloc>()
                                          .add(const ClearFilterEvent());
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.clear_all),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        TextWidget(
                                          text: 'Clean filter',
                                          style: TextStyles.labelMedium,
                                          color: AppColors.primary,
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Expanded(
                              child: (statePokemon is FailState)
                                  ? NoDataWidget(text: statePokemon.error)
                                  : (statePokemon is LoadingState &&
                                          statePokemon
                                              .model.pokemonsList.isEmpty)
                                      ? Center(
                                          child: RotatePokeballWidget(
                                            milliseconds: 2000,
                                            color:
                                                AppColors.fab.withOpacity(0.2),
                                          ),
                                        )
                                      : statePokemon.model.pokemonsList.isEmpty
                                          ? const NoDataWidget(
                                              text: 'No results found',
                                            )
                                          : LiveGrid(
                                              controller: stateDesk
                                                  .model.scrollController,
                                              showItemInterval: const Duration(
                                                milliseconds: 50,
                                              ),
                                              showItemDuration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              visibleFraction: 0.001,
                                              itemCount: statePokemon
                                                  .model.pokemonsList.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 155 / 110,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                              ),
                                              itemBuilder: (
                                                context,
                                                index,
                                                animation,
                                              ) {
                                                final pokemon = statePokemon
                                                    .model.pokemonsList[index];
                                                return PokeGridItemWidget(
                                                  index: index,
                                                  pokemon: pokemon,
                                                  animation: animation,
                                                );
                                              },
                                            ),
                            ),
                            if (statePokemon is LoadingState &&
                                statePokemon.model.pokemonsList.isNotEmpty)
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: RotatePokeballWidget(
                                      milliseconds: 2000,
                                      color: AppColors.fab.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              )
                            else
                              const SizedBox.shrink()
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
