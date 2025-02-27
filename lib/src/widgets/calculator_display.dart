import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/models/formule_model.dart';
import 'package:second_app/src/widgets/message_bubble.dart';

class CalculatorDisplay extends StatefulWidget {
  const CalculatorDisplay({super.key});

  @override
  State<CalculatorDisplay> createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  final ScrollController _scrollController = ScrollController();
  late FormuleModel resultNotifier;

  void _scrollToEnd() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _vibrationHandler() async {
    if (resultNotifier.justGetError && await Vibration.hasVibrator())  {
      Vibration.vibrate(duration: 200);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){ 
      resultNotifier = Provider.of<FormuleModel>(context, listen: false);
      resultNotifier.addListener(_scrollToEnd);
      resultNotifier.addListener(_vibrationHandler);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    resultNotifier.removeListener(_scrollToEnd);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String errorDisplay = '';

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
        errorDisplay = formule.errorMessage == null ? errorDisplay : 'Error: ${formule.errorMessage}';

        return Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: theme.colorScheme.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(upperDisplay, style: theme.textTheme.bodyLarge, maxLines: 1,),
                    SizedBox(height: 10,),
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: AnimatedDefaultTextStyle(
                        style: theme.textTheme.displayMedium?.copyWith( color: formule.errorMessage == null ? theme.textTheme.displayMedium?.color : Colors.red ) 
                                ?? TextStyle(), 
                        duration: Duration(milliseconds: 200),
                        child: Text(mainDisplay, maxLines: 1,), 
                      ),
                    ),
                    SizedBox(height: 5),
                  ]
                )
              ),

              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
                top: formule.errorMessage != null ? 5 : -50,
                child: AnimatedOpacity(
                  opacity: formule.errorMessage != null ? 1 : 0, 
                  duration: Duration(milliseconds: 200),
                  child: ShakeWidget(
                    duration: Duration(milliseconds: 2000),
                    shakeConstant: ShakeHorizontalConstant1(),
                    autoPlay: formule.justGetError,
                    child: MessageBubble(message: errorDisplay, type: MessageType.error), 
                  )
                )
              )

            ],
          )
          
          
        ); 

      }
    );
  }
}