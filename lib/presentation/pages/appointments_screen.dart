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
            return Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  DateFormat("d 'de' MMMM yyyy", 'es_ES')
                      .format(provider.selectedDate),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
                              child: Text("No hay citas para esta fecha"))
                          : ListView.builder(
                              itemCount: provider.appointments.length,
                              itemBuilder: (context, index) {
                                return AppointmentCard(
                                  appointment: provider.appointments[index],
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
