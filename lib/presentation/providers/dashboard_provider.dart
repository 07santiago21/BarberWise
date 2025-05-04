import 'package:barber/domain/entities/appointment_entity.dart';
import 'package:barber/domain/entities/summary_entity.dart';
import 'package:barber/data/datasources/mock_dashboard_datasource.dart';
import 'package:barber/data/repositories_impl/dashboard_repository_impl.dart';
import 'package:barber/domain/usecases/get_daily_summary_usecase.dart';
import 'package:barber/domain/usecases/get_next_appointment_usecase.dart';

class DashboardProvider {
  final _repository = DashboardRepositoryImpl(DashboardRemoteDataSource());

  AppointmentEntity? nextAppointment;
  SummaryEntity? dailySummary;

  Future<void> loadDashboardData() async {
    final nextAppointmentUseCase = GetNextAppointmentUseCase(_repository);
    final dailySummaryUseCase = GetDailySummaryUseCase(_repository);

    nextAppointment = await nextAppointmentUseCase();
    dailySummary = await dailySummaryUseCase();
  }
}
