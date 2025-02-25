import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/data/calculator_keys.dart';
import 'package:second_app/src/models/calculator_key_item.dart';
import 'package:second_app/src/models/formule_model.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/calculator_key.dart';

class CalculatorKeyboard extends StatelessWidget {
  const CalculatorKeyboard({super.key});

  void handleKeyTap( CalculatorKeyItem key, FormuleModel formulaModel, HistoryModel historyModel ) {
    formulaModel.clearError();
    switch (key.keyType) {
      case KeyType.number:
        formulaModel.addChar(key.label);
        break;
      case KeyType.operation:
        formulaModel.addChar(key.label);
        break;
      case KeyType.action:

        switch (key.label) {
          case 'clear':
            formulaModel.clearDisplay();
            break;
          case 'delete':
            formulaModel.removeLastChar();
            break;
          case 'equal':
            final res = formulaModel.calculateFormule();
            if (res!= null) {
              final (result, formule) = res;
              historyModel.addHistory(formule, result);
            }
            break;
          default:
            break;
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    final formulaModel = Provider.of<FormuleModel>(context);
    final historyModel = Provider.of<HistoryModel>(context);
    final theme = Theme.of(context);

    final listButtons = keyboardKeys.map( (CalculatorKeyItem key) => 
      CalculatorKey(
        text: key.text,
        icon: key.icon,
        onTap: () => handleKeyTap(key, formulaModel, historyModel),
        textColor: key.label == 'equal' 
                    ? theme.colorScheme.onPrimary 
                    : key.keyType != KeyType.number ? theme.colorScheme.primaryContainer : theme.textTheme.bodyLarge?.color,
        backgroundColor: key.label == 'equal' ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerLowest,
      )
    ).toList();

    return SizedBox( 
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          boxShadow: [BoxShadow(color: theme.colorScheme.shadow.withAlpha(15), blurRadius: 15.0, spreadRadius: 1.0)],
        ),
        child: SafeArea(
          child: GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
            crossAxisCount: 4,
            crossAxisSpacing: 25.0,
            mainAxisSpacing: 25.0,
            childAspectRatio: 1,
            children: listButtons, 
          )
        )
      ) 
    );
    
  }
}