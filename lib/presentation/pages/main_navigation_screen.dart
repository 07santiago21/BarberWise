import 'package:barber/presentation/pages/profile_options_screen.dart';
import 'package:barber/presentation/pages/edit_profile_screen.dart';
import 'package:barber/presentation/pages/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:barber/presentation/pages/dashboard_screen.dart';
import 'package:barber/presentation/pages/create_account_screen.dart';
import 'package:barber/presentation/pages/appointments_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final bool _isUserSignedIn = false;
  late final List<Widget> _pages = [
    const DashboardScreen(), 
    const AppointmentsScreen(),
    const StatisticsScreen(), 
    _isUserSignedIn ? const EditProfileScreen() : const ProfileOptionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
