import 'package:barber/domain/entities/appointment_entity.dart';
import 'package:barber/domain/repositories/dashboard_repository.dart';

class GetNextAppointmentUseCase {
  final DashboardRepository repository;

  GetNextAppointmentUseCase(this.repository);

  Future<AppointmentEntity> call() {
    return repository.getNextAppointment();
  }
}
