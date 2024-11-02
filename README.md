# aura_matrix

### Showcase
<div style="text-align: center;">
<video src="https://github.com/user-attachments/assets/a5712f6d-19aa-4b5e-abea-2d37e7f10274" width=100% height=100%/>
</div>

# Logic and UI for dot grid interaction

## Features

- **Interactive Dot Grid**: A grid of dots responds to touch inputs with smooth animations.
- **Configurable Dot Properties**: Customize dot size, spacing, color, and inertia.
- **Restorative Motion**: Dots gradually return to their origin positions after interaction.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Structure](#structure)
3. [Usage](#usage)
4. [Customization](#customization)
5. [Examples](#examples)

---

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/2Math0/aura_matrix.git
   cd aura_matrix_effect
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

## Structure

### `MatrixEffectModel`

`MatrixEffectModel` is a `ChangeNotifier` class that manages the grid of dots and handles
interaction with touch inputs. It has the following key methods:

- **`initializeDots(Size size)`**: Initializes a grid of dots based on screen size.
- **`updateDots()`**: Updates dot positions based on the current touch location and interaction.
- **`resetTouch()`**: Resets the touch location, allowing the dots to gradually return to their
  original positions.

### `AppConst`

`AppConst` provides all configurable constants used in the matrix effect, making it easy to adjust
animation properties and colors in one place.

- **Color Palette**: `colorPalette` allows customization of dot colors.
- **Dot Properties**: Constants like `dotSize`, `dotSpacing`, and `touchBoundingSize` control dot
  appearance and behavior.
- **Animation Parameters**: Parameters like `dotInertia`, `velocityDamping`, and `restorationSpeed`
  control the responsiveness and smoothness of animations.

### Example Project Structure

```plaintext
|-- aura_matrix/
|   |-- lib/
|       |-- main.dart          # Entry point of the app
|       |-- |-- core/
                |-- app_const.dart     # Constants for configuring the matrix effect
|       |-- dot/                   # Logic and UI for dot grid interaction
|           |-- dot_model.dart # Model class for individual dots
|           |-- dot_canvas.dart # UI for dots on screen
|       |-- matrix/ # Logic and UI for dot grid interaction
|           |-- matrix_effect_model # Logic 
|           |-- matrix_effect # UI 
```

## Usage

To use `MatrixEffectModel`, initialize it in your Flutter widget tree and set up
the `AnimatedBuilder` to redraw the dot grid when updates occur.

### Step 1: Initialize the Model

In your main widget, initialize `MatrixEffectModel` and set up a listener to update dot positions.

```dart

final MatrixEffectModel matrixModel = MatrixEffectModel();
matrixModel.initializeDots
(
screenSize
);
```

### Step 2: Update Dot Positions

Use `matrixModel.updateDots()` in response to touch inputs. This moves dots away from the touch
point.

```dart
matrixModel.touchLocation =

Offset(touchX, touchY);
matrixModel.updateDots
();
```

### Step 3: Draw the Grid

Use `AnimatedBuilder` or `CustomPaint` to draw the dots on the screen and listen to the model
updates.

```dart
AnimatedBuilder
(
animation: matrixModel,
builder: (context, child) {
return CustomPaint(
painter: DotGridPainter(matrixModel.dots),
);
},
);
```

### Example `DotGridPainter`

```dart
class DotGridPainter extends CustomPainter {
  final List<Dot> dots;

  DotGridPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    for (final dot in dots) {
      canvas.drawCircle(
        Offset(dot.x, dot.y),
        AppConst.dotSize,
        Paint()
          ..color = AppConst.initialDotColor,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

## Customization

Modify values in `AppConst` to fine-tune the matrix effect:

| Constant                     | Description                                                 | Default Value |
|------------------------------|-------------------------------------------------------------|---------------|
| `AppConst.dotSize`           | Size of each dot in pixels                                  | `3`           |
| `AppConst.dotSpacing`        | Spacing between each dot in pixels                          | `20`          |
| `AppConst.touchBoundingSize` | Radius of the area around the touch point that affects dots | `50`          |
| `AppConst.dotInertia`        | Rate at which dots respond to touch                         | `0.4`         |
| `AppConst.velocityDamping`   | Damping applied to dot velocity for a smooth effect         | `0.9`         |
| `AppConst.restorationSpeed`  | Speed at which dots return to their origin                  | `0.03`        |

Adjusting these values will help achieve the desired level of interaction, animation speed, and
visual appearance.

---

## Examples

### Basic Usage

To create a simple grid effect without interaction, set the `MatrixEffectModel` but omit touch
updates:

```dart

final MatrixEffectModel matrixModel = MatrixEffectModel();
matrixModel.initializeDots
(
screenSize
);
```

### Interactive Effect

For an interactive effect, update `matrixModel.touchLocation` and call `matrixModel.updateDots()` in
response to touch events.

### Configuration Example

To increase the size and spacing of dots, adjust `AppConst` values:

```dart
AppConst.dotSize = 5;
AppConst.dotSpacing = 30;
```

---

## Contributing

1. Fork the repository.
2. Create a feature branch: `git checkout -b my-feature`
3. Commit your changes: `git commit -m 'Add a new feature'`
4. Push to the branch: `git push origin my-feature`
5. Submit a pull request.

## License

This project is licensed under the MIT License.

--- 

Enjoy creating interactive visual effects with `Aura Matrix Effect`!