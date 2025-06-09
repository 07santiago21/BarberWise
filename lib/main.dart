import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'presentation/providers.dart';
import 'presentation/pages/sign_in_screen.dart';
import 'presentation/pages/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // -------------------------------------------------------
  // Cargamos SharedPreferences SÍNCRONO antes de arrancar
  final prefs = await SharedPreferences.getInstance();

  // Arrancamos el ProviderScope sobreescribiendo nuestro
  // sharedPrefsProvider con la instancia ya cargada.
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final loggedIn = authState.user != null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barber Wise',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Color(0xFF4CAF50),
          error: Color(0xFFF44336),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: loggedIn ? const MainNavigationScreen() : const SignInScreen(),
    );
  }
}
