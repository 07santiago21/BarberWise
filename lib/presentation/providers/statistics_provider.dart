/*import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:flutter/material.dart';

import '../../domain/enums/time_filter.dart';
import '../../domain/usecases/get_appointments_by_range.dart';
import '../../domain/usecases/count_appointments.dart';
import '../../domain/usecases/calculate_profits.dart';
import '../../domain/usecases/get_best_day.dart';
import '../../data/datasources/mock_appointments_datasource.dart';

class StatisticsProvider extends ChangeNotifier {
  final _datasource = MockAppointmentsDatasource();

  late final GetAppointmentsByRange _getByRange = GetAppointmentsByRange(
    (DateTime from, DateTime to) async {
      final List<Appointment> all = [];
      final days = to.difference(from).inDays;
      for (int i = 0; i <= days; i++) {
        final date =
            DateTime(from.year, from.month, from.day).add(Duration(days: i));
        final page = await _datasource.getAppointmentsFor(date);
        all.addAll(page);
      }
      return all;
    },
  );

  final CountAppointments _count = CountAppointments();
  final CalculateProfits _profits = CalculateProfits();
  final GetBestDay _bestDayUseCase = GetBestDay();

  TimeFilter _filter = TimeFilter.last7Days;
  List<Appointment> _appointments = [];
  double _totalProfit = 0;
  int _totalCount = 0;
  String _bestDayName = '';

  TimeFilter get filter => _filter;
  List<Appointment> get appointments => _appointments;
  double get totalProfit => _totalProfit;
  int get totalCount => _totalCount;
  String get bestDayName => _bestDayName;

  StatisticsProvider() {
    loadStatistics();
  }

  Future<void> setFilter(TimeFilter newFilter) async {
    _filter = newFilter;
    notifyListeners();
    await loadStatistics();
  }

  Future<void> loadStatistics() async {
    final from = _filter.startDate;
    final to = DateTime.now();

    _appointments = await _getByRange(from, to);

    _totalCount = _count(_appointments);
    _totalProfit = _profits(_appointments);
    _bestDayName = _bestDayUseCase(_appointments, _filter);

    notifyListeners();
  }
}
*/