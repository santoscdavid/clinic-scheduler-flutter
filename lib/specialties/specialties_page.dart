import 'package:flutter/material.dart';

class SpecialtiesPage extends StatefulWidget {
  @override
  _SpecialtiesPageState createState() => _SpecialtiesPageState();
}

class _SpecialtiesPageState extends State<SpecialtiesPage> {
  final List<String> _specialties = [
    'Cardiologia',
    'Pediatria',
    'Dermatologia',
    'Ortopedia',
    'Ginecologia',
    'Neurologia',
    'Oftalmologia',
    'Psiquiatria',
  ];

  String? _selectedSpecialty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecionar Especialidade')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Especialidade',
                  border: OutlineInputBorder(),
                ),
                value: _selectedSpecialty,
                items:
                    _specialties
                        .map(
                          (specialty) => DropdownMenuItem(
                            value: specialty,
                            child: Text(specialty),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSpecialty = value;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed:
                    _selectedSpecialty == null
                        ? null
                        : () {
                          Navigator.pushNamed(
                            context,
                            '/doctors',
                            arguments: _selectedSpecialty,
                          );
                        },
                child: Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
