// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/config/constants.dart';
import 'package:orbi_test/src/config/routes.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/ui/widgets/chip_widget.dart';
import 'package:orbi_test/src/ui/widgets/gridItem/bloc/pokemon_item_bloc.dart';
import 'package:orbi_test/src/ui/widgets/rotate_pokeball_widget.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';
import 'package:orbi_test/src/utils/methods.dart';

class PokeGridItemWidget extends StatelessWidget {
  const PokeGridItemWidget({
    super.key,
    required this.animation,
    required this.index,
    required this.pokemon,
  });
  final Animation<double> animation;
  final int index;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final pokemonBloc = context.read<PokemonBloc>();

    final id = pokemon.id.toString().padLeft(3, '0');

    return BlocProvider<PokemonItemBloc>(
      create: (context) => PokemonItemBloc(
        pokemonBloc,
        pokemon,
        index,
      )..add(const LoadItemDataEvent()),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: GestureDetector(
          onTap: () {
            AppNavigator.push(
              Routes.details,
              index,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: pokemon.loaded
                  ? AppColors.colorsList[pokemon.types?.first.type.name]?.first
                  : Colors.grey.withOpacity(0.3),
            ),
            child: Stack(
              children: [
                Positioned(
                  width: 90,
                  height: 90,
                  bottom: -15,
                  right: -4,
                  child: SvgPicture.asset(
                    'assets/images/pokeball.svg',
                    color: Colors.white.withOpacity(0.30),
                  ),
                ),
                Positioned(
                  width: 80,
                  height: 80,
                  bottom: 2,
                  right: 5,
                  child: Hero(
                    tag: 'pokemon$index',
                    child: CachedNetworkImage(
                      imageUrl: '${AppConstants.urlPokeImages1}$id.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 13, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextWidget(
                            text: '#${pokemon.id.toString().padLeft(3, '0')}',
                            color: Colors.black.withOpacity(0.3),
                            style: TextStyles.titleSmall,
                          ),
                        ],
                      ),
                      Hero(
                        tag: 'text$index',
                        child: TextWidget(
                          text: pokemon.name.capitalize(),
                          style: TextStyles.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<PokemonItemBloc, PokemonItemState>(
                        builder: (context, state) {
                          if (state.model.data.loaded) {
                            final typesList = <Widget>[];
                            final types = state.model.data.types ?? [];

                            if (types.isNotEmpty) {
                              for (var i = 0; i < types.length; i++) {
                                final type = types[i];

                                typesList
                                  ..add(
                                    Hero(
                                      tag: 'chip$i$index',
                                      child: ChipWidget(
                                        text:
                                            type.type.name?.capitalize() ?? '',
                                      ),
                                    ),
                                  )
                                  ..add(
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  );
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: typesList,
                            );
                          }

                          return const SizedBox(
                            width: 30,
                            height: 30,
                            child: RotatePokeballWidget(
                              milliseconds: 1000,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder<PokemonItemBloc, PokemonItemState>(
                  builder: (context, state) {
                    if (state.model.data.loaded) {
                      return Positioned(
                        width: 35,
                        height: 35,
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<PokemonItemBloc>()
                                .add(const SaveItemEvent());
                          },
                          child: ColoredBox(
                            color: Colors.transparent,
                            child: Icon(
                              pokemon.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: pokemon.isFavourite
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
