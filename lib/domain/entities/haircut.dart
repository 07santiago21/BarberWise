import 'haircut-type.dart';

class Corte {
  final String client;
  final String cellphone;
  final DateTime date;
  final HaircutType type;

  Corte({
    required this.client,
    required this.cellphone,
    required this.date,
    required this.type,
  });
}
