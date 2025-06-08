import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart'; // generado por flutterfire
import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/datasources/local_storage_datasource_impl.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/get_cached_user_usecase.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/pages/sign_in_screen.dart';
import 'presentation/pages/main_navigation_screen.dart'; // tu pantalla principal tras login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Inicializa formatos de fecha
  await initializeDateFormatting('es_ES', null);

  // 2) Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3) Inicializa SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // 4) Arranca la app con todos los providers
  runApp(
    MultiProvider(
      providers: [
        // SharedPreferences
        Provider<SharedPreferences>.value(value: prefs),

        // Data sources
        Provider<AuthRemoteDataSourceImpl>(
          create: (_) => AuthRemoteDataSourceImpl(),
        ),
        Provider<SharedPrefsLocalDataSource>(
          create: (_) => SharedPrefsLocalDataSource(prefs),
        ),

        // Repositorio
        Provider<AuthRepositoryImpl>(
          create: (ctx) => AuthRepositoryImpl(
            remote: ctx.read<AuthRemoteDataSourceImpl>(),
            local: ctx.read<SharedPrefsLocalDataSource>(),
          ),
        ),

        // UseCases
        Provider<SignInUseCase>(
          create: (ctx) => SignInUseCase(ctx.read<AuthRepositoryImpl>()),
        ),
        Provider<SignUpUseCase>(
          create: (ctx) => SignUpUseCase(ctx.read<AuthRepositoryImpl>()),
        ),
        Provider<SignOutUseCase>(
          create: (ctx) => SignOutUseCase(ctx.read<AuthRepositoryImpl>()),
        ),
        Provider<GetCachedUserUseCase>(
          create: (ctx) => GetCachedUserUseCase(ctx.read<AuthRepositoryImpl>()),
        ),

        // AuthProvider
        ChangeNotifierProvider<AuthProvider>(
          create: (ctx) => AuthProvider(
            signIn: ctx.read<SignInUseCase>(),
            signUp: ctx.read<SignUpUseCase>(),
            signOut: ctx.read<SignOutUseCase>(),
            getCached: ctx.read<GetCachedUserUseCase>(),
          )..loadCached(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el estado de sesión al construir
    final isLoggedIn = context.select<AuthProvider, bool>(
      (auth) => auth.user != null,
    );

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
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      // Si el usuario ya estaba logueado mostramos la navegación principal
      home: isLoggedIn ? const MainNavigationScreen() : const SignInScreen(),
    );
  }
}
