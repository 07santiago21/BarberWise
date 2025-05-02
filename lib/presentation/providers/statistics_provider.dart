import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/haircut.dart';
import '../../domain/enums/time_filter.dart';
import '../../domain/usecases/calculate_profits.dart';
import '../../domain/usecases/count_haircuts.dart';
import '../../domain/usecases/get_best_day.dart';
import '../../domain/usecases/get_haircuts_by_range.dart';

class StatisticsProvider with ChangeNotifier {
  TimeFilter _selectedFilter = TimeFilter.week;

  // Getters
  TimeFilter get selectedFilter => _selectedFilter;
  List<Haircut> get haircutsFilters => _filteredHaircuts;
  int get totalHaircuts => _totalhaircuts;
  double get totalProfit => _totalProfit;
  String get bestDay => _bestDay;
  Map<String, int> get haircutsPerDay {
    Map<String, int> counts = {};
    final formatter = DateFormat('E'); // 'Mon', 'Tue', etc.

    for (final haircut in _filteredHaircuts) {
      final day = formatter.format(haircut.date);
      counts[day] = (counts[day] ?? 0) + 1;
    }

    return counts;
  }

  // Casos de uso (inyectados desde afuera si deseas hacerlo más limpio)
  final GetHaircutsByRange getHaircutsByRange;
  final CountHaircuts countHaircuts;
  final CalculateProfits calculateProfits;
  final GetBestDay getBestDay;

  // Datos internos
  List<Haircut> _allHaircuts = []; // Simulados o "quemados"
  List<Haircut> _filteredHaircuts = [];
  int _totalhaircuts = 0;
  double _totalProfit = 0;
  String _bestDay = '';

  StatisticsProvider({
    required this.getHaircutsByRange,
    required this.countHaircuts,
    required this.calculateProfits,
    required this.getBestDay,
    required List<Haircut> initialHaircuts,
  }) {
    _allHaircuts = initialHaircuts;
    _applyFilters(); // Carga inicial
  }

  void changeFilter(TimeFilter newFilter) {
    _selectedFilter = newFilter;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    final range = getRangeFromFilter(_selectedFilter);
    _filteredHaircuts =
        getHaircutsByRange(_allHaircuts, range.start, range.end);
    _totalhaircuts = countHaircuts(_filteredHaircuts);
    _totalProfit = calculateProfits(_filteredHaircuts);
    _bestDay = getBestDay(_filteredHaircuts);
  }

  DateTimeRange getRangeFromFilter(TimeFilter filter) {
    final now = DateTime.now();

    switch (filter) {
      case TimeFilter.week:
        return DateTimeRange(
          start: now.subtract(const Duration(days: 7)),
          end: now,
        );
      case TimeFilter.fortnight:
        return DateTimeRange(
          start: now.subtract(const Duration(days: 15)),
          end: now,
        );
      case TimeFilter.month:
        return DateTimeRange(
          start: DateTime(now.year, now.month - 1, now.day),
          end: now,
        );
    }
  }
}
