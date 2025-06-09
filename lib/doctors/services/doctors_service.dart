import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/endpoints.dart';
import '../models/doctor_model.dart';

class DoctorsService {
  Future<List<DoctorModel>> fetchDoctors({String? specialtyId}) async {
    final uri =
        specialtyId != null
            ? Uri.parse('${Endpoints.fetchDoctors}?specialtyId=$specialtyId')
            : Uri.parse(Endpoints.fetchDoctors);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => DoctorModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar médicos');
    }
  }
}
