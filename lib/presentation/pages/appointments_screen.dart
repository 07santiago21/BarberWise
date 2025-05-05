
import 'package:barber/presentation/pages/create_reservation_screen.dart';
import 'package:barber/presentation/widgets/appointments/appointments_card.dart';
import 'package:barber/presentation/widgets/appointments/date_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointments_provider.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppointmentsProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Agenda de citas')),
        body: Consumer<AppointmentsProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [

                  Text(
                    DateFormat("d 'de' MMMM yyyy", 'es_ES')
                        .format(provider.selectedDate),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  DateSelector(
                    selectedDate: provider.selectedDate,
                    onDateSelected: provider.selectDate,
                  ),
                  const SizedBox(height: 8),

                  Expanded(
                    child: provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : provider.appointments.isEmpty
                            ? const Center(
                                child: Text("No hay citas para esta fecha"),
                              )
                            : ListView.builder(
                                itemCount: provider.appointments.length,
                                itemBuilder: (context, index) {
                                  return AppointmentCard(
                                    appointment: provider.appointments[index],
                                  );
                                },
                              ),
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateReservationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Crear cita',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
