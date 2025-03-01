import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/data/calculator_keys.dart';
import 'package:second_app/src/models/calculator_key_item.dart';
import 'package:second_app/src/models/formule_model.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/animated_clip_react.dart';
import 'package:second_app/src/widgets/calculator_key.dart';
import 'package:second_app/src/widgets/extend_calculator_keyboard.dart';

class CalculatorKeyboard extends StatefulWidget {
  const CalculatorKeyboard({super.key});

  @override
  State<CalculatorKeyboard> createState() => _CalculatorKeyboardState();
}

class _CalculatorKeyboardState extends State<CalculatorKeyboard> {
  var isExtendedKeyboardOpen = false;

  void toggleExtendedKeyboard() {
    setState(() {
      isExtendedKeyboardOpen = !isExtendedKeyboardOpen;
    });
  }

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
          case 'more':
              toggleExtendedKeyboard();
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
    formulaModel.setAns( historyModel.lastResult?.result, notify: false);
    final theme = Theme.of(context);

    final listButtons = keyboardKeys.map( (CalculatorKeyItem key) => 
      CalculatorKey(
        text: key.text,
        icon: key.icon,
        alternativeText: key.alternativeText,
        alternativeIcon: key.alternativeIcon,

        onTap: () => handleKeyTap(key, formulaModel, historyModel),
        textColor: key.label == 'equal'
                    ? theme.colorScheme.onPrimary 
                    : key.keyType != KeyType.number && !(isExtendedKeyboardOpen && key.label == 'more')
                        ? theme.colorScheme.primaryContainer 
                        : theme.textTheme.bodyLarge?.color,
        backgroundColor: key.label == 'equal' || (isExtendedKeyboardOpen && key.label == 'more') 
                    ? theme.colorScheme.primaryContainer 
                    : theme.colorScheme.surfaceContainerLowest,
      )
    ).toList();

    const paddingHorizontal = 28.0;
    final keyboardWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SizedBox( 
          width: keyboardWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              boxShadow: [BoxShadow(color: theme.colorScheme.shadow.withAlpha(15), blurRadius: 15.0, spreadRadius: 1.0)],
            ),
            child: SafeArea(
              child: GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: paddingHorizontal, right: paddingHorizontal, top: 20.0),
                crossAxisCount: 4,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 24.0,
                childAspectRatio: 1,
                children: listButtons, 
              ),
            ) 
        
          )
        ),
    
        // if (isExtendedKeyboardOpen)
        Transform.translate(
          offset: Offset(14.0, keyboardWidth / 4 - 12.0),
          child: AnimatedClipRect(
            duration: Duration(milliseconds: 400),
            open: isExtendedKeyboardOpen,
            curve: Curves.easeOut,

            child: SizedBox(
              width: keyboardWidth * 3 / 4 - 20.0,
              height: null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 29.0),
                    width: 35.0,
                    height: 10.0,
                    color: theme.colorScheme.primaryContainer,
                  ),
                  ExtendCalculatorKeyboard(),
                ],
              ),
            ),
          ),
        ),
      ], 
    ); 
    
    
  }
}