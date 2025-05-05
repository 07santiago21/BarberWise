import 'package:flutter/material.dart';
import '../colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: const Text('Editar Perfil',style: TextStyle(
                  color: Colors.white,
                )),
        backgroundColor: AppColors.secondaryBackground,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
           const SizedBox(height: 40),
          Center(
            child: Material(
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {},
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.secondaryBackground,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    )
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
          // Campo Nombre
          TextFormField(
            style: const TextStyle(color: AppColors.primaryText),
            initialValue: 'Test Test',
            decoration:  InputDecoration(
              labelText: 'Nombre',
              labelStyle: const TextStyle(color: AppColors.secondaryText),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              fillColor: AppColors.primaryBackground,
              filled: true,
              suffixIcon: Icon(Icons.arrow_forward_ios, color: AppColors.secondaryText,),
            ),
          ),

          const SizedBox(height: 20),

          // Campo Número
             TextFormField(
            style: const TextStyle(color: AppColors.primaryText),
            initialValue: 'signed phone number',
              decoration:  InputDecoration(
              labelText: 'Número',
              labelStyle: const TextStyle(color: AppColors.secondaryText),
              border: const OutlineInputBorder(),
              fillColor: AppColors.primaryBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              filled: true,
               suffixIcon: Icon(Icons.arrow_forward_ios, color: AppColors.secondaryText,),
            ),
          ),

          const SizedBox(height: 20),

          // Campo Email
          TextFormField(
            initialValue: 'signed@gmail.com',
            style: const TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(color: AppColors.secondaryText),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              fillColor: AppColors.primaryBackground,
              filled: true,
               suffixIcon: Icon(Icons.arrow_forward_ios, color: AppColors.secondaryText,),
            ),
          ),

          const SizedBox(height: 30),

          // Botón Guardar
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
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