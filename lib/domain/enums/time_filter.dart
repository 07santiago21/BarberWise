/// Filtros temporales para estadísticas
enum TimeFilter {
  last5Days,
  last7Days,
  last30Days,
}

extension TimeFilterExtension on TimeFilter {
  /// Cuántos días atrás incluye el filtro
  int get days {
    switch (this) {
      case TimeFilter.last5Days:
        return 5;
      case TimeFilter.last7Days:
        return 7;
      case TimeFilter.last30Days:
        return 30;
    }
  }

  /// Nombre para mostrar en la UI
  String get displayName {
    switch (this) {
      case TimeFilter.last5Days:
        return '5 días';
      case TimeFilter.last7Days:
        return '7 días';
      case TimeFilter.last30Days:
        return '30 días';
    }
  }

  /// Fecha de inicio (hoy menos [days]−1, para incluir hoy)
  DateTime get startDate => DateTime.now().subtract(Duration(days: days - 1));
}
