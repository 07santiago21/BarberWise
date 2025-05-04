import 'haircut_type.dart';

/// Entidad que representa un solo corte/barba
class Haircut {
  final DateTime date;
  final double price;
  final HaircutType type;

  Haircut({
    required this.date,
    required this.price,
    required this.type,
  });
}
