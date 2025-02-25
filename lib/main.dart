import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/data/app_theme.dart';
import 'package:second_app/src/models/formule_model.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/models/tab_item.dart';
import 'package:second_app/src/models/theme_model.dart';
import 'package:second_app/src/widgets/sized_icon_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HistoryModel().init();
  await ThemeModel().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoryModel()),
        ChangeNotifierProvider(create: (_) => FormuleModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: CalculatorApp(),
    )
  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: ligthTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: CalculatorHome()
        );
      }
    ); 
  }
}

class CalculatorHome extends StatelessWidget {
  const CalculatorHome({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = getTabs();
    final themeProvider = Provider.of<ThemeModel>(context, listen: false);

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length, 
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 120,
            child: TabBar(
            tabs: tabs.map((tab) => Tab(icon: tab.icon, height: 35,)).toList(),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: SizedIconButton(
                icon: themeProvider.themeMode == ThemeMode.light ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                size: 45,
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              )
            ),

          ],
        ),
        body: TabBarView(
          children: tabs.map((tab) => tab.screen).toList(),
        ),
      )
    );
  }
}