import 'package:barber/domain/entities/appointment_entity_.dart';

class GetAppointmentsByRange {
  final Future<List<Appointment>> Function(DateTime from, DateTime to)
      repository;

  GetAppointmentsByRange(this.repository);

  Future<List<Appointment>> call(DateTime from, DateTime to) async {
    final all = await repository(from, to);
    return all
        .where((a) => !a.startTime.isBefore(from) && !a.startTime.isAfter(to))
        .toList();
  }
}
