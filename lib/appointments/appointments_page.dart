import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  final String? specialty;
  final String? doctor;
  const AppointmentsPage({Key? key, this.specialty, this.doctor})
    : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  DateTime? _selectedDate;
  String? _specialty;
  String? _doctor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      setState(() {
        if (args['specialty'] is String) {
          _specialty = args['specialty'];
        }
        if (args['doctor'] is String) {
          _doctor = args['doctor'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agendar Consulta')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_specialty != null)
                Text(
                  'Especialidade: $_specialty',
                  style: TextStyle(fontSize: 16),
                ),
              if (_doctor != null)
                Text('Doutor: $_doctor', style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 60)),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Text(
                  _selectedDate == null
                      ? 'Selecionar Data'
                      : 'Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed:
                    (_selectedDate != null)
                        ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Consulta agendada para ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              ),
                            ),
                          );
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/historic',
                            );
                          });
                        }
                        : null,
                child: Text('Confirmar Agendamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
