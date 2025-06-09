import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/summary_entity.dart';
import 'package:barber/domain/repositories/dashboard_repository.dart';
import 'package:barber/data/datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource dataSource;

  DashboardRepositoryImpl(this.dataSource);

  @override
  Future<Appointment> getNextAppointment() {
    return dataSource.fetchNextAppointment();
  }

  @override
  Future<SummaryEntity> getDailySummary() {
    return dataSource.fetchDailySummary();
  }
}
