import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/data/calculator_keys.dart';
import 'package:second_app/src/models/calculator_key_item.dart';
import 'package:second_app/src/models/formule_model.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/calculator_key.dart';

class ExtendCalculatorKeyboard extends StatelessWidget {
  const ExtendCalculatorKeyboard({super.key});

 void handleKeyTap( CalculatorKeyItem key, FormuleModel formulaModel, HistoryModel historyModel ) {
    formulaModel.clearError();
    switch (key.keyType) {
      case KeyType.number:
        formulaModel.addSymbol(key.label);
        break;
      case KeyType.operation:
        formulaModel.addSymbol(key.label);
        break;
      case KeyType.function:
        formulaModel.addSymbol(key.label);
        break;
      case KeyType.action:
        break; //extend keyboard does not have action keys

    }
  }

  @override
  Widget build(BuildContext context) {
    final formulaModel = Provider.of<FormuleModel>(context);
    final historyModel = Provider.of<HistoryModel>(context);
    formulaModel.setAns( historyModel.lastResult?.result, notify: false);
    final theme = Theme.of(context);

    final listButtons = extendKeyboardKeys.map((key) =>
      CalculatorKey(
        text: key.text,
        icon: key.icon,
        alternativeText: key.alternativeText,
        alternativeIcon: key.alternativeIcon,

        onTap: () => handleKeyTap(key, formulaModel, historyModel),
        textColor: theme.textTheme.bodyLarge?.color,
        backgroundColor: theme.colorScheme.primaryContainer,
        usingAlternative: false,
      )
    ).toList();

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