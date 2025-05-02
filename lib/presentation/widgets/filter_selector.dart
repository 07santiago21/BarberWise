import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/enums/time_filter.dart';
import '../providers/StatisticsProvider.dart';

class FilterSelector extends StatelessWidget {
  const FilterSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StatisticsProvider>(context);
    final selected = provider.selectedFilter;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: TimeFilter.values.map((filter) {
        final isSelected = selected == filter;
        return ChoiceChip(
          label: Text(_filterLabel(filter)),
          selected: isSelected,
          onSelected: (_) => provider.changeFilter(filter),
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList(),
    );
  }

  String _filterLabel(TimeFilter filter) {
    switch (filter) {
      case TimeFilter.week:
        return 'Semana';
      case TimeFilter.fortnight:
        return 'Quincena';
      case TimeFilter.month:
        return 'Mes';
    }
  }
}
