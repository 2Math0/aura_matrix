import 'package:aura_matrix/core/const.dart';
import 'package:flutter/material.dart';

/// Palette to select dot colors dynamically
class ColorPalette extends StatelessWidget {
  final ValueNotifier<Color> dotColorNotifier;
  final List<Color> colors;

  const ColorPalette(
      {super.key,
      required this.dotColorNotifier,
      this.colors = AppConst.colorPalette});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Wrap(
        spacing: 16,
        children: colors
            .map((c) => GestureDetector(
                  onTap: () => dotColorNotifier.value = c,
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 40),
                    color: c,
                    child: const SizedBox(height: 20, width: 20),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
