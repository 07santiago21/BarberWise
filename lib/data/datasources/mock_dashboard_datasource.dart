import 'package:barber/domain/entities/appointment_entity.dart';
import 'package:barber/domain/entities/haircut_type.dart.dart';
import 'package:barber/domain/entities/summary_entity.dart';

class DashboardRemoteDataSource {
  Future<AppointmentEntity> fetchNextAppointment() async {
    return AppointmentEntity(
      clientName: 'Juannnn Pérez',
      date: DateTime.now().add(const Duration(hours: 1)),
      type: HaircutType.haircutOnly,
      price: 12000,
    );
  }

  Future<SummaryEntity> fetchDailySummary() async {
    return SummaryEntity(
      completedTurns: 6,
      totalTurns: 11,
      currentEarnings: 12000,
      estimatedEarnings: 70000,
    );
  }
}
