import 'package:barber/domain/entities/services.dart';

class Appointments {
  final String clientName;
  final DateTime startTime;
  final DateTime endTime;
  final List<Service> services;

  late final double totalPrice;

  Appointments({
    required this.clientName,
    required this.startTime,
    required this.endTime,
    required this.services,
  }) {
    totalPrice = services.fold(0, (sum, s) => sum + s.price);
  }
}
