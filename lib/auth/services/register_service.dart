import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/register_model.dart';
import '../../config/endpoints.dart';

class RegisterService {
  Future<Map<String, dynamic>> register(RegisterModel registerModel) async {
    final url = Uri.parse(Endpoints.createUser);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': registerModel.email,
        'passwordHash': registerModel.passwordHash,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        return errorBody is Map<String, dynamic>
            ? errorBody
            : {
              'message': 'Falha no cadastro',
              'statusCode': response.statusCode,
            };
      } catch (_) {
        return {
          'message': 'Falha no cadastro',
          'statusCode': response.statusCode,
        };
      }
    }
  }
}
