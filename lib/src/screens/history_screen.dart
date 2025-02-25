import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/history_list_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryModel>(
      builder: (context, history, child) {
        final listHistoryTile = history.history.map((item) => 
          HistoryListTile(id: item.id, formule: item.formule, result: item.result)
        ).toList();

        return history.history.isNotEmpty 
        ? Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only( left: 25.0, right: 10.0 ),
                  children: ListTile.divideTiles(tiles: listHistoryTile, context: context).toList(),
                )
              ),
              FilledButton(
                onPressed: () => history.clearHistory(),
                child: Text('Clear History'),
              ),
              SizedBox(height: 15.0),
            ]
          )
        : SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280), 
              child: Text('History is waiting to be written. Start calculating now!', 
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          )
        );
      }
    );

  }
}