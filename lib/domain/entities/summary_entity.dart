// lib/domain/entities/summary_entity.dart
class SummaryEntity {
  final int completedTurns;
  final int totalTurns;
  final double currentEarnings;
  final double estimatedEarnings;

  SummaryEntity({
    required this.completedTurns,
    required this.totalTurns,
    required this.currentEarnings,
    required this.estimatedEarnings,
  });
}
