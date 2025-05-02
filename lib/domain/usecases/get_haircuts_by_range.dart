import '../entities/haircut.dart';

class GetHaircutsByRange {
  List<Haircut> call(List<Haircut> cortes, DateTime inicio, DateTime fin) {
    return cortes.where((corte) {
      return corte.date.isAfter(inicio.subtract(Duration(seconds: 1))) &&
          corte.date.isBefore(fin.add(Duration(seconds: 1)));
    }).toList();
  }
}
