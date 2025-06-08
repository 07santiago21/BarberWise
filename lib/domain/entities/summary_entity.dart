// lib/domain/entities/summary_entity.dart

class SummaryEntity {
  final int completedTurns;
  final int totalTurns;
  final int currentEarnings;
  final int estimatedEarnings;

  SummaryEntity({
    required this.completedTurns,
    required this.totalTurns,
    required this.currentEarnings,
    required this.estimatedEarnings,
  });

  factory SummaryEntity.fromJson(Map<String, dynamic> json) => SummaryEntity(
        completedTurns: json['completedTurns'],
        totalTurns: json['totalTurns'],
        currentEarnings: json['currentEarnings'],
        estimatedEarnings: json['estimatedEarnings'],
      );
}
