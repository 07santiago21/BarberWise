import 'package:barber/presentation/providers/appointment/appointments_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/appointments/appointments_card.dart';
import '../widgets/appointments/date_selector.dart';
import 'create_reservation_screen.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appointmentsProvider);
    final notifier = ref.read(appointmentsProvider.notifier);

    bool isSameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    final filteredAppointments = state.appointments.where((appt) {
      return isSameDay(appt.startTime, state.selectedDate);
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              DateFormat("d 'de' MMMM yyyy", 'es_ES')
                  .format(state.selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DateSelector(
              selectedDate: state.selectedDate,
              onDateSelected: (date) => notifier.selectDate(date),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredAppointments.isEmpty
                      ? const Center(
                          child: Text("No hay citas para esta fecha"))
                      : ListView.builder(
                          itemCount: filteredAppointments.length,
                          itemBuilder: (context, index) {
                            return AppointmentCard(
                                appointment: filteredAppointments[index]);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Crear cita',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
