import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/services_entity_.dart';
import 'mock_services_datasource.dart';

class MockAppointmentsDatasource {
  final List<Service> services = MockServicesDatasource().services;
  final List<Appointment> allAppointments = [];

  MockAppointmentsDatasource() {
    final today = DateTime.now();
    final base = DateTime(today.year, today.month, today.day);

    allAppointments.addAll([
      Appointment(
        clientName: 'Fabio G.',
        startTime: base.add(const Duration(hours: 8)),
        endTime: base.add(const Duration(hours: 8, minutes: 30)),
        barberId: 'barber-1',
        serviceId: "aaa",
      ),
      Appointment(
        clientName: 'Margarita D.',
        startTime: base.add(const Duration(hours: 9)),
        endTime: base.add(const Duration(hours: 9, minutes: 20)),
        barberId: 'barber-1',
        serviceId: "bbb",
      ),
      Appointment(
        clientName: 'Jorge T.',
        startTime: base.add(const Duration(hours: 10)),
        endTime: base.add(const Duration(hours: 11)),
        barberId: 'barber-1',
        serviceId: "ccc",
      ),
      Appointment(
        clientName: 'Juan David R.',
        startTime: base.add(const Duration(hours: 11, minutes: 30)),
        endTime: base.add(const Duration(hours: 12)),
        barberId: 'barber-1',
        serviceId: "ddd",
      ),
      Appointment(
        clientName: 'Sebastian P.',
        startTime: base.add(const Duration(hours: 12, minutes: 30)),
        endTime: base.add(const Duration(hours: 13)),
        barberId: 'barber-1',
        serviceId: "eee",
      ),
      Appointment(
        clientName: 'Sofía R.',
        startTime: base.add(const Duration(days: 1, hours: 9)),
        endTime: base.add(const Duration(days: 1, hours: 9, minutes: 30)),
        barberId: 'barber-1',
        serviceId: "fff",
      ),
    ]);
  }

  Future<List<Appointment>> getAppointmentsFor(DateTime date) async {
    return allAppointments.where((appt) {
      final d = appt.startTime;
      return d.year == date.year && d.month == date.month && d.day == date.day;
    }).toList();
  }
}
