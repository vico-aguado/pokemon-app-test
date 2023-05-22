import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/config/images.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/domain/entities/species_model.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/content_info_widget.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';
import 'package:orbi_test/src/utils/methods.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({
    super.key,
    required this.pokemon,
    required this.specie,
  });
  final Pokemon pokemon;
  final Species specie;

  @override
  Widget build(BuildContext context) {
    final genderFemale = 12.5 * (specie.genderRate ?? 0);
    final genderMale = 12.5 * (8 - (specie.genderRate ?? 0));

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextWidget(
              text: (specie.flavorTextEntries
                          ?.lastWhere(
                            (element) =>
                                element.language?.name == 'en' &&
                                element.version?.name == 'ruby',
                          )
                          .flavorText ??
                      '')
                  .replaceAll('\n', ' ')
                  .replaceAll('\f', ' '),
              style: TextStyles.labelMedium,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 23,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Height',
                        color: AppColors.primary.withOpacity(0.4),
                        style: TextStyles.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                        text: pokemon.height.toString(),
                        color: AppColors.primary,
                        style: TextStyles.labelMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Weight',
                        color: AppColors.primary.withOpacity(0.4),
                        style: TextStyles.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                        text: pokemon.weight.toString(),
                        color: AppColors.primary,
                        style: TextStyles.labelMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ContentInfoWidget(
            title: 'Breeding',
            content: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Gender',
                      color: AppColors.primary.withOpacity(0.4),
                      style: TextStyles.labelMedium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      text: 'Egg Groups',
                      color: AppColors.primary.withOpacity(0.4),
                      style: TextStyles.labelMedium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      text: 'Egg Cycle',
                      color: AppColors.primary.withOpacity(0.4),
                      style: TextStyles.labelMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AppImages.male,
                          width: 14,
                          height: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                          text: '$genderMale %',
                          style: TextStyles.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      text: (specie.eggGroups?.first.name ?? '').capitalize(),
                      style: TextStyles.labelMedium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      text: (specie.eggGroups?.last.name ?? '').capitalize(),
                      style: TextStyles.labelMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AppImages.female,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                          text: '$genderFemale %',
                          style: TextStyles.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 69,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ContentInfoWidget(
            title: 'Location',
            content: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 150,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ContentInfoWidget(
            title: 'Training',
            content: Row(
              children: [
                TextWidget(
                  text: 'Base EXP',
                  color: AppColors.primary.withOpacity(0.4),
                  style: TextStyles.labelMedium,
                ),
                const Spacer(),
                TextWidget(
                  text: pokemon.baseExperience.toString(),
                  style: TextStyles.labelMedium,
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
