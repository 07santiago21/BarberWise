import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/datasources/local_storage_datasource_impl.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/get_cached_user_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/change_password.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/pages/sign_in_screen.dart';
import 'presentation/pages/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_ES', null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPreferences>.value(value: prefs),
        Provider<AuthRemoteDataSourceImpl>(
          create: (_) => AuthRemoteDataSourceImpl(),
        ),
        Provider<SharedPrefsLocalDataSource>(
          create: (_) => SharedPrefsLocalDataSource(prefs),
        ),
        Provider<AuthRepositoryImpl>(
          create: (ctx) => AuthRepositoryImpl(
            remote: ctx.read<AuthRemoteDataSourceImpl>(),
            local: ctx.read<SharedPrefsLocalDataSource>(),
          ),
        ),
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
        Provider<UpdateProfileUseCase>(
          create: (ctx) => UpdateProfileUseCase(ctx.read<AuthRepositoryImpl>()),
        ),
        Provider<ChangePasswordUseCase>(
          create: (ctx) =>
              ChangePasswordUseCase(ctx.read<AuthRepositoryImpl>()),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (ctx) => AuthProvider(
            signIn: ctx.read<SignInUseCase>(),
            signUp: ctx.read<SignUpUseCase>(),
            signOut: ctx.read<SignOutUseCase>(),
            getCached: ctx.read<GetCachedUserUseCase>(),
            updateProfile: ctx.read<UpdateProfileUseCase>(),
            changePassword: ctx.read<ChangePasswordUseCase>(),
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
    final isLoggedIn =
        context.select<AuthProvider, bool>((prov) => prov.isLoggedIn);

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
      home: isLoggedIn ? const MainNavigationScreen() : const SignInScreen(),
    );
  }
}
