import 'package:barber/domain/usecases/get_appointments_by_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'appointments_notifier.dart';
import 'appointments_state.dart';

final appointmentsProvider = StateNotifierProvider<AppointmentsNotifier, AppointmentsState>(
  (ref) => AppointmentsNotifier(GetAppointmentsByDate()),
);
