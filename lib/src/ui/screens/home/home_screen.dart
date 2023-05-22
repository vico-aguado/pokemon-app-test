// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbi_test/src/bloc/pokemon_bloc.dart';
import 'package:orbi_test/src/ui/screens/favourites/favourites_screen.dart';
import 'package:orbi_test/src/ui/screens/pokedex/pokedesk_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return Scaffold(
          body: state.model.isFavourites
              ? const FavouritesScreen()
              : const PokedeskScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.model.isFavourites ? 1 : 0,
            onTap: (value) {
              context.read<PokemonBloc>().add(ChangeTabEvent(value));
            },
            selectedItemColor:
                state.model.isFavourites ? Colors.red : const Color(0xFFFFCE4B),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/pikachu.svg',
                  color: state.model.isFavourites
                      ? Colors.grey
                      : const Color(0xFFFFCE4B),
                ),
                label: 'Pokedex',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: state.model.isFavourites ? Colors.red : null,
                ),
                label: 'Favourites',
              ),
            ],
          ),
        );
      },
    );
  }
}
