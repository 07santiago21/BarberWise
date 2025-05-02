import '../entities/haircut.dart';

class CalculateProfits {
  double call(List<Haircut> cortes) {
    return cortes.fold(0.0, (total, corte) => total + corte.type.price);
  }
}
