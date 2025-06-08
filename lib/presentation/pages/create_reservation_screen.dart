import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/services_entity_.dart';
import 'package:barber/presentation/providers/appointment_providers.dart';

class CreateReservationScreen extends ConsumerStatefulWidget {
  const CreateReservationScreen({super.key});

  @override
  ConsumerState<CreateReservationScreen> createState() => _CreateReservationScreenState();
}

class _CreateReservationScreenState extends ConsumerState<CreateReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();

  Service? selectedService;
  DateTime? selectedDateTime;

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 10, minute: 0),
      );

      if (pickedTime != null) {
        final selected = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          selectedDateTime = selected;
          dateTimeController.text =
              '${selected.day}/${selected.month}/${selected.year} - '
              '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesProvider);
    final notifier = ref.read(appointmentFormProvider.notifier);

    return Scaffold(
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.cut, size: 250, color: Colors.black87),
                const SizedBox(height: 34),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),
                      servicesAsync.when(
                        data: (services) => DropdownButtonFormField<Service>(
                          value: selectedService,
                          items: services.map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(s.name),
                          )).toList(),
                          onChanged: (val) => setState(() => selectedService = val),
                          decoration: const InputDecoration(
                            labelText: 'Tipo de servicio',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, _) => Text('Error: $e'),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _selectDateTime,
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: dateTimeController,
                            decoration: const InputDecoration(
                              labelText: 'Hora',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'Selecciona una fecha y hora',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          labelText: 'Celular',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedService != null &&
                          selectedDateTime != null) {
                        final start = selectedDateTime!;
                        final end = start.add(Duration(minutes: selectedService!.duration));

                        final appointment = Appointment(
                          clientName: nameController.text,
                          barberId: 'barber123', // cambiar por ID real si aplica
                          startTime: start,
                          endTime: end,
                          serviceId: selectedService!.id,
                        );

                        await notifier.submit(appointment);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reserva creada')),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Crear', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
