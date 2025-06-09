// lib/data/datasources/dashboard_remote_datasource.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/summary_entity.dart';

class DashboardRemoteDatasource {
  final String baseUrl = 'http://localhost:3000';

  Future<Appointment> fetchNextAppointment() async {
    final response =
        await http.get(Uri.parse('$baseUrl/appointment/next-appointment'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("data: $data");
      return Appointment.fromJson(data);
    } else {
      throw Exception('Error al cargar el próximo turno');
    }
  }

  Future<SummaryEntity> fetchDailySummary() async {

    
    final response =await http.get(Uri.parse('$baseUrl/appointment/daily-summary'));
    
    print("response.statusCode: ${response.statusCode}");
    
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
     
      return SummaryEntity.fromJson(data);
    } else {
      throw Exception('Error al cargar el resumen del día');
    }
  }
}
