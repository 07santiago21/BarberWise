import 'haircut_type.dart';

class Haircut {
  final String client;
  final String cellphone;
  final DateTime date;
  final HaircutType type;

  Haircut({
    required this.client,
    required this.cellphone,
    required this.date,
    required this.type,
  });
}
