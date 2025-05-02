import '../../domain/entities/haircut.dart';
import '../../domain/entities/haircut_type.dart';

final List<Haircut> haircutsMock = [
  Haircut(
    client: 'Carlos López',
    cellphone: '3001112233',
    date: DateTime(2025, 4, 1, 14, 0),
    type: HaircutType(
        name: 'Fade', price: 15000, duration: Duration(minutes: 30)),
  ),
  Haircut(
    client: 'Juan Pérez',
    cellphone: '3004445566',
    date: DateTime(2025, 4, 2, 15, 30),
    type: HaircutType(
        name: 'Clásico', price: 12000, duration: Duration(minutes: 25)),
  ),
  Haircut(
    client: 'Ana Torres',
    cellphone: '3107891234',
    date: DateTime(2025, 4, 3, 10, 45),
    type: HaircutType(
        name: 'Moderno', price: 18000, duration: Duration(minutes: 40)),
  ),
];
