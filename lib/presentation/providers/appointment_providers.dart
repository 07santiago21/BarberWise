import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/appointment_remote_datasource.dart';
import '../../domain/entities/appointment_entity_.dart';
import '../../domain/entities/services_entity_.dart';

final appointmentDatasourceProvider = Provider((ref) => AppointmentRemoteDatasource());

final servicesProvider = FutureProvider<List<Service>>((ref) async {
  return ref.watch(appointmentDatasourceProvider).getServices();
});

final appointmentFormProvider = StateNotifierProvider<AppointmentFormNotifier, AsyncValue<void>>((ref) {
  return AppointmentFormNotifier(ref.watch(appointmentDatasourceProvider));
});

class AppointmentFormNotifier extends StateNotifier<AsyncValue<void>> {
  final AppointmentRemoteDatasource datasource;

  AppointmentFormNotifier(this.datasource) : super(const AsyncData(null));

  Future<void> submit(Appointment appointment) async {
    state = const AsyncLoading();
    try {
      await datasource.createAppointment(appointment);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

