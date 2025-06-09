import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../services/appointments_services.dart';

class AppointmentsController extends ChangeNotifier {
  final AppointmentsService _service;
  List<AppointmentModel> appointments = [];
  bool isLoading = false;
  String? error;

  AppointmentsController(this._service);

  Future<void> loadAppointments() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      appointments = await _service.fetchAppointments();

      if (appointments.isEmpty) {
        error = 'Nenhum agendamento encontrado';
      }
    } catch (e) {
      print('Erro ao carregar agendamentos: $e');
      error = 'Erro ao carregar agendamentos';
    }
    isLoading = false;
    notifyListeners();
  }
}
