import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/statistics_provider.dart';
import '../widgets/statistics/filter_selector.dart';
import '../widgets/statistics/haircuts_bar_chart.dart';
import '../widgets/statistics/stat_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatisticsProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Estadísticas')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<StatisticsProvider>(
            builder: (context, prov, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilterSelector(
                    current: prov.filter,
                    onChanged: prov.setFilter,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: HaircutsBarChart(
                      data: prov.services,
                      filter: prov.filter,
                    ),
                  ),
                  const SizedBox(height: 24),
                  StatCard(
                    icon: Icons.attach_money,
                    label: 'Total generado',
                    value: '\$${prov.totalProfit.toStringAsFixed(0)}',
                  ),
                  const SizedBox(height: 12),
                  StatCard(
                    icon: Icons.content_cut,
                    label: 'Servicios realizados',
                    value: prov.totalCount.toString(),
                  ),
                  const SizedBox(height: 12),
                  StatCard(
                    icon: Icons.star,
                    label: 'Mejor día',
                    value: prov.bestDayName,
                  ),
                ],
              );
            },
          ),
        ),
        // El navbar lo implementará tu compañero; aquí no lo incluimos
      ),
    );
  }
}
