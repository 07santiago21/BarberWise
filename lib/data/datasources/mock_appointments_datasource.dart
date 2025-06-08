import 'package:barber/domain/entities/appointments.dart';
import 'package:barber/domain/entities/services.dart';
import 'mock_services_datasource.dart';

class MockAppointmentsDatasource {
  final List<Service> services = MockServicesDatasource().services;
  final List<Appointments> allAppointments = [];

  MockAppointmentsDatasource() {
    final today = DateTime.now();
    final base = DateTime(today.year, today.month, today.day);

    allAppointments.addAll([
      Appointments(
        clientName: 'Fabio G.',
        startTime: base.add(const Duration(hours: 8)),
        endTime: base.add(const Duration(hours: 8, minutes: 30)),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'Margarita D.',
        startTime: base.add(const Duration(hours: 9)),
        endTime: base.add(const Duration(hours: 9, minutes: 20)),
        services: [services[1]],
      ),
      Appointments(
        clientName: 'Jorge T.',
        startTime: base.add(const Duration(hours: 10)),
        endTime: base.add(const Duration(hours: 11)),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Juan David R.',
        startTime: base.add(const Duration(hours: 11, minutes: 30)),
        endTime: base.add(const Duration(hours: 12)),
        services: [services[3]],
      ),
      Appointments(
        clientName: 'Sebastian P.',
        startTime: base.add(const Duration(hours: 12, minutes: 30)),
        endTime: base.add(const Duration(hours: 13)),
        services: [services[0], services[3]],
      ),
      Appointments(
        clientName: 'Sofía R.',
        startTime: base.add(const Duration(days: 1, hours: 9)),
        endTime: base.add(const Duration(days: 1, hours: 9, minutes: 30)),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'Pedro Á.',
        startTime: base.add(const Duration(days: 1, hours: 10)),
        endTime: base.add(const Duration(days: 1, hours: 10, minutes: 20)),
        services: [services[1]],
      ),
      Appointments(
        clientName: 'María G.',
        startTime: base.add(const Duration(days: 1, hours: 11)),
        endTime: base.add(const Duration(days: 1, hours: 11, minutes: 25)),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Luis M.',
        startTime: base.add(const Duration(days: 1, hours: 12)),
        endTime: base.add(const Duration(days: 1, hours: 12, minutes: 30)),
        services: [services[3]],
      ),
      Appointments(
        clientName: 'Andrés H.',
        startTime: base.add(const Duration(days: 2, hours: 10)),
        endTime: base.add(const Duration(days: 2, hours: 10, minutes: 20)),
        services: [services[1]],
      ),
      Appointments(
        clientName: 'Carla R.',
        startTime: base.add(const Duration(days: 3, hours: 11)),
        endTime: base.add(const Duration(days: 3, hours: 11, minutes: 50)),
        services: [services[0], services[1]],
      ),
      Appointments(
        clientName: 'Diego V.',
        startTime: base.add(const Duration(days: 4, hours: 14)),
        endTime: base.add(const Duration(days: 4, hours: 14, minutes: 25)),
        services: [services[3]],
      ),
      Appointments(
        clientName: 'Elena C.',
        startTime: base.add(const Duration(days: 5, hours: 16, minutes: 30)),
        endTime: base.add(const Duration(days: 5, hours: 17, minutes: 30)),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Miguel D.',
        startTime: base.add(const Duration(days: 6, hours: 9)),
        endTime: base.add(const Duration(days: 6, hours: 9, minutes: 30)),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'Ana P.',
        startTime: base.add(const Duration(days: 6, hours: 10)),
        endTime: base.add(const Duration(days: 6, hours: 10, minutes: 45)),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Juan P.',
        startTime: base.add(const Duration(days: 7, hours: 9)),
        endTime: base.add(const Duration(days: 7, hours: 9, minutes: 30)),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'María L.',
        startTime: base.add(const Duration(days: 7, hours: 10)),
        endTime: base.add(const Duration(days: 7, hours: 10, minutes: 45)),
        services: [services[1], services[3]],
      ),
      Appointments(
        clientName: 'Carlos G.',
        startTime: base.add(const Duration(days: 9, hours: 14)),
        endTime: base.add(const Duration(days: 9, hours: 15)),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Ana T.',
        startTime: base.add(const Duration(days: 11, hours: 16)),
        endTime: base.add(const Duration(days: 11, hours: 17)),
        services: [services[0], services[2]],
      ),
      Appointments(
        clientName: 'Luis M.',
        startTime: base.add(const Duration(days: 15, hours: 17, minutes: 30)),
        endTime: base.add(const Duration(days: 15, hours: 18)),
        services: [services[3]],
      ),
    ]);
  }

  Future<List<Appointments>> getAppointmentsFor(DateTime date) async {
    return allAppointments.where((appt) {
      final d = appt.startTime;
      return d.year == date.year && d.month == date.month && d.day == date.day;
    }).toList();
  }
}
