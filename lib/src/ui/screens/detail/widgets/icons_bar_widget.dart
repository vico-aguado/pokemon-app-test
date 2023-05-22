import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/routes.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';

class IconsBarWidget extends StatelessWidget {
  const IconsBarWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const InkWell(
            onTap: AppNavigator.pop,
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          InkWell(
              child: Icon(
            pokemon.isFavourite ? Icons.favorite : Icons.favorite_border,
            size: 30,
            color: pokemon.isFavourite ? Colors.red : Colors.white,
          )),
        ],
      ),
    );
  }
}
