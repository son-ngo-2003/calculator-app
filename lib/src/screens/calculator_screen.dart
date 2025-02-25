import 'package:flutter/material.dart';
import 'package:second_app/src/widgets/calculator_display.dart';
import 'package:second_app/src/widgets/calculator_keyboard.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.surfaceContainerLowest,
      child: Column(
        children: [
          CalculatorDisplay(),
          CalculatorKeyboard(),
        ]
      )
    );

  }
}