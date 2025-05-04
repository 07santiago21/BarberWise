import 'package:flutter/material.dart';
import 'package:barber/presentation/pages/main_navigation_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barber Wise',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Gris claro
        primaryColor: Colors.black,                      // Negro principal
        colorScheme: const ColorScheme.light(
          primary: Colors.black,         // Botones, textos importantes
          onPrimary: Colors.white,       // Texto sobre botones oscuros
          secondary: Color(0xFF4CAF50),  // Verde → Confirmado
          error: Color(0xFFF44336),      // Rojo → Error
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
