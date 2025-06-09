import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:http/http.dart' as http;

class ApiAppointmentsDatasource {
  final String baseUrl;

  ApiAppointmentsDatasource({required this.baseUrl});

  Future<List<Appointment>> getAppointmentsByDate(DateTime date) async {
    final formatted = date.toIso8601String().split('T').first;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final uid = user.uid;

    final url = Uri.parse(
      '$baseUrl/appointment?date=$formatted&barber_id=$uid',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Error al obtener citas (status: ${response.statusCode})');
    }

    final List data = jsonDecode(response.body) as List;
    return data.map((json) => Appointment.fromJson(json)).toList();
  }
}
