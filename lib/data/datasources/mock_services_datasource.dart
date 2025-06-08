import '../../domain/entities/services.dart';

class MockServicesDatasource {
  final List<Service> services = [
    Service(
      id: 1,
      name: 'Corte de pelo',
      price: 25000,
      duration: Duration(minutes: 30),
    ),
    Service(
      id: 2,
      name: 'Depilación de cejas',
      price: 15000,
      duration: Duration(minutes: 20),
    ),
    Service(
      id: 3,
      name: 'Coloración',
      price: 45000,
      duration: Duration(minutes: 60),
    ),
    Service(
      id: 4,
      name: 'Corte de barba',
      price: 18000,
      duration: Duration(minutes: 25),
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
