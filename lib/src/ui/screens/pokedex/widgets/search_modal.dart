import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/config/theme.dart';
import 'package:orbi_test/src/ui/screens/pokedex/bloc/poke_desk_bloc.dart';

Future<dynamic> showSearchModal(
  BuildContext context,
  TextEditingController controller,
  PokeDeskBloc bloc,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final viewInsets = MediaQuery.of(context).viewInsets;
      final safeAreaBottom = MediaQuery.of(context).padding;

      return Padding(
        padding: EdgeInsets.only(
          top: 14,
          right: 20,
          left: 20,
          bottom: viewInsets.bottom + safeAreaBottom.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 75,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              autocorrect: false,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primary.withOpacity(0.6),
                  ),
              decoration: AppTheme.inputStyle('Search Pokemon by name/number'),
              autofocus: true,
              onEditingComplete: () {
                bloc.add(const SearchPokemonEvent());
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
