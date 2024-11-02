import 'dart:math';
import 'package:aura_matrix/core/const.dart';
import 'package:aura_matrix/dot/dot_model.dart';
import 'package:flutter/material.dart';

/// MatrixEffectModel manages a grid of dots that react to touch interaction.
/// It contains properties and methods to handle dot movement, grid initialization, and touch-based
/// effects. The class leverages [ChangeNotifier] to notify listeners whenever the dot grid updates.
class MatrixEffectModel extends ChangeNotifier {
  /// List of dots in the grid. Each [Dot] has position, origin, and velocity properties.
  List<Dot> dots = [];

  /// Current touch location in the app's coordinate space.
  /// The initial value is offscreen, effectively disabling the effect until touched.
  Offset touchLocation = AppConst.initialTouchLocation;

  /// Initializes a grid of dots based on the given [Size] of the screen.
  ///
  /// [size]: The size of the screen or container to define the grid area.
  /// Dots are spaced evenly based on [AppConst.dotSpacing] and start at their origin positions.
  void initializeDots(Size size) {
    int rows = (size.height / AppConst.dotSpacing).ceil();
    int columns = (size.width / AppConst.dotSpacing).ceil();
    dots = List.generate(rows * columns, (index) {
      double x = (index % columns) * AppConst.dotSpacing;
      double y = (index ~/ columns) * AppConst.dotSpacing;
      return Dot(x: x, y: y, originX: x, originY: y);
    });
  }

  /// Updates the positions of dots based on the current touch location.
  ///
  /// If a dot is within [AppConst.touchBoundingSize] of the touch point, it’s pushed away
  /// with a force that decreases with distance. Dots are then slowly restored
  /// to their origin positions to create a smooth animation effect.
  void updateDots() {
    for (var dot in dots) {
      // Calculate distance from the touch point
      double dx = touchLocation.dx - dot.x;
      double dy = touchLocation.dy - dot.y;
      double distanceSquared = dx * dx + dy * dy;

      // Apply force if within the bounding area of the touch location
      if (distanceSquared < AppConst.touchBoundingSizeSquared) {
        double distance = sqrt(distanceSquared);
        double force = (AppConst.touchBoundingSize - distance) /
            AppConst.touchBoundingSize;
        double angle = atan2(dy, dx);

        // Calculate target positions for displacement
        double targetX = dot.x - cos(angle) * force * AppConst.dotSpacing;
        double targetY = dot.y - sin(angle) * force * AppConst.dotSpacing;

        // Update dot velocities based on inertia
        dot.vx += (targetX - dot.x) * AppConst.dotInertia;
        dot.vy += (targetY - dot.y) * AppConst.dotInertia;
      }

      // Reduce velocity slightly to create a damping effect
      dot.vx *= AppConst.velocityDamping;
      dot.vy *= AppConst.velocityDamping;

      // Move dots according to updated velocities
      dot.x += dot.vx;
      dot.y += dot.vy;

      // Gradually restore dots to their origin position
      double dx2 = dot.originX - dot.x;
      double dy2 = dot.originY - dot.y;
      if (dx2 * dx2 + dy2 * dy2 > 1) {
        dot.x += dx2 * AppConst.restorationSpeed;
        dot.y += dy2 * AppConst.restorationSpeed;
      }
    }
    // Notify listeners (e.g., UI) to update with new positions
    notifyListeners();
  }

  /// Resets the touch location to an offscreen point, effectively disabling the effect.
  ///
  /// This is useful for when touch interaction has ended, and the dots should return to their
  /// default positions without being affected by a touch point.
  void resetTouch() => touchLocation = AppConst.initialTouchLocation;
}
