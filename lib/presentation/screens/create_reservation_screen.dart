// lib/presentation/pages/create_reservation_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/services_entity_.dart';
import 'package:barber/presentation/providers/appointment_providers.dart';
import 'package:barber/presentation/screens/main_navigation_screen.dart';
import 'package:barber/presentation/colors.dart';

class CreateReservationScreen extends ConsumerStatefulWidget {
  const CreateReservationScreen({super.key});

  @override
  ConsumerState<CreateReservationScreen> createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState
    extends ConsumerState<CreateReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();

  Service? selectedService;
  DateTime? selectedDateTime;
  bool _isLoading = false;

  Future<void> _selectDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (pickedDate == null) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (pickedTime == null) return;

    final dt = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    setState(() {
      selectedDateTime = dt;
      _dateCtrl.text =
          '${dt.day}/${dt.month}/${dt.year} - ${pickedTime.format(context)}';
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesProvider);
    final notifier = ref.read(appointmentFormProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crear reserva'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.vertical,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const Icon(Icons.cut, size: 250, color: Colors.black87),
                  const SizedBox(height: 34),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Nombre
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Nombre requerido'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Servicio (con padding right para evitar overflow)
                        servicesAsync.when(
                          data: (services) => SizedBox(
                            width: double.infinity,
                            child: DropdownButtonFormField<Service>(
                              isExpanded: true,
                              value: selectedService,
                              items: services
                                  .map((s) => DropdownMenuItem(
                                      value: s, child: Text(s.name)))
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => selectedService = val),
                              decoration: InputDecoration(
                                labelText: 'Tipo de servicio',
                                prefixIcon: const Icon(Icons.category),
                                border: const OutlineInputBorder(),
                                isDense: false, // ← deja más altura
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20, // ← espacio vertical suficiente
                                ),
                              ),
                              validator: (_) => selectedService == null
                                  ? 'Seleccione un servicio'
                                  : null,
                            ),
                          ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (e, _) => Text('Error: $e'),
                        ),
                        const SizedBox(height: 16),

                        // Fecha y hora
                        GestureDetector(
                          onTap: _selectDateTime,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dateCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Hora',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Hora requerida'
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Celular
                        TextFormField(
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Celular',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (v) => v == null || v.length < 10
                              ? 'Número inválido'
                              : null,
                        ),
                        const Spacer(),

                        // Botón Crear
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate() &&
                                        selectedService != null &&
                                        selectedDateTime != null) {
                                      setState(() => _isLoading = true);

                                      final fbUser =
                                          FirebaseAuth.instance.currentUser;
                                      if (fbUser == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Debe iniciar sesión')));
                                        setState(() => _isLoading = false);
                                        return;
                                      }
                                      final barberUid = fbUser.uid;

                                      final start = selectedDateTime!;
                                      final end = start.add(Duration(
                                          minutes: selectedService!.duration));

                                      final appointment = Appointment(
                                        clientName: _nameCtrl.text.trim(),
                                        barberId: barberUid,
                                        startTime: start,
                                        endTime: end,
                                        serviceId: selectedService!.id,
                                      );

                                      await notifier.submit(appointment);
                                      setState(() => _isLoading = false);

                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Reserva creada')));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const MainNavigationScreen(),
                                          ),
                                          (route) => false,
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Crear',
                                    style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
