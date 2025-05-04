import '../entities/services.dart';

/// Cuenta cuántos cortes hay en la lista
class CountServices {
  int call(List<Service> haircuts) => haircuts.length;
}
