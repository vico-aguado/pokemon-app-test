import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/content_info_widget.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/linear_bar_widget.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';
import 'package:orbi_test/src/utils/methods.dart';

class StatesSection extends StatelessWidget {
  const StatesSection({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final stats = <LinearBarWidget>[];
    var totalStat = 0;
    if (pokemon.stats != null) {
      for (var i = 0; i < pokemon.stats!.length; i++) {
        final stat = pokemon.stats![i];
        totalStat += stat.baseStat;
        stats.add(
          LinearBarWidget(
            title: stat.stat.name.toString().capitalize(),
            number: stat.baseStat.toString(),
            value: stat.baseStat,
          ),
        );
      }
    }

    final name = pokemon.name.capitalize();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ...stats,
          LinearBarWidget(
            title: 'Total',
            number: totalStat.toString(),
            value: (totalStat / 6).round(),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.maxFinite,
            child: ContentInfoWidget(
              title: 'Type defenses',
              content: TextWidget(
                text: 'The effectiveness of each type on $name.',
                color: AppColors.primary.withOpacity(0.4),
                style: TextStyles.labelMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
