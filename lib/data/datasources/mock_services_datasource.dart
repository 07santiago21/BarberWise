import '../../domain/entities/services.dart';

class MockServicesDatasource {
  final List<Service> services = [
    Service(
      name: 'Corte de pelo',
      price: 25000,
      duration: Duration(minutes: 30),
    ),
    Service(
      name: 'Depilación de cejas',
      price: 15000,
      duration: Duration(minutes: 20),
    ),
    Service(
      name: 'Coloración',
      price: 45000,
      duration: Duration(minutes: 60),
    ),
    Service(
      name: 'Corte de barba',
      price: 18000,
      duration: Duration(minutes: 25),
    ),
  ];

  Future<List<Service>> getServicesByRange(DateTime from, DateTime to) async {
    return services;
  }
}
