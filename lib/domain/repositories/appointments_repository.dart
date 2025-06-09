import 'package:barber/domain/entities/appointment_entity_.dart';

abstract class AppointmentsRepository {
  Future<List<Appointment>> getAppointmentsByADate(DateTime date);
}
