import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/summary_entity.dart';

class DashboardRemoteDatasource {
  final String baseUrl = 'https://barberwise-nest.onrender.com';

  Future<Appointment> fetchNextAppointment() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No hay un usuario autenticado');
    }
    final uid = user.uid;

    final url = Uri.parse('$baseUrl/appointment/next-appointment/$uid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Appointment.fromJson(data);
    } else {
      throw Exception(
          'Error al cargar el próximo turno (status: ${response.statusCode})');
    }
  }

  Future<SummaryEntity> fetchDailySummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No hay un usuario autenticado');
    }
    final uid = user.uid;

    final url = Uri.parse('$baseUrl/appointment/daily-summary/$uid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return SummaryEntity.fromJson(data);
    } else {
      throw Exception(
          'Error al cargar el resumen del día (status: ${response.statusCode})');
    }
  }
}
