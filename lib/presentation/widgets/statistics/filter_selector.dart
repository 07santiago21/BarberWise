import 'package:flutter/material.dart';
import '../../../domain/enums/time_filter.dart';

class FilterSelector extends StatelessWidget {
  final TimeFilter current;
  final Future<void> Function(TimeFilter) onChanged;

  const FilterSelector({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TimeFilter>(
      value: current,
      items: TimeFilter.values
          .map((f) => DropdownMenuItem(
                value: f,
                child: Text(f.displayName),
              ))
          .toList(),
      onChanged: (f) {
        if (f != null) onChanged(f);
      },
      isExpanded: true,
    );
  }
}
