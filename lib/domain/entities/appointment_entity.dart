import 'package:barber/domain/entities/haircut_type.dart';

class AppointmentEntity {
  final String clientName;
  final DateTime date;
  final HaircutType type;
  final double price;

  AppointmentEntity({
    required this.clientName,
    required this.date,
    required this.type,
    required this.price,
  });
}
