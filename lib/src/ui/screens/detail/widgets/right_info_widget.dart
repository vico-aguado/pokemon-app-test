import 'package:flutter/material.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class RightInfoWidget extends StatelessWidget {
  const RightInfoWidget({
    super.key,
    required this.pokemon,
    required this.scrollPosition,
    required this.specie,
  });
  final double scrollPosition;
  final Pokemon pokemon;
  final Species specie;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: scrollPosition,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TweenAnimationBuilder(
            curve: Curves.easeOutExpo,
            tween: Tween<double>(begin: 200, end: 0),
            duration: const Duration(milliseconds: 700),
            child: TextWidget(
              text: '#${pokemon.id.toString().padLeft(3, '0')}',
              style: TextStyles.displayLarge,
            ),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value, 0),
                child: child,
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TweenAnimationBuilder(
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 400, end: 0),
            duration: const Duration(milliseconds: 700),
            child: TextWidget(
              text: specie.genera
                      ?.firstWhere(
                        (element) => element.language?.name == 'en',
                      )
                      .genus ??
                  '',
              color: Colors.white,
              style: TextStyles.labelMedium,
            ),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value, 0),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
