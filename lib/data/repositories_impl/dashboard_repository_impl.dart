import 'package:barber/domain/entities/appointment_entity.dart';
import 'package:barber/domain/entities/summary_entity.dart';
import 'package:barber/domain/repositories/dashboard_repository.dart';
import 'package:barber/data/datasources/mock_dashboard_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dataSource;

  DashboardRepositoryImpl(this.dataSource);

  @override
  Future<AppointmentEntity> getNextAppointment() {
    return dataSource.fetchNextAppointment();
  }

  @override
  Future<SummaryEntity> getDailySummary() {
    return dataSource.fetchDailySummary();
  }
}
