import 'package:flutter/material.dart';
import '../../domain/entities/appointments.dart';
import '../../domain/usecases/get_appointments_by_date.dart';

class AppointmentsProvider with ChangeNotifier {
  final GetAppointmentsByDate _getAppointments = GetAppointmentsByDate();

  DateTime _selectedDate = DateTime.now();
  List<Appointments> _appointments = [];
  bool _isLoading = false;

  DateTime get selectedDate => _selectedDate;
  List<Appointments> get appointments => _appointments;
  bool get isLoading => _isLoading;

  AppointmentsProvider() {
    loadAppointments();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();

    _appointments = await _getAppointments(_selectedDate);

    _isLoading = false;
    notifyListeners();
  }
}
