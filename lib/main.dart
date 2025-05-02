import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ✅ Importas los datos simulados correctamente
import 'data/datasources/mock_haircuts_datasource.dart';

import 'domain/usecases/get_haircuts_by_range.dart';
import 'domain/usecases/count_haircuts.dart';
import 'domain/usecases/calculate_profits.dart';
import 'domain/usecases/get_best_day.dart';

import 'presentation/providers/StatisticsProvider.dart';
import 'presentation/pages/StatisticsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StatisticsProvider(
            getHaircutsByRange: GetHaircutsByRange(),
            countHaircuts: CountHaircuts(),
            calculateProfits: CalculateProfits(),
            getBestDay: GetBestDay(),
            // ✅ Aquí usas el mock correctamente
            initialHaircuts: haircutsMock,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barber Stats',
        home: const StatisticsScreen(),
      ),
    );
  }
}
