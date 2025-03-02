import 'package:flutter/material.dart';
import 'package:second_app/src/data/constants.dart';
import 'package:second_app/src/utils/base.dart';
import 'package:second_app/src/utils/formule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryItem {
  HistoryItem({required this.formule, required this.result}) : id = generateId();
  HistoryItem.withId({required this.id, required this.formule, required this.result});

  final int id;
  final String formule;
  final double result;
}

class HistoryModel extends ChangeNotifier {
  static final HistoryModel _instance = HistoryModel._internal(); // singleton
  factory HistoryModel() => _instance;
  HistoryModel._internal();

  // for shared preferences
  SharedPreferencesWithCache? _prefs;
  static const historyKey = 'history';

  List<HistoryItem> _history = [];
  HistoryItem? lastestDeletedItem;

  List<HistoryItem> get history => _history;
  HistoryItem? get lastResult => _history.isNotEmpty ? _history.first : null;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
                    cacheOptions: const SharedPreferencesWithCacheOptions(
                      allowList: <String>{historyKey}),  
                  );
    await getHistory();
    notifyListeners();
  }

  void addHistory(String formule, double result) {
    final roundedResult = double.parse( toStringAsFixed(result, numberDecimalDigitsShow) ?? 'NaN');
    _history.insert(0, HistoryItem(formule: formule, result: roundedResult));
    saveHistory();
    notifyListeners();
  }

  void removeHistory(int id) {
    lastestDeletedItem = _history.firstWhere((item) => item.id == id);
    _history.removeWhere((item) => item.id == id);
    saveHistory();
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    saveHistory();
    notifyListeners();
  }

  Future<void> saveHistory() async {
    final List<String> historyList = _history.map((item) => '${item.id}__${item.formule}__${item.result}').toList();
    await _prefs?.setStringList(historyKey, historyList);
  }

  Future<void> getHistory() async {
    final List<String>? historyList = _prefs?.getStringList(historyKey);
    if (historyList != null) {
      _history = historyList.map((item) {
        final List<String> split = item.split('__');
        return HistoryItem.withId(id: int.parse(split[0]), formule: split[1], result: double.parse(split[2]));
      }).toList();
    } else {
      _history = [];
    }
  }
}