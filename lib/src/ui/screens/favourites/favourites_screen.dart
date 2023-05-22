import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/ui/widgets/gridItem/grid_item_widget.dart';
import 'package:orbi_test/src/ui/widgets/no_data_widget.dart';
import 'package:orbi_test/src/ui/widgets/rotate_pokeball_widget.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const TextWidget(
              text: 'Favourites',
              style: TextStyles.titleMedium,
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: BlocBuilder<PokemonBloc, PokemonState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: RotatePokeballWidget(
                        milliseconds: 2000,
                        color: AppColors.fab.withOpacity(0.2),
                      ),
                    );
                  }
                  return state.model.favoriteList.isEmpty
                      ? const NoDataWidget(text: 'No favourites yet')
                      : LiveGrid(
                          showItemInterval: const Duration(milliseconds: 50),
                          showItemDuration: const Duration(milliseconds: 200),
                          visibleFraction: 0.001,
                          itemCount: state.model.favoriteList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 155 / 110,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index, animation) {
                            final pokemon = state.model.favoriteList[index];
                            return PokeGridItemWidget(
                              index: index,
                              pokemon: pokemon,
                              animation: animation,
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
