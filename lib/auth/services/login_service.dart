import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/login_model.dart';
import '../../config/endpoints.dart';

class LoginService {
  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    final url = Uri.parse(Endpoints.authLogin);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': loginModel.email,
        'password': loginModel.password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Tenta decodificar o corpo para extrair mensagem de erro detalhada
      try {
        final errorBody = jsonDecode(response.body);
        return errorBody is Map<String, dynamic>
            ? errorBody
            : {'message': 'Falha no login', 'statusCode': response.statusCode};
      } catch (_) {
        return {'message': 'Falha no login', 'statusCode': response.statusCode};
      }
    }
  }
}
