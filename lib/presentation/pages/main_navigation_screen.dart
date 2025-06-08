import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barber/presentation/pages/dashboard_screen.dart';
import 'package:barber/presentation/pages/appointments_screen.dart';
import 'package:barber/presentation/pages/statistics_screen.dart';
import 'package:barber/presentation/pages/edit_profile_screen.dart';
import 'package:barber/presentation/pages/sign_in_screen.dart';
import 'package:barber/presentation/providers/auth_provider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static const _titles = [
    'Inicio',
    'Citas',
    'Estadísticas',
    'Perfil',
  ];

  late final List<Widget> _pages = [
    const DashboardScreen(),
    const AppointmentsScreen(),
    //const StatisticsScreen(),
    const EditProfileScreen(),
  ];

  void _logout() {
    context.read<AuthProvider>().logout();
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
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
