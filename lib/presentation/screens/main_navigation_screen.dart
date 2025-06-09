import 'package:barber/presentation/screens/edit_profile_screen.dart';
import 'package:barber/presentation/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:barber/presentation/screens/dashboard_screen.dart';
import 'package:barber/presentation/screens/appointments_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../colors.dart';
import '../providers.dart';
import '../auth_notifier.dart';

import 'dashboard_screen.dart';
import 'appointments_screen.dart';
import 'statistics_screen.dart';
import 'edit_profile_screen.dart';
import 'sign_in_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

  static const _titles = ['Inicio', 'Agenda de citas', 'Editar perfil'];

  late final List<Widget> _pages = const [
    DashboardScreen(),
    AppointmentsScreen(),
    //StatisticsScreen(),
    EditProfileScreen(),
  ];

  Future<void> _logout() async {
    await ref.read(authNotifierProvider.notifier).logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: AppColors.secondaryBackground,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Citas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
