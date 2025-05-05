import '../entities/appointments.dart';

class GetAppointmentsByRange {
  final Future<List<Appointments>> Function(DateTime from, DateTime to)
      repository;

  GetAppointmentsByRange(this.repository);

  Future<List<Appointments>> call(DateTime from, DateTime to) async {
    final all = await repository(from, to);
    return all
        .where((a) => !a.startTime.isBefore(from) && !a.startTime.isAfter(to))
        .toList();
  }
}
