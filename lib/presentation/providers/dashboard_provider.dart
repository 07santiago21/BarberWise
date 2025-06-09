import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barber/data/datasources/dashboard_remote_datasource.dart';
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:barber/domain/entities/summary_entity.dart';

class DashboardState {
  final Appointment? nextAppointment;
  final SummaryEntity? summary;
  final bool isLoading;
  final String? error;

  DashboardState({
    this.nextAppointment,
    this.summary,
    this.isLoading = false,
    this.error,
  });

  factory DashboardState.initial() {
    return DashboardState(
      nextAppointment: null,
      summary: null,
      isLoading: true,
      error: null,
    );
  }

  DashboardState copyWith({
    Appointment? nextAppointment,
    SummaryEntity? summary,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      nextAppointment: nextAppointment ?? this.nextAppointment,
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this._dashboardDataSource)
      : super(DashboardState.initial());

  final DashboardRemoteDatasource _dashboardDataSource;
  bool _loaded = false;

  Future<void> loadDashboardData() async {
    if (_loaded) return;
    _loaded = true;

    try {
      state = state.copyWith(isLoading: true);

      final appointment = await _dashboardDataSource.fetchNextAppointment();
      final summary = await _dashboardDataSource.fetchDailySummary();
      

      state = state.copyWith(
        nextAppointment: appointment,
        summary: summary,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(DashboardRemoteDatasource());
});
