import 'package:flutter/material.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/ui/widgets/chip_widget.dart';
import 'package:orbi_test/src/utils/methods.dart';

class ChipsInfoWidget extends StatelessWidget {
  const ChipsInfoWidget({
    super.key,
    required this.pokemon,
    required this.index,
    required this.scrollPosition,
  });
  final Pokemon pokemon;
  final int index;
  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: scrollPosition,
      child: Builder(
        builder: (context) {
          final typesList = <Widget>[];
          final types = pokemon.types ?? [];

          if (types.isNotEmpty) {
            for (var i = 0; i < types.length; i++) {
              final type = types[i];

              typesList
                ..add(
                  Hero(
                    tag: 'chip$i$index',
                    child: ChipWidget(
                      text: type.type.name?.capitalize() ?? '',
                    ),
                  ),
                )
                ..add(
                  const SizedBox(
                    width: 10,
                  ),
                );
            }
          }

          return Transform.scale(
            scale: 1.6,
            child: Row(
              children: typesList,
            ),
          );
        },
      ),
    );
  }
}
