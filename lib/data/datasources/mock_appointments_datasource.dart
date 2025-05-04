import 'package:barber/domain/entities/appointments.dart';
import 'package:barber/domain/entities/services.dart';
import 'mock_services_datasource.dart';

class MockAppointmentsDatasource {
  final List<Service> services = MockServicesDatasource().services;
  final List<Appointments> allAppointments = [];

  MockAppointmentsDatasource() {
    allAppointments.addAll([
      // 📅 6 de mayo
      Appointments(
        clientName: 'Juan Pérez',
        startTime: DateTime(2025, 5, 6, 9, 0),
        endTime: DateTime(2025, 5, 6, 9, 30),
        services: [services[0]], // Corte de pelo
      ),
      Appointments(
        clientName: 'María López',
        startTime: DateTime(2025, 5, 6, 10, 0),
        endTime: DateTime(2025, 5, 6, 10, 45),
        services: [services[1], services[3]], // Cejas + barba
      ),

      // 📅 8 de mayo
      Appointments(
        clientName: 'Carlos Gómez',
        startTime: DateTime(2025, 5, 8, 14, 0),
        endTime: DateTime(2025, 5, 8, 15, 0),
        services: [services[2]], // Coloración
      ),

      // 📅 10 de mayo
      Appointments(
        clientName: 'Ana Torres',
        startTime: DateTime(2025, 5, 10, 16, 0),
        endTime: DateTime(2025, 5, 10, 17, 0),
        services: [services[0], services[2]], // Corte de pelo + coloración
      ),
      Appointments(
        clientName: 'Luis Martínez',
        startTime: DateTime(2025, 5, 10, 17, 30),
        endTime: DateTime(2025, 5, 10, 18, 0),
        services: [services[3]], // Corte de barba
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
