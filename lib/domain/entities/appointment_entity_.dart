import 'package:barber/domain/entities/services_entity_.dart';

class Appointment {
  final String clientName;
  final String barberId;
  final DateTime startTime;
  final DateTime endTime;
  final String serviceId;
  final Service? service;

  Appointment({
    required this.clientName,
    required this.barberId,
    required this.startTime,
    required this.endTime,
    required this.serviceId,
    this.service
  });

  Map<String, dynamic> toJson() => {
        'clientName': clientName,
        'barberId': barberId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'serviceId': serviceId,
      };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        clientName: json['clientName'],
        barberId: json['BarberId'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['EndTime']),
        serviceId: json['service']?['id'],
        service: json['service'] != null ? Service.fromJson(json['service']) : null,
      );
}
