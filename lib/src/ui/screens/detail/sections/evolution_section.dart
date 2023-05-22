import 'package:flutter/material.dart';
import 'package:orbi_test/src/domain/entities/evolutions_model.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/content_info_widget.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/evolution_row_widget.dart';

class EvolutionSection extends StatelessWidget {
  const EvolutionSection({super.key, required this.evolutions});
  final Evolutions evolutions;

  @override
  Widget build(BuildContext context) {
    final results = <EvolutionItem>[];

    if (evolutions.chain != null) {
      if (evolutions.chain!.species != null) {
        var paths = evolutions.chain!.species!.url.split('/');
        if (paths.length > 1) {
          var id = int.parse(paths[6]);
          var level = 0;
          var name = evolutions.chain!.species!.name ?? '';

          if (evolutions.chain!.evolvesTo != null &&
              evolutions.chain!.evolvesTo!.isNotEmpty) {
            if (evolutions.chain!.evolvesTo!.first.evolutionDetails != null &&
                evolutions
                    .chain!.evolvesTo!.first.evolutionDetails!.isNotEmpty) {
              level = evolutions.chain!.evolvesTo!.first.evolutionDetails?.first
                      .minLevel ??
                  0;

              results.add(EvolutionItem(id: id, level: level, name: name));

              if (evolutions.chain!.evolvesTo!.first.species != null) {
                paths =
                    evolutions.chain!.evolvesTo!.first.species!.url.split('/');

                if (paths.length > 1) {
                  id = int.parse(paths[6]);
                  level = 0;
                  name = evolutions.chain!.evolvesTo!.first.species!.name ?? '';

                  if (evolutions.chain!.evolvesTo!.first.evolvesTo != null &&
                      evolutions
                          .chain!.evolvesTo!.first.evolvesTo!.isNotEmpty) {
                    if (evolutions.chain!.evolvesTo!.first.evolvesTo!.first
                                .evolutionDetails !=
                            null &&
                        evolutions.chain!.evolvesTo!.first.evolvesTo!.first
                            .evolutionDetails!.isNotEmpty) {
                      level = evolutions.chain!.evolvesTo!.first.evolvesTo!
                              .first.evolutionDetails!.first.minLevel ??
                          0;

                      results
                          .add(EvolutionItem(id: id, level: level, name: name));

                      if (evolutions.chain!.evolvesTo!.first.evolvesTo!.first
                              .species !=
                          null) {
                        paths = evolutions.chain!.evolvesTo!.first.evolvesTo!
                            .first.species!.url
                            .split('/');

                        if (paths.length > 1) {
                          id = int.parse(paths[6]);
                          name = evolutions.chain!.evolvesTo!.first.evolvesTo!
                                  .first.species!.name ??
                              '';

                          results
                              .add(EvolutionItem(id: id, level: 0, name: name));
                        }
                      }
                    }
                  } else {
                    results.add(EvolutionItem(id: id, level: 0, name: name));
                  }
                }
              }
            }
          }
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          ContentInfoWidget(
            title: 'Evolution Chain',
            content: Column(
              children: [
                EvolutionRowWidget(
                  pokemonBase: results[0],
                  pokemonUp: results[1],
                ),
                const Divider(),
                if (results.length > 2)
                  EvolutionRowWidget(
                    pokemonBase: results[1],
                    pokemonUp: results[2],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
