import 'package:flutter/material.dart';
import '../colors.dart';
import 'main_navigation_screen.dart';
import 'create_account_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {    
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryBackground,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Inicio de sesión',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondaryText, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.person, size: 60, color: AppColors.secondaryText,),
                )
              ),
              const SizedBox(height: 20),
              // App Name
             const Text("Inicio de sesión", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              const SizedBox(height: 40),
              // Username/Email Field
               TextFormField(
              decoration: InputDecoration(
                labelText: 'Usuario/Email',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            // Password Field
              TextFormField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 30),
            // Sign In Button
                SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MainNavigationScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
               const SizedBox(height: 10),
              // Forgot Password? Link
               TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                  );},
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}