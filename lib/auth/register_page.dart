// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import '../auth/controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  final AuthController _authController = AuthController();
  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      final result = await _authController.register(_email, _password, context);
      setState(() => _isLoading = false);
      if (result.containsKey('id') || result['success'] == true) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Digite o e-mail' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Digite a senha' : null,
                onSaved: (value) => _password = value!,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirme a senha',
                ),
                obscureText: true,
                validator:
                    (value) =>
                        value != _passwordController.text
                            ? 'As senhas não coincidem'
                            : null,
                onSaved: (value) => _confirmPassword = value!,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _register,
                    child: const Text('Cadastrar'),
                  ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Já tem uma conta? Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
