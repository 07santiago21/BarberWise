/// Tipos de servicios
enum HaircutType {
  haircutOnly,
  beardOnly,
  combo,
}

extension HaircutTypeExtension on HaircutType {
  String get displayName {
    switch (this) {
      case HaircutType.haircutOnly:
        return 'Solo Corte';
      case HaircutType.beardOnly:
        return 'Solo Barba';
      case HaircutType.combo:
        return 'Combo';
    }
  }
}
