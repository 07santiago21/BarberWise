import 'package:flutter/material.dart';

import '../../domain/enums/time_filter.dart';
import '../../domain/entities/haircut.dart';
import '../../domain/usecases/get_haircuts_by_range.dart';
import '../../domain/usecases/count_haircuts.dart';
import '../../domain/usecases/calculate_profits.dart';
import '../../domain/usecases/get_best_day.dart';
import '../../data/datasources/mock_haircuts_datasource.dart';

class StatisticsProvider extends ChangeNotifier {
  final _datasource = MockHaircutsDatasource();

  // UseCases
  late final _getByRange = GetHaircutsByRange(
    _datasource.getHaircutsByRange,
  );
  final _count = CountHaircuts();
  final _profits = CalculateProfits();
  final _bestDay = GetBestDay();

  // Estado
  TimeFilter _filter = TimeFilter.last5Days;
  List<Haircut> _haircuts = [];
  double _totalProfit = 0;
  int _totalCount = 0;
  String _bestDayName = '';

  // Getters
  TimeFilter get filter => _filter;
  List<Haircut> get haircuts => _haircuts;
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
    _haircuts = await _getByRange(from, to);
    _totalCount = _count(_haircuts);
    _totalProfit = _profits(_haircuts);
    _bestDayName = _bestDay(_haircuts);
    notifyListeners();
  }
}
