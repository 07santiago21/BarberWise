import 'package:barber/domain/entities/services_entity_.dart';


class MockServicesDatasource {
  final List<Service> services = [
    Service(
      id: "aaa",
      name: 'Corte de pelo',
      price: 25000,
      duration: 30,
    ),
    Service(
      id: "bbb",
      name: 'Depilación de cejas',
      price: 15000,
      duration: 20,
    ),
    Service(
      id: "ccc",
      name: 'Coloración',
      price: 45000,
      duration: 60,
    ),
    Service(
      id: "ddd",
      name: 'Corte de barba',
      price: 18000,
      duration: 25,
    ),
  ];

  /// Devuelve todos los servicios (ignora el rango por ahora)
  Future<List<Service>> getServicesByRange(DateTime from, DateTime to) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simula latencia
    return services;
  }

  /// También puedes agregar un método general:
  Future<List<Service>> getAllServices() async {
    return getServicesByRange(DateTime.now(), DateTime.now());
  }
}
