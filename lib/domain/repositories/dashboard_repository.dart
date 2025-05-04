import 'package:barber/domain/entities/appointment_entity.dart';
import 'package:barber/domain/entities/summary_entity.dart';

abstract class DashboardRepository {
  Future<AppointmentEntity> getNextAppointment();
  Future<SummaryEntity> getDailySummary();
}
