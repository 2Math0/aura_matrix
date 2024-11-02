import 'package:aura_matrix/matrix/matrix_effect.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MatrixEffectApp());
}

/// Main Application Entry
class MatrixEffectApp extends StatelessWidget {
  const MatrixEffectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MatrixEffect(),
      ),
    );
  }
}
