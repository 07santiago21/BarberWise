import '../entities/haircut.dart';

/// Caso de uso puro que recibe una función de repositorio
class GetHaircutsByRange {
  final Future<List<Haircut>> Function(DateTime from, DateTime to) repository;

  GetHaircutsByRange(this.repository);

  Future<List<Haircut>> call(DateTime from, DateTime to) {
    return repository(from, to);
  }
}
