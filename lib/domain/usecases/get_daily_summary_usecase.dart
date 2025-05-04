import 'package:barber/domain/entities/summary_entity.dart';
import 'package:barber/domain/repositories/dashboard_repository.dart';

class GetDailySummaryUseCase {
  final DashboardRepository repository;

  GetDailySummaryUseCase(this.repository);

  Future<SummaryEntity> call() {
    return repository.getDailySummary();
  }
}
