import 'package:flutter/material.dart';
import 'package:barber/presentation/colors.dart';
import 'main_navigation_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  ImageProvider? _pickedImage;

  void _pickImage() {
    // Simula la seleccion de una imagen local para la UI
    setState(() {      
      _pickedImage = const AssetImage('assets/new_profile_image.png');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBackground,
        title: const Text(
          'Crear cuenta',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: Material(
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _pickImage,
                child: CircleAvatar(                  
                  radius: 60,
                  backgroundColor: AppColors.secondaryBackground,
                  backgroundImage: _pickedImage,
                  child: _pickedImage == null
                      ? const Icon(Icons.person,
                          size: 60, color: Colors.white)
                      : null,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          TextFormField(
            style: const TextStyle(color: AppColors.primaryText),
            decoration: const InputDecoration(
              labelText: 'Nombre',
              labelStyle: TextStyle(color: AppColors.secondaryText),
              border: OutlineInputBorder(),
              fillColor: AppColors.primaryBackground,
              filled: true,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            style: const TextStyle(color: AppColors.primaryText),
            decoration: const InputDecoration(
              labelText: 'Número',
              labelStyle: TextStyle(color: AppColors.secondaryText),
              border: OutlineInputBorder(),
              fillColor: AppColors.primaryBackground,
              filled: true,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            style: const TextStyle(color: AppColors.primaryText),
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: AppColors.secondaryText),
              border: OutlineInputBorder(),
              fillColor: AppColors.primaryBackground,
              filled: true,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainNavigationScreen()),
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
                'Guardar',
                style: TextStyle(
                  color: AppColors.primaryBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

        ],
      ),
    );
  }
}
