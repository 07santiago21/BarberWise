import 'package:flutter/material.dart';
import '../../../domain/entities/haircut.dart';
import '../../../domain/enums/time_filter.dart';

/// Placeholder de gráfica de barras.
/// Más adelante puedes sustituirlo por una implementación real
/// (p. ej. fl_chart o charts_flutter).
class HaircutsBarChart extends StatelessWidget {
  final List<Haircut> data;
  final TimeFilter filter;

  const HaircutsBarChart({
    Key? key,
    required this.data,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: const Text('Aquí irá la gráfica de barras'),
    );
  }
}
