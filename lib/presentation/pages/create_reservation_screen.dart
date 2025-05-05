import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barber/presentation/pages/dashboard_screen.dart';
import 'package:barber/domain/entities/haircut_type.dart.dart';

class CreateReservationScreen extends StatefulWidget {
  const CreateReservationScreen({super.key});

  @override
  State<CreateReservationScreen> createState() => _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();

  HaircutType? selectedHaircutType;
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('Crear reserva'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
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

                      DropdownButtonFormField<HaircutType>(
                        value: selectedHaircutType,
                        items: HaircutType.values
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.displayName),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => selectedHaircutType = value),
                        decoration: const InputDecoration(
                          labelText: 'Tipo de reserva',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
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
                        keyboardType: TextInputType.number,
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

                const SizedBox(height: 82),

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final nombre = nameController.text;
                          final tipo = selectedHaircutType?.displayName ?? 'No seleccionado';
                          final celular = phoneController.text;
                          final hora = selectedDateTime?.toString() ?? 'No seleccionada';

                          print('📝 Reserva creada:');
                          print('Nombre: $nombre');
                          print('Tipo: $tipo');
                          print('Hora: $hora');
                          print('Celular: $celular');

                          nameController.clear();
                          phoneController.clear();
                          dateTimeController.clear();
                          setState(() {
                            selectedHaircutType = null;
                            selectedDateTime = null;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reserva creada correctamente')),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const DashboardScreen()),
                          );
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
