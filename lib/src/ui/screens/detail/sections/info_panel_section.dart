import 'package:flutter/material.dart';
import 'package:orbi_test/src/ui/screens/detail/widgets/tabs_info_widget.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class InfoPanelSection extends StatelessWidget {
  const InfoPanelSection({
    super.key,
    required this.minHeight,
    required this.maxHeight,
    this.onPanelSlide,
  });
  final double minHeight;
  final double maxHeight;
  final void Function(double)? onPanelSlide;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return SlidingUpPanel(
          panelBuilder: () {
            return const TabsInfoWidget();
          },
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          minHeight: minHeight * value,
          maxHeight: maxHeight,
          boxShadow: null,
          onPanelSlide: onPanelSlide,
        );
      },
    );
  }
}
