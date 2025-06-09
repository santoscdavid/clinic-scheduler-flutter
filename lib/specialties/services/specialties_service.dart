import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/endpoints.dart';
import '../models/specialty_model.dart';

class SpecialtiesService {
  Future<List<SpecialtyModel>> fetchSpecialties() async {
    final response = await http.get(
      Uri.parse(Endpoints.fetchDoctorSpecialties),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data
          .map((e) => SpecialtyModel(id: e['id'].toString(), name: e['name']))
          .toList();
    } else {
      throw Exception('Erro ao buscar especialidades');
    }
  }
}
