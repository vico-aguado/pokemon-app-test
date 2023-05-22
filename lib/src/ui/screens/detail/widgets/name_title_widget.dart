import 'package:flutter/material.dart';
import 'package:orbi_test/src/domain/entities/pokemon_model.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';
import 'package:orbi_test/src/utils/methods.dart';

class NameTitleWidget extends StatelessWidget {
  const NameTitleWidget({
    super.key,
    required this.pokemon,
    required this.size,
    required this.index,
    required this.scrollPosition,
  });
  final double scrollPosition;
  final Pokemon pokemon;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final text = pokemon.name.capitalize();
        final textStyle = Theme.of(context).textTheme.titleSmall!;

        final textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();

        final scale = 2.5 - (scrollPosition * 1);

        final textSize = textPainter.size;
        final textWidth = textSize.width * scale;

        return Row(
          children: [
            SizedBox(
              width: scrollPosition * ((size.width - textWidth) / 2) +
                  ((1 - scrollPosition) * 27),
            ),
            Hero(
              tag: 'text$index',
              child: Container(
                width: textWidth,
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: scale,
                  child: TextWidget(
                    textAlign: TextAlign.center,
                    text: pokemon.name.capitalize(),
                    style: TextStyles.titleSmall,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: (size.width - textWidth) / 2,
            ),
          ],
        );
      },
    );
  }
}
