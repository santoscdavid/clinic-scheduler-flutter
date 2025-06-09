import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({Key? key}) : super(key: key);

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final Map<String, List<String>> _doctorsBySpecialty = {
    'Cardiologia': ['Dr. João Silva', 'Dra. Maria Cardoso'],
    'Pediatria': ['Dr. Pedro Souza', 'Dra. Ana Lima'],
    'Dermatologia': ['Dr. Lucas Rocha', 'Dra. Paula Mendes'],
    'Ortopedia': ['Dr. Carlos Pinto', 'Dra. Fernanda Alves'],
    'Ginecologia': ['Dra. Camila Torres', 'Dra. Juliana Dias'],
    'Neurologia': ['Dr. Rafael Costa', 'Dra. Beatriz Ramos'],
    'Oftalmologia': ['Dr. André Martins', 'Dra. Larissa Faria'],
    'Psiquiatria': ['Dr. Bruno Teixeira', 'Dra. Patrícia Gomes'],
  };

  String? _selectedDoctor;
  String? _specialty;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      setState(() {
        _specialty = args;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> doctors =
        (_specialty != null && _doctorsBySpecialty.containsKey(_specialty))
            ? _doctorsBySpecialty[_specialty!]!
            : <String>[];
    return Scaffold(
      appBar: AppBar(title: Text('Selecionar Doutor')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_specialty != null)
                Text(
                  'Especialidade: $_specialty',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Doutor',
                  border: OutlineInputBorder(),
                ),
                value: _selectedDoctor,
                items:
                    doctors
                        .map(
                          (doctor) => DropdownMenuItem(
                            value: doctor,
                            child: Text(doctor),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDoctor = value;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed:
                    _selectedDoctor == null
                        ? null
                        : () {
                          Navigator.pushNamed(
                            context,
                            '/appointments',
                            arguments: {
                              'specialty': _specialty,
                              'doctor': _selectedDoctor,
                            },
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
