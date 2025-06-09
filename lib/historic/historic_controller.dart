import 'package:clinic_scheduler_app/appointments/models/appointment_model.dart';
import 'package:clinic_scheduler_app/appointments/services/appointments_services.dart';

class HistoricController {
  final AppointmentsService _service = AppointmentsService();

  Future<List<AppointmentModel>> getUserAppointments(String userId) async {
    final all = await _service.fetchAppointments();

    var test = all.where((a) => a.patientId == userId).toList();
    return test;
  }
}
