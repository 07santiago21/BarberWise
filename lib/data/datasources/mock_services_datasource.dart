import '../../domain/entities/services.dart';

class MockServicesDatasource {
  final List<Service> services = [
    Service(
      name: 'Corte de pelo',
      price: 25000,
      duration: Duration(minutes: 30),
      date: DateTime(2025, 5, 6), // 6 de mayo 2025
    ),
    Service(
      name: 'Depilación de cejas',
      price: 15000,
      duration: Duration(minutes: 20),
      date: DateTime(2025, 5, 6), // 6 de mayo 2025
    ),
    Service(
      name: 'Coloración',
      price: 45000,
      duration: Duration(minutes: 60),
      date: DateTime(2025, 5, 8), // 8 de mayo 2025
    ),
    Service(
      name: 'Corte de barba',
      price: 18000,
      duration: Duration(minutes: 25),
      date: DateTime(2025, 5, 10), // 10 de mayo 2025
    ),
  ];

  Future<List<Service>> getServicesByRange(DateTime from, DateTime to) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return services;
  }
}
