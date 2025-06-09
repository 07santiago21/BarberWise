import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/summary_entity.dart';

abstract class DashboardRepository {
  Future<Appointment> getNextAppointment();
  Future<SummaryEntity> getDailySummary();
}
