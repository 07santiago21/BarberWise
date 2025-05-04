import '../entities/services.dart';

/// Determina el día (nombre) con más cortes
class GetBestDay {
  String call(List<Service> haircuts) {
    if (haircuts.isEmpty) return '';

    // Agrupamos por día (solo fecha)
    final Map<DateTime, int> counts = {};
    for (var h in haircuts) {
      final day = DateTime(h.date.year, h.date.month, h.date.day);
      counts[day] = (counts[day] ?? 0) + 1;
    }

    // Buscamos el día con más cortes
    final bestEntry =
        counts.entries.reduce((a, b) => a.value > b.value ? a : b);
    final weekday = bestEntry.key.weekday;
    const nombres = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    return nombres[weekday - 1];
  }
}
