import 'package:barber/domain/entities/appointments.dart';
import 'package:barber/domain/entities/services.dart';
import 'mock_services_datasource.dart';

class MockAppointmentsDatasource {
  final List<Service> services = MockServicesDatasource().services;
  final List<Appointments> allAppointments = [];

  MockAppointmentsDatasource() {
    allAppointments.addAll([
      Appointments(
        clientName: 'Fabio G.',
        startTime: DateTime(2025, 4, 20, 8, 0),
        endTime: DateTime(2025, 4, 20, 8, 30),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'Margarita D.',
        startTime: DateTime(2025, 4, 20, 9, 0),
        endTime: DateTime(2025, 4, 20, 9, 20),
        services: [services[1]],
      ),
      Appointments(
        clientName: 'Jorge T.',
        startTime: DateTime(2025, 4, 20, 10, 0),
        endTime: DateTime(2025, 4, 20, 11, 0),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Juan David R.',
        startTime: DateTime(2025, 4, 20, 11, 30),
        endTime: DateTime(2025, 4, 20, 12, 0),
        services: [services[3]],
      ),
      Appointments(
        clientName: 'Sebastian P.',
        startTime: DateTime(2025, 4, 20, 12, 30),
        endTime: DateTime(2025, 4, 20, 13, 0),
        services: [services[0], services[3]],
      ),
      Appointments(
        clientName: 'Sofía R.',
        startTime: DateTime(2025, 4, 29, 9, 0),
        endTime: DateTime(2025, 4, 29, 9, 30),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'Pedro Á.',
        startTime: DateTime(2025, 4, 29, 10, 0),
        endTime: DateTime(2025, 4, 29, 10, 20),
        services: [services[1]],
      ),
      Appointments(
        clientName: 'María G.',
        startTime: DateTime(2025, 4, 29, 11, 0),
        endTime: DateTime(2025, 4, 29, 11, 25),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Luis M.',
        startTime: DateTime(2025, 4, 29, 12, 0),
        endTime: DateTime(2025, 4, 29, 12, 30),
        services: [services[3]],
      ),
      Appointments(
        clientName: 'Andrés H.',
        startTime: DateTime(2025, 5, 1, 10, 0),
        endTime: DateTime(2025, 5, 1, 10, 20),
        services: [services[1]],
      ),
      Appointments(
        clientName: 'Carla R.',
        startTime: DateTime(2025, 5, 2, 11, 0),
        endTime: DateTime(2025, 5, 2, 11, 50),
        services: [services[0], services[1]],
      ),
      Appointments(
        clientName: 'Diego V.',
        startTime: DateTime(2025, 5, 3, 14, 0),
        endTime: DateTime(2025, 5, 3, 14, 25),
        services: [services[3]],
      ),
      Appointments(
        clientName: 'Elena C.',
        startTime: DateTime(2025, 5, 4, 16, 30),
        endTime: DateTime(2025, 5, 4, 17, 30),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Miguel D.',
        startTime: DateTime(2025, 5, 5, 9, 0),
        endTime: DateTime(2025, 5, 5, 9, 30),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'Ana P.',
        startTime: DateTime(2025, 5, 5, 10, 0),
        endTime: DateTime(2025, 5, 5, 10, 45),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Juan P.',
        startTime: DateTime(2025, 5, 6, 9, 0),
        endTime: DateTime(2025, 5, 6, 9, 30),
        services: [services[0]],
      ),
      Appointments(
        clientName: 'María L.',
        startTime: DateTime(2025, 5, 6, 10, 0),
        endTime: DateTime(2025, 5, 6, 10, 45),
        services: [services[1], services[3]],
      ),
      Appointments(
        clientName: 'Carlos G.',
        startTime: DateTime(2025, 5, 8, 14, 0),
        endTime: DateTime(2025, 5, 8, 15, 0),
        services: [services[2]],
      ),
      Appointments(
        clientName: 'Ana T.',
        startTime: DateTime(2025, 5, 10, 16, 0),
        endTime: DateTime(2025, 5, 10, 17, 0),
        services: [services[0], services[2]],
      ),
      Appointments(
        clientName: 'Luis M.',
        startTime: DateTime(2025, 5, 10, 17, 30),
        endTime: DateTime(2025, 5, 10, 18, 0),
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
