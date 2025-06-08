import 'package:barber/domain/repositories/appointments_repository.dart';
import '../entities/appointments.dart';

class GetAppointmentsByDate {
  final AppointmentsRepository repository;

  GetAppointmentsByDate(this.repository);

  Future<List<Appointments>> call(DateTime date) async {
    return repository.getAppointmentsByADate(date);
  }
}
