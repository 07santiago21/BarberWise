import 'package:flutter/material.dart';

import '../../domain/enums/time_filter.dart';
import '../../domain/entities/services.dart';
import '../../domain/usecases/get_services_by_range.dart';
import '../../domain/usecases/count_services.dart';
import '../../domain/usecases/calculate_profits.dart';
import '../../domain/usecases/get_best_day.dart';
import '../../data/datasources/mock_services_datasource.dart';

class StatisticsProvider extends ChangeNotifier {
  final _datasource = MockServicesDatasource();

  // UseCases
  late final _getByRange = GetServiceByRange(
    _datasource.getServicesByRange,
  );
  final _count = CountServices();
  final _profits = CalculateProfits();
  final _bestDay = GetBestDay();

  // Estado
  TimeFilter _filter = TimeFilter.last5Days;
  List<Service> _services = [];
  double _totalProfit = 0;
  int _totalCount = 0;
  String _bestDayName = '';

  // Getters
  TimeFilter get filter => _filter;
  List<Service> get services => _services;
  double get totalProfit => _totalProfit;
  int get totalCount => _totalCount;
  String get bestDayName => _bestDayName;

  StatisticsProvider() {
    loadStatistics();
  }

  /// Cambia el filtro y recarga datos
  Future<void> setFilter(TimeFilter newFilter) async {
    _filter = newFilter;
    notifyListeners();
    await loadStatistics();
  }

  Future<void> loadStatistics() async {
    final from = _filter.startDate;
    final to = DateTime.now();
    _services = await _getByRange(from, to);
    _totalCount = _count(_services);
    _totalProfit = _profits(_services);
    _bestDayName = _bestDay(_services);
    notifyListeners();
  }
}
