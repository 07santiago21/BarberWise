import 'package:barber/domain/entities/appointments.dart';

abstract class AppointmentsRepository {
  Future<List<Appointments>> getAppointmentsByADate(DateTime date);
}