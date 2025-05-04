import '../../data/datasources/mock_appointments_datasource.dart';
import '../entities/appointments.dart';

class GetAppointmentsByDate {
  final MockAppointmentsDatasource _datasource = MockAppointmentsDatasource();

  Future<List<Appointments>> call(DateTime date) async {
    final appointments = await _datasource.getAppointmentsFor(date);
    return appointments;
  }
}
