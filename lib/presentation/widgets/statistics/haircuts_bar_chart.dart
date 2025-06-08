// lib/presentation/widgets/statistics/haircuts_bar_chart.dart
/*
import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../domain/enums/time_filter.dart';

class HaircutsBarChart extends StatelessWidget {
  /// Lista de todas las citas ya filtradas en el provider
  final List<Appointment> data;

  /// Filtro actual (7, 15 o 30 días)
  final TimeFilter filter;

  const HaircutsBarChart({
    Key? key,
    required this.data,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) Definir rango
    final from = filter.startDate;
    final to = DateTime.now();
    final totalDays = to.difference(from).inDays + 1;

    // 2) Decidir agrupación: diaria o semanal (para 30d)
    final bool groupByWeek = filter == TimeFilter.last30Days;
    final int groupCount = groupByWeek ? 4 : totalDays;

    // 3) Contar servicios en cada bucket
    final counts = <int, int>{};
    for (var appt in data) {
      final svcCount = appt.services.length;
      if (svcCount == 0) continue;

      final diff = appt.startTime.difference(from).inDays;
      final bucket = groupByWeek ? (diff * groupCount ~/ totalDays) : diff;

      counts[bucket] = (counts[bucket] ?? 0) + svcCount;
    }

    // 4) Construir grupos de barras
    final bars = List<BarChartGroupData>.generate(groupCount, (i) {
      final y = counts[i]?.toDouble() ?? 0;
      return BarChartGroupData(
        x: i,
        barRods: [BarChartRodData(toY: y, width: 12)],
      );
    });

    // 5) Crear etiquetas de eje X
    final titles = <int, String>{};
    for (var i = 0; i < groupCount; i++) {
      if (groupByWeek) {
        final span = totalDays / groupCount;
        final startOff = (i * span).floor();
        final endOff = (((i + 1) * span).ceil() - 1);
        final a = from.add(Duration(days: startOff));
        final b = from.add(Duration(days: endOff));
        titles[i] = '${a.day}–${b.day}';
      } else {
        final d = from.add(Duration(days: i));
        titles[i] = '${d.day}';
      }
    }

    // 6) Renderizar el chart
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: (counts.values.isEmpty
                    ? 1
                    : counts.values.reduce((a, b) => a > b ? a : b)) +
                1,
            barGroups: bars,

            // Desactivar interacciones internas
            barTouchData: BarTouchData(enabled: false),

            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(titles[idx] ?? ''),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    if (value % 1 != 0) return const SizedBox.shrink();
                    return Text(value.toInt().toString());
                  },
                ),
              ),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),

            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}
*/