// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/config/constants.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';
import 'package:orbi_test/src/utils/methods.dart';

class EvolutionItem {
  EvolutionItem({
    required this.name,
    required this.id,
    required this.level,
  });
  final int id;
  final String name;
  final int level;
}

class EvolutionRowWidget extends StatelessWidget {
  const EvolutionRowWidget({
    super.key,
    required this.pokemonBase,
    required this.pokemonUp,
  });
  final EvolutionItem pokemonBase;
  final EvolutionItem pokemonUp;

  @override
  Widget build(BuildContext context) {
    final idBase = pokemonBase.id.toString().padLeft(3, '0');
    final idUP = pokemonUp.id.toString().padLeft(3, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            SizedBox(
              width: 83,
              height: 83,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/pokeball.svg',
                    color: Colors.black.withOpacity(0.05),
                  ),
                  CachedNetworkImage(
                    imageUrl: '${AppConstants.urlPokeImages1}$idBase.png',
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              text: pokemonBase.name.capitalize(),
              color: AppColors.primary,
              style: TextStyles.labelMedium,
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.arrow_forward,
              color: AppColors.primary.withOpacity(0.2),
            ),
            TextWidget(
              text: 'Lvl ${pokemonBase.level}',
              color: AppColors.primary,
              style: TextStyles.labelSmall,
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: 83,
              height: 83,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/pokeball.svg',
                    color: Colors.black.withOpacity(0.05),
                  ),
                  CachedNetworkImage(
                    imageUrl: '${AppConstants.urlPokeImages1}$idUP.png',
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              text: pokemonUp.name,
              color: AppColors.primary,
              style: TextStyles.labelMedium,
            ),
          ],
        )
      ],
    );
  }
}
