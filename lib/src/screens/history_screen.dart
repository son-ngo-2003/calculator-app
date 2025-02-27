import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/history_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryModel>(
      builder: (context, history, child) {

        return Stack( // cause we dont want HistoryList will unrender, because State of AnimatedListState will null
          children: [
            Column(
              children: [
                Expanded( child: HistoryList(),),
                FilledButton(
                  onPressed: () => history.clearHistory(),
                  child: Text('Clear History'),
                ),
                SizedBox(height: 15.0),
              ]
            ),

            if (history.history.isEmpty)
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 280), 
                  child: Text('History is waiting to be written. Start calculating now!', 
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            ),
          ],
        );

      }
    );

  }
}