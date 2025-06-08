import '../../domain/entities/appointment_entity_.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';

class GetNextAppointment {
  final DashboardRemoteDatasource datasource;
  GetNextAppointment(this.datasource);

  Future<Appointment> call() => datasource.fetchNextAppointment();
}