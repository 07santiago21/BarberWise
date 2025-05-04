import 'package:flutter/material.dart';
import 'presentation/pages/statistics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estadísticas Barbería',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StatisticsScreen(),
    );
  }
}
