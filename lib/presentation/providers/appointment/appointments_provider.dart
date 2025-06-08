import 'package:barber/data/datasources/api_appointments_datasource.dart';
import 'package:barber/data/repositories_impl/appointments_repository_impl.dart';
import 'package:barber/domain/repositories/appointments_repository.dart';
import 'package:barber/domain/usecases/get_appointments_by_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'appointments_notifier.dart';
import 'appointments_state.dart';

// Datasource provider
final appointmentsDatasourceProvider = Provider<ApiAppointmentsDatasource>((ref) {
  return ApiAppointmentsDatasource(baseUrl: 'http://10.0.2.2:3000');
});

// Repository provider
final appointmentsRepositoryProvider = Provider<AppointmentsRepository>((ref) {
  return AppointmentsRepositoryImpl(ref.watch(appointmentsDatasourceProvider));
});

// Use case provider
final getAppointmentsByDateProvider = Provider<GetAppointmentsByDate>((ref) {
  return GetAppointmentsByDate(ref.watch(appointmentsRepositoryProvider));
});

// Notifier provider
final appointmentsProvider = StateNotifierProvider<AppointmentsNotifier, AppointmentsState>((ref) {
  return AppointmentsNotifier(ref.watch(getAppointmentsByDateProvider));
});

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
