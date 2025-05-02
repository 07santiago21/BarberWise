import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/statistics/haircuts_bar_chart.dart';
import '../providers/statistics_provider.dart';
import '../widgets/filter_selector.dart'; // Asegúrate de importar correctamente
import '../widgets/stat_card.dart'; // Si decides separar también StatCard

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StatisticsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FilterSelector(), // 🔁 Reemplaza los ChoiceChips por este widget
            const SizedBox(height: 20),
            // Gráfica
            HaircutsBarChart(
              countsPerDay: provider.haircutsPerDay.values.toList(),
              labels: provider.haircutsPerDay.keys.toList(),
            ),
            const SizedBox(height: 20),
            // Tarjetas de estadísticas
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  StatCard(
                    title: 'Total Haircuts',
                    value: provider.totalHaircuts.toString(),
                    icon: Icons.cut,
                    color: Colors.blue,
                  ),
                  StatCard(
                    title: 'Total Earned',
                    value: '\$${provider.totalProfit.toStringAsFixed(0)}',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  StatCard(
                    title: 'Best Day',
                    value: provider.bestDay,
                    icon: Icons.calendar_today,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
