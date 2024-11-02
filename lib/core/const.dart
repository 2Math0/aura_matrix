import 'package:flutter/material.dart';

/// AppConst provides application-wide constants, including settings for the dot animation effect,
/// color palette, dot properties, and animation timings.
class AppConst {
  /// Predefined color palette for dot colors.
  static const List<Color> colorPalette = <Color>[
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.pink,
  ];

  /// Initial color of dots in the grid.
  static Color initialDotColor = colorPalette[0];

  /// Standard size of each dot, used across the application.
  static const double dotSize = 3;

  /// Spacing between dots in the grid.
  static const double dotSpacing = 20;

  /// Radius of the area around the touch point that affects dot movement.
  static const double touchBoundingSize = 50;

  /// Squared radius of [touchBoundingSize], optimized for distance calculations.
  static const double touchBoundingSizeSquared =
      touchBoundingSize * touchBoundingSize;

  /// Rate at which dots respond to the touch point, controlling movement speed.
  static const double dotInertia = 0.4;

  /// Amount by which velocity decreases to create a damping effect.
  static const double velocityDamping = 0.9;

  /// Restoration speed that gradually returns each dot to its origin position.
  static const double restorationSpeed = 0.03;

  /// Milliseconds per update for the animation frame rate.
  static const int millisecondsPerUpdate = 16;


  /// Current touch location in the app's coordinate space.
  /// The initial value is offscreen, effectively disabling the effect until touched.
  static const Offset initialTouchLocation =
  Offset(-AppConst.touchBoundingSize, -AppConst.touchBoundingSize);
}
