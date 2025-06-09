import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/endpoints.dart';
import '../models/appointment_model.dart';

class AppointmentsService {
  Future<List<AppointmentModel>> fetchAppointments() async {
    final response = await http.get(Uri.parse(Endpoints.fetchAppointments));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => AppointmentModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar agendamentos');
    }
  }
}
