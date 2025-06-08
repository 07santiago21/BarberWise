
import 'package:barber/domain/entities/appointment_entity_.dart';

class AppointmentsState {
  final DateTime selectedDate;
  final List<Appointment> appointments;
  final bool isLoading;

  const AppointmentsState({
    required this.selectedDate,
    required this.appointments,
    required this.isLoading,
  });

  AppointmentsState copyWith({
    DateTime? selectedDate,
    List<Appointment>? appointments,
    bool? isLoading,
  }) {
    return AppointmentsState(
      selectedDate: selectedDate ?? this.selectedDate,
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory AppointmentsState.initial() => AppointmentsState(
        selectedDate: DateTime.now(),
        appointments: [],
        isLoading: false,
      );
}
