import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/ui/screens/detail/bloc/detail_bloc.dart';
import 'package:orbi_test/src/ui/screens/detail/sections/about_section.dart';
import 'package:orbi_test/src/ui/screens/detail/sections/evolution_section.dart';
import 'package:orbi_test/src/ui/screens/detail/sections/stats_section.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class TabsInfoWidget extends StatelessWidget {
  const TabsInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonBloc = context.read<PokemonBloc>();

    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        final pokemon =
            pokemonBloc.state.model.pokemonsList[state.model.focusIndex];
        final specie =
            pokemonBloc.state.model.speciesList[state.model.focusIndex];
        final evolutions =
            pokemonBloc.state.model.evolutionsList[state.model.focusIndex];

        return Padding(
          padding: EdgeInsets.fromLTRB(
            9,
            40 * (1 - state.model.panelScrollPosition),
            9,
            20,
          ),
          child: DefaultTabController(
            length: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TabBar(
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.primary.withOpacity(0.4),
                    labelPadding: const EdgeInsets.symmetric(vertical: 16),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppColors.fab,
                    tabs: const [
                      TextWidget(
                        text: 'About',
                        style: TextStyles.labelMedium,
                      ),
                      TextWidget(
                        text: 'Base stats',
                        style: TextStyles.labelMedium,
                      ),
                      TextWidget(
                        text: 'Evolution',
                        style: TextStyles.labelMedium,
                      ),
                      TextWidget(
                        text: 'Moves',
                        style: TextStyles.labelMedium,
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AboutSection(pokemon: pokemon, specie: specie),
                        StatesSection(pokemon: pokemon),
                        EvolutionSection(
                          evolutions: evolutions,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height:
                                  200 + (state.model.panelScrollPosition * 200),
                              child: const Center(
                                child: TextWidget(
                                  text: 'Coming soon',
                                  style: TextStyles.titleMedium,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
