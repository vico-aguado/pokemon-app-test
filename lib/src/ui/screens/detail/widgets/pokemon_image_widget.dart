import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/constants.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';

class PokemonImageBigWidget extends StatelessWidget {
  const PokemonImageBigWidget({
    super.key,
    required this.index,
    required this.pokemon,
  });

  final int index;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final id = pokemon.id.toString().padLeft(3, '0');
    return IgnorePointer(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1, end: 0),
        duration: const Duration(milliseconds: 600),
        child: Hero(
          tag: 'pokemon$index',
          child: CachedNetworkImage(
            imageUrl: '${AppConstants.urlPokeImages1}$id.png',
          ),
        ),
        builder: (context, value, child) {
          return Visibility(
            visible: value > 0,
            child: child!,
          );
        },
      ),
    );
  }
}
