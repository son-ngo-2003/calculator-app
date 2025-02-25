import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/models/formule_model.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormuleModel>(
      builder: (context, formule, child) {
        final theme = Theme.of(context);

        final upperDisplay = 
            formule.result != null
            ? formule.expressionDisplay // if user just calculated, show the formule in the upper and the result in the main display
            : formule.previousResult == null ? '' : 'ANS = ${formule.previousResult}';
        final mainDisplay = 
            formule.result != null
            ? formule.formuleResult!
            : formule.expressionDisplay;
        final errorDisplay = formule.errorMessage == null ? '' : 'Error: ${formule.errorMessage}';

        return Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(20),
            width: double.infinity,
            color: theme.colorScheme.surface,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(upperDisplay, style: theme.textTheme.bodyLarge, maxLines: 1,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Text(mainDisplay, style: theme.textTheme.displayMedium, maxLines: 1,)
                ),
                Text(errorDisplay),
              ]
            )
          ),
        ); 

      }
    );
  }
}