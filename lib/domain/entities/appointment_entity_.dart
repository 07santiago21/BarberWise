class Appointment {
  final String clientName;
  final String barberId;
  final DateTime startTime;
  final DateTime endTime;
  final String serviceId;

  Appointment({
    required this.clientName,
    required this.barberId,
    required this.startTime,
    required this.endTime,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() => {
        'clientName': clientName,
        'barberId': barberId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'serviceId': serviceId,
      };
}