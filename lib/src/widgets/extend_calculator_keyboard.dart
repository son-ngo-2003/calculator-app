import 'package:flutter/material.dart';
import 'package:second_app/src/widgets/calculator_key.dart';

class ExtendCalculatorKeyboard extends StatelessWidget {
  const ExtendCalculatorKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final listButtons = List.generate(9, (index) =>
      CalculatorKey(
        text: '$index',
        onTap: () {},
        textColor: theme.textTheme.bodyLarge?.color,
        backgroundColor: theme.colorScheme.primaryContainer,
      )
    );

    final borderRadius = Radius.circular(20.0);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.all( borderRadius ),
        //BorderRadius.only( topRight: borderRadius, bottomLeft: borderRadius, bottomRight: borderRadius ),
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 24.0,
        padding: EdgeInsets.all(14.0),
        childAspectRatio: 1,
        children: listButtons, 
      ),
    );
  }
}