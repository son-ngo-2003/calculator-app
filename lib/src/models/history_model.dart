import 'package:flutter/material.dart';
import 'package:second_app/src/utils/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryItem {
  HistoryItem({required this.formule, required this.result});

  final int id = generateId();
  final String formule;
  final double result;
}

class HistoryModel extends ChangeNotifier {
  static final HistoryModel _instance = HistoryModel._internal(); // singleton
  factory HistoryModel() => _instance;
  HistoryModel._internal();

  List<HistoryItem> _history = [];
  SharedPreferencesWithCache? _prefs;
  static const historyKey = 'history';

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
    _history.insert(0, HistoryItem(formule: formule, result: result));
    saveHistory();
    notifyListeners();
  }

  void removeHistory(int id) {
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
    final List<String> historyList = _history.map((item) => '${item.formule}:${item.result}').toList();
    await _prefs?.setStringList(historyKey, historyList);
  }

  Future<void> getHistory() async {
    final List<String>? historyList = _prefs?.getStringList(historyKey);
    if (historyList != null) {
      _history = historyList.map((item) {
        final List<String> split = item.split(':');
        return HistoryItem(formule: split[0], result: double.parse(split[1]));
      }).toList();
    } else {
      _history = [];
    }
  }
}