import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../auth_notifier.dart';
import '../colors.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});
  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  TextEditingController? _nameC, _phoneC, _emailC;
  final _newPassC = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameC?.dispose();
    _phoneC?.dispose();
    _emailC?.dispose();
    _newPassC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    _nameC ??= TextEditingController(text: user.name);
    _phoneC ??= TextEditingController(text: user.phone);
    _emailC ??= TextEditingController(text: user.email);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.secondaryBackground,
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _nameC,
            decoration: const InputDecoration(
                labelText: 'Nombre', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _phoneC,
            decoration: const InputDecoration(
                labelText: 'Número', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _emailC,
            readOnly: true,
            decoration: const InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _newPassC,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: 'Nueva contraseña', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() => _loading = true);
                      final notifier = ref.read(authNotifierProvider.notifier);

                      final ok1 = await notifier.updateProfile(
                          _nameC!.text, _phoneC!.text);
                      bool ok2 = true;
                      if (_newPassC.text.isNotEmpty) {
                        ok2 = await notifier.changePassword(_newPassC.text);
                      }
                      setState(() => _loading = false);

                      final err = ref.read(authNotifierProvider).error;
                      if (ok1 && ok2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perfil actualizado')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err ?? 'Error al guardar')),
                        );
                      }
                    },
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Guardar',
                      style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
