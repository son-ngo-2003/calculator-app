import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/models/animated_list_model.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/history_list_tile.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> with AutomaticKeepAliveClientMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late HistoryModel historyNotifier;
  late AnimatedListModel<HistoryItem> _list;

  void _updateList() {
    var history = historyNotifier.history;

    // modify _list to same as history
    int indList = 0;
    for (HistoryItem historyItem in history) {
      var index = _list.indexOf(historyItem);
      if (index == -1) {
        _list.insert(indList, historyItem);
      } else {
        for (int i = indList; i < index; i++) {
          _list.removeAt(i);
        }
      }
      indList++;
    }

    for (int i = indList; i < _list.length; i++) {
      _list.removeAt(i);
    }
  }

  Widget removedItemBuilder(HistoryItem item, BuildContext context, Animation<double> animation) {
    return HistoryListTile(
      id: item.id,
      formule: item.formule,
      result: item.result,
      animation: animation,
    );
  }

  @override
  void initState() {
    super.initState();
    historyNotifier = Provider.of<HistoryModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_){
      _list = AnimatedListModel<HistoryItem>(
        listKey: _listKey, 
        initialItems: historyNotifier.history,
        removedItemBuilder: removedItemBuilder
      );

      historyNotifier.addListener(_updateList);
    });
  }

  @override
  bool get wantKeepAlive => true; // keep state when change tab

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final historyList = historyNotifier.history;

    return Consumer<HistoryModel>(
      builder: (context, history, child) {
        return AnimatedList(
          key: _listKey,
          initialItemCount: historyList.length,
          itemBuilder: (context, index, animation) => HistoryListTile(
            id: historyList[index].id,
            formule: historyList[index].formule,
            result: historyList[index].result,
            animation: animation,
          ),
          // prototypeItem: HistoryListTile(id: 0, formule: '1 + 1', result: 2),
          padding: const EdgeInsets.only( left: 25.0, right: 10.0 ),
          // children: ListTile.divideTiles(tiles: listHistoryTile, context: context).toList(),
        );
      }
    );
  }
}