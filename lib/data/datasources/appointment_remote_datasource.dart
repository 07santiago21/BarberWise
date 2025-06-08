import 'dart:convert';
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/services_entity_.dart';
import 'package:http/http.dart' as http;

class AppointmentRemoteDatasource {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Service>> getServices() async {
    final response = await http.get(Uri.parse('$baseUrl/service'));
    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((e) => Service.fromJson(e)).toList();
    }
    throw Exception('Error al obtener servicios');
  }

  Future<void> createAppointment(Appointment appointment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/appointment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(appointment.toJson()),
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    if (response.statusCode != 201) {
      throw Exception('Error al crear la cita');
    }
  }
}
