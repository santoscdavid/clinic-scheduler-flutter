import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../services/appointments_services.dart';
import '../services/book_appointment_services.dart';

class AppointmentsController extends ChangeNotifier {
  final AppointmentsService _service;
  final BookAppointmentService _bookService = BookAppointmentService();
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

  Future<bool> bookAppointment({
    required String appointmentId,
    required String userId,
  }) async {
    print(
      '[Controller] bookAppointment chamado com appointmentId: '
      '$appointmentId[0m, userId: [32m$userId[0m',
    );
    try {
      if (appointmentId.isEmpty || userId.isEmpty) {
        print('[Controller] ID de agendamento ou usuário vazio');
        error = 'ID de agendamento ou usuário vazio';
        notifyListeners();
        return false;
      }

      final result = await _bookService.bookAppointment(
        appointmentId: appointmentId,
        userId: userId,
      );
      print('[Controller] Resultado do agendamento: $result');
      return result;
    } catch (e) {
      print('[Controller] Erro ao agendar: $e');
      error = 'Erro ao agendar consulta';
      notifyListeners();
      return false;
    }
  }
}
