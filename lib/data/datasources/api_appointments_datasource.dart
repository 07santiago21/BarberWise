import 'dart:convert';
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:http/http.dart' as http;

class ApiAppointmentsDatasource {
  final String baseUrl;

  ApiAppointmentsDatasource({required this.baseUrl});

  Future<List<Appointment>> getAppointmentsByDate(DateTime date) async {
    final formatted = date.toIso8601String().split('T').first;
    final url = Uri.parse('$baseUrl/appointment?date=$formatted');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error al obtener citas');
    }

    final List data = jsonDecode(response.body);
    return data.map((json) => Appointment.fromJson(json)).toList();
  }

  Future<void> createAppointment(Appointment appt) async {
    final url = Uri.parse('$baseUrl/appointments');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(appt.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear cita');
    }
  }
}
