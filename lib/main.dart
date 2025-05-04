
import 'package:barber/presentation/pages/appointments_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null); // 🧠 ¡Esto es clave!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estadísticas Barbería',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AppointmentsScreen(),

    );
  }
}
