import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/repositories/appointments_repository.dart';

class GetAppointmentsByDate {
  final AppointmentsRepository repository;

  GetAppointmentsByDate(this.repository);

  Future<List<Appointment>> call(DateTime date) async {
    return repository.getAppointmentsByADate(date);
  }
}
