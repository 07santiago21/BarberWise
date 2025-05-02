import '../entities/haircut.dart';
import 'package:intl/intl.dart';

class GetBestDay {
  String call(List<Haircut> cortes) {
    final Map<String, double> gananciasPorDia = {};

    for (var corte in cortes) {
      final dia = DateFormat('yyyy-MM-dd').format(corte.date);
      gananciasPorDia[dia] = (gananciasPorDia[dia] ?? 0) + corte.type.price;
    }

    final mejorDia =
        gananciasPorDia.entries.reduce((a, b) => a.value > b.value ? a : b);

    final cortesEseDia = cortes
        .where((c) => DateFormat('yyyy-MM-dd').format(c.date) == mejorDia.key)
        .length;

    final fecha = DateFormat('EEEE d').format(DateTime.parse(mejorDia.key));

    return '$fecha - $cortesEseDia cortes / \$${mejorDia.value.toInt()}';
  }
}
