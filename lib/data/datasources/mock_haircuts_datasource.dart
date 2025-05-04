import 'dart:math';

import '../../domain/entities/haircut.dart';
import '../../domain/entities/haircut_type.dart';

/// Mock que genera una lista de cortes de pelo entre dos fechas.
class MockHaircutsDatasource {
  Future<List<Haircut>> getHaircutsByRange(DateTime from, DateTime to) async {
    // Simulamos retraso de red
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();
    final days = to.difference(from).inDays;
    final List<Haircut> results = [];

    for (int i = 0; i <= days; i++) {
      final date = from.add(Duration(days: i));
      // De 1 a 5 cortes por día
      final count = random.nextInt(5) + 1;
      for (int j = 0; j < count; j++) {
        // Precio entre 20000 y 50000
        final price = 20000 + random.nextInt(30000);
        // Tipo aleatorio
        final type =
            HaircutType.values[random.nextInt(HaircutType.values.length)];
        results.add(Haircut(
          date: date.add(Duration(hours: j)),
          price: price.toDouble(),
          type: type,
        ));
      }
    }

    return results;
  }
}
