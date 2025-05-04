import '../entities/services.dart';

/// Caso de uso puro que recibe una función de repositorio
class GetServiceByRange {
  final Future<List<Service>> Function(DateTime from, DateTime to) repository;

  GetServiceByRange(this.repository);

  Future<List<Service>> call(DateTime from, DateTime to) {
    return repository(from, to);
  }
}
