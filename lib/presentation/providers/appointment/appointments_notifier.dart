
import 'package:barber/domain/usecases/get_appointments_by_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'appointments_state.dart';

class AppointmentsNotifier extends StateNotifier<AppointmentsState> {
  final GetAppointmentsByDate _getAppointments;

  AppointmentsNotifier(this._getAppointments)
      : super(AppointmentsState.initial()) {
    loadAppointments();
  }

  Future<void> selectDate(DateTime date) async {
    state = state.copyWith(selectedDate: date, isLoading: true);
    final appts = await _getAppointments(date);
    state = state.copyWith(appointments: appts, isLoading: false);
  }

  Future<void> loadAppointments() async {
    state = state.copyWith(isLoading: true);
    final appts = await _getAppointments(state.selectedDate);
    state = state.copyWith(appointments: appts, isLoading: false);
  }
}
