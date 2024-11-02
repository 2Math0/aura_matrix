import 'package:aura_matrix/core/const.dart';
import 'package:aura_matrix/dot/dot_canvas.dart';
import 'package:aura_matrix/user_customization/colot_palette.dart';
import 'package:flutter/material.dart';

import 'matrix_effect_model.dart';

/// Main widget that provides Matrix effect with touch interactions
class MatrixEffect extends StatefulWidget {
  const MatrixEffect({super.key});

  @override
  MatrixEffectState createState() => MatrixEffectState();
}

class MatrixEffectState extends State<MatrixEffect>
    with SingleTickerProviderStateMixin {
  late final MatrixEffectModel model;
  late final AnimationController controller;
  final ValueNotifier<Color> dotColor = ValueNotifier(AppConst.initialDotColor);

  @override
  void initState() {
    super.initState();

    // Initialize model first
    model = MatrixEffectModel();

    // Then create the controller that uses the model
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppConst.millisecondsPerUpdate),
    )
      ..addListener(() {
        model.updateDots();
      })
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() => model.touchLocation = details.localPosition);
      },
      onPanEnd: (_) => setState(() => model.resetTouch()),
      child: Container(
        color: Colors.black,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (model.dots.isEmpty) {
              model.initializeDots(
                  Size(constraints.maxWidth, constraints.maxHeight));
            }
            return AnimatedBuilder(
              animation: Listenable.merge([model, dotColor]),
              builder: (context, _) {
                return Stack(
                  children: [
                    CustomPaint(
                      painter: DotCanvas(
                        dots: model.dots,
                        dotSize: AppConst.dotSize,
                        dotColor: dotColor.value,
                      ),
                      child: Container(),
                    ),
                    ColorPalette(dotColorNotifier: dotColor),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
