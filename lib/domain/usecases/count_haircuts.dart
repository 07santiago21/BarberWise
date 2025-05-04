import '../entities/haircut.dart';

/// Cuenta cuántos cortes hay en la lista
class CountHaircuts {
  int call(List<Haircut> haircuts) => haircuts.length;
}
