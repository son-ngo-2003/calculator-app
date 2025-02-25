import 'package:flutter/material.dart';
import 'package:second_app/src/screens/calculator_screen.dart';
import 'package:second_app/src/screens/history_screen.dart';

class TabItem {
  TabItem({ required this.title, required this.icon, required this.screen });

  final String title;
  final Icon icon;
  final Widget screen;
}

List<TabItem> getTabs() {
  return [
    TabItem(title: 'Calculator', icon: const Icon(Icons.calculate_outlined), screen: CalculatorScreen()),
    TabItem(title: 'History', icon: const Icon(Icons.history_outlined), screen: HistoryScreen()),
  ];
}