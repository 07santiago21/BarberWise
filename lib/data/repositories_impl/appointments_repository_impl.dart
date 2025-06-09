import 'package:barber/data/datasources/api_appointments_datasource.dart';
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/repositories/appointments_repository.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final ApiAppointmentsDatasource datasource;

  AppointmentsRepositoryImpl(this.datasource);

  @override
  Future<List<Appointment>> getAppointmentsByADate(date) {
    return datasource.getAppointmentsByDate(date);
  }
}
