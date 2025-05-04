import '../entities/services.dart';

/// Suma los precios de todos los cortes
class CalculateProfits {
  double call(List<Service> haircuts) =>
      haircuts.fold(0.0, (sum, h) => sum + h.price);
}
