import 'package:flutter/material.dart';
import '../models/login_model.dart';
import '../services/login_service.dart';
import '../models/register_model.dart';
import '../services/register_service.dart';

class AuthController {
  final LoginService _loginService = LoginService();
  final RegisterService _registerService = RegisterService();

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    final loginModel = LoginModel(email: email, password: password);

    final result = await _loginService.login(loginModel);
    if (result.containsKey('user')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Erro ao fazer login.')),
      );
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    BuildContext context,
  ) async {
    if (password.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail e senha são obrigatórios.')),
      );
      return {};
    }

    final registerModel = RegisterModel(email: email, passwordHash: password);

    final result = await _registerService.register(registerModel);
    if (result.containsKey('id') || result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Erro ao cadastrar.')),
      );
    }
    return result;
  }
}
