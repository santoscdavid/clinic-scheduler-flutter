import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/endpoints.dart';

class BookAppointmentService {
  Future<bool> bookAppointment({
    required String appointmentId,
    required String userId,
  }) async {
    final url = Endpoints.bookAppointment + appointmentId;
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Erro ao agendar consulta: ${response.body}');
    }
  }
}
