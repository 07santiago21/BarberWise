import 'package:barber/data/datasources/mock_appointments_datasource.dart';
import 'package:barber/domain/entities/appointments.dart';
import 'package:barber/domain/repositories/appointments_repository.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final MockAppointmentsDatasource datasource;

  AppointmentsRepositoryImpl(this.datasource);

  @override
  Future<List<Appointments>> getAppointmentsByADate(date) {
    return datasource.getAppointmentsFor(date);
  }

}