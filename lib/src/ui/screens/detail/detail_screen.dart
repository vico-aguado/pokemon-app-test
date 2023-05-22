import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/config/constants.dart';
import 'package:orbi_test/src/ui/screens/detail/bloc/detail_bloc.dart';
import 'package:orbi_test/src/ui/screens/detail/sections/info_panel_section.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/widgets.dart';
import 'package:orbi_test/src/ui/widgets/rotate_pokeball_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.index});
  final int index;

  void _onItemFocus(int index, BuildContext context) {
    context.read<DetailBloc>().add(SelectItemEvent(index));
  }

  Widget _buildListItem(BuildContext context, int index) {
    final pokemonBloc = context.read<PokemonBloc>();

    final pokemon = pokemonBloc.state.model.pokemonsList[index];
    const sizeImage = 230.0;

    final id = pokemon.id.toString().padLeft(3, '0');

    return SizedBox(
      width: sizeImage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: sizeImage,
            width: sizeImage,
            child: CachedNetworkImage(
              imageUrl: '${AppConstants.urlPokeImages1}$id.png',
            ),
          )
        ],
      ),
    );
  }

  double customEquation(double distance) {
    return 1 - min(distance.abs() / 300, 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;

    final infoMinHeight = size.height * 0.45;
    final infoMaxHeight = size.height - appBarHeight - safeArea.top - 10;

    final pokemonBloc = context.read<PokemonBloc>();

    return BlocProvider<DetailBloc>(
      create: (context) => DetailBloc(pokemonBloc, index),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            final bloc = context.read<DetailBloc>();
            final pokemon =
                pokemonBloc.state.model.pokemonsList[state.model.focusIndex];
            final specie =
                pokemonBloc.state.model.speciesList[state.model.focusIndex];

            const sizeImage = 230.0;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color:
                  AppColors.colorsList[pokemon.types?.first.type.name]?.first,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    width: size.width,
                    height: 100,
                    child: BackgroundImagesWidget(
                      safeArea: safeArea,
                      scrollPosition: 1 - state.model.panelScrollPosition,
                    ),
                  ),
                  if (state.model.panelScrollPosition > 0.5)
                    Positioned(
                      top: -40,
                      right: -55,
                      width: 180,
                      height: 180,
                      child: Opacity(
                        opacity: state.model.panelScrollPosition - 0.5,
                        child: const RotatePokeballWidget(),
                      ),
                    ),
                  if (state.model.panelScrollPosition < 0.5)
                    Positioned(
                      top: 230,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Opacity(
                          opacity: state.model.panelScrollPosition > 0.1
                              ? 1 -
                                  min(
                                    state.model.panelScrollPosition * 2,
                                    1,
                                  )
                              : 1,
                          child: const RotatePokeballWidget(
                            size: 180,
                          ),
                        ),
                      ),
                    ),
                  InfoPanelSection(
                    minHeight: infoMinHeight,
                    maxHeight: infoMaxHeight,
                    onPanelSlide: (position) =>
                        bloc.add(ChangeScrollPositionEvent(position)),
                  ),
                  Positioned(
                    top: 190,
                    right: 0,
                    left: 0,
                    height: 250,
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: -1, end: 1),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value < 0 ? 0 : value,
                          child: child,
                        );
                      },
                      child: IgnorePointer(
                        ignoring: state.model.panelScrollPosition > 0.1,
                        child: Opacity(
                          opacity: state.model.panelScrollPosition > 0.1
                              ? 1 - min(state.model.panelScrollPosition * 2, 1)
                              : 1,
                          child: ScrollSnapList(
                            initialIndex: index.toDouble(),
                            updateOnScroll: false,
                            fillColor: Colors.black.withOpacity(0.1),
                            onItemFocus: (index) =>
                                _onItemFocus(index, context),
                            itemSize: sizeImage,
                            itemBuilder: _buildListItem,
                            itemCount:
                                pokemonBloc.state.model.pokemonsList.length,
                            dynamicItemSize: true,
                            dynamicSizeEquation: customEquation,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: safeArea.top + 111 + 65,
                    right: size.width / 2 - sizeImage / 2,
                    height: sizeImage,
                    width: sizeImage,
                    child: PokemonImageBigWidget(
                      index: index,
                      pokemon: pokemon,
                    ),
                  ),
                  Positioned(
                    top: safeArea.top,
                    width: size.width,
                    height: 55,
                    child: IconsBarWidget(
                      pokemon: pokemon,
                    ),
                  ),
                  Positioned(
                    top: safeArea.top +
                        70 -
                        (state.model.panelScrollPosition * 50),
                    width: size.width,
                    child: NameTitleWidget(
                      pokemon: pokemon,
                      size: size,
                      index: index,
                      scrollPosition: state.model.panelScrollPosition,
                    ),
                  ),
                  Positioned(
                    top: safeArea.top + 110,
                    left: 65,
                    width: 130,
                    child: ChipsInfoWidget(
                      pokemon: pokemon,
                      index: index,
                      scrollPosition: 1 - state.model.panelScrollPosition,
                    ),
                  ),
                  Positioned(
                    top: safeArea.top + 75,
                    right: 25,
                    child: RightInfoWidget(
                      pokemon: pokemon,
                      specie: specie,
                      scrollPosition: 1 - state.model.panelScrollPosition,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
