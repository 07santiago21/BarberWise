import '../../domain/entities/services.dart';

/// Mock “quemado” de servicios: 4 tipos × 8 días = 32 items
class MockServicesDatasource {
  // Lista fija de servicios
  final List<Service> _services = [
    for (int dayOffset = 0; dayOffset < 8; dayOffset++) ...[
      Service(
        name: 'Corte de pelo',
        price: 25000 + dayOffset * 500,
        duration: Duration(minutes: 30),
        date: DateTime.now().subtract(Duration(days: dayOffset)),
      ),
      Service(
        name: 'Depilación de cejas',
        price: 15000 + dayOffset * 300,
        duration: Duration(minutes: 20),
        date: DateTime.now().subtract(Duration(days: dayOffset)),
      ),
      Service(
        name: 'Coloración',
        price: 45000 + dayOffset * 1000,
        duration: Duration(minutes: 60 + dayOffset * 5),
        date: DateTime.now().subtract(Duration(days: dayOffset)),
      ),
      Service(
        name: 'Corte de barba',
        price: 18000 + dayOffset * 400,
        duration: Duration(minutes: 25 + dayOffset),
        date: DateTime.now().subtract(Duration(days: dayOffset)),
      ),
    ],
  ];

  /// Devuelve los servicios entre [from] y [to] (inclusive)
  Future<List<Service>> getServicesByRange(DateTime from, DateTime to) async {
    // Simular un pequeño delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _services
        .where((s) => !s.date.isBefore(from) && !s.date.isAfter(to))
        .toList();
  }
}
