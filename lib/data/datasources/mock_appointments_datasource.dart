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
        id: 1,
        clientName: 'Fabio G.',
        startTime: base.add(const Duration(hours: 8)),
        endTime: base.add(const Duration(hours: 8, minutes: 30)),
        barberId: 'barber-1',
        service: services[0],
      ),
      Appointments(
        id: 2,
        clientName: 'Margarita D.',
        startTime: base.add(const Duration(hours: 9)),
        endTime: base.add(const Duration(hours: 9, minutes: 20)),
        barberId: 'barber-1',
        service: services[1],
      ),
      Appointments(
        id: 3,
        clientName: 'Jorge T.',
        startTime: base.add(const Duration(hours: 10)),
        endTime: base.add(const Duration(hours: 11)),
        barberId: 'barber-1',
        service: services[2],
      ),
      Appointments(
        id: 4,
        clientName: 'Juan David R.',
        startTime: base.add(const Duration(hours: 11, minutes: 30)),
        endTime: base.add(const Duration(hours: 12)),
        barberId: 'barber-1',
        service: services[3],
      ),
      // Las siguientes citas fueron modificadas para usar un solo servicio (el primero de la lista)
      Appointments(
        id: 5,
        clientName: 'Sebastian P.',
        startTime: base.add(const Duration(hours: 12, minutes: 30)),
        endTime: base.add(const Duration(hours: 13)),
        barberId: 'barber-1',
        service: services[0],
      ),
      Appointments(
        id: 6,
        clientName: 'Sofía R.',
        startTime: base.add(const Duration(days: 1, hours: 9)),
        endTime: base.add(const Duration(days: 1, hours: 9, minutes: 30)),
        barberId: 'barber-1',
        service: services[0],
      ),
      // ... puedes seguir con las demás usando solo un service
    ]);
  }

  Future<List<Appointments>> getAppointmentsFor(DateTime date) async {
    return allAppointments.where((appt) {
      final d = appt.startTime;
      return d.year == date.year && d.month == date.month && d.day == date.day;
    }).toList();
  }
}
