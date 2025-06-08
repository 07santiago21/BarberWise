import 'package:barber/domain/entities/services.dart';

class Appointments {
  final int id;
  final String clientName;
  final DateTime startTime;
  final DateTime endTime;
  final String barberId;
  final Service service;

  Appointments({
    required this.id,
    required this.clientName,
    required this.startTime,
    required this.endTime,
    required this.barberId,
    required this.service,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      id: json['id'],
      clientName: json['clientName'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['EndTime']),
      barberId: json['BarberId'],
      service: Service.fromJson(json['service']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'startTime': startTime.toIso8601String(),
      'EndTime': endTime.toIso8601String(),
      'BarberId': barberId,
      'serviceId': service.id, // clave foránea que el backend espera
    };
  }
}
