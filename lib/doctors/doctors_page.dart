import 'package:flutter/material.dart';
import '../specialties/models/specialty_model.dart';
import 'controller/doctors_controller.dart';
import 'services/doctors_service.dart';

class DoctorsPage extends StatefulWidget {
  final SpecialtyModel specialty;
  final String? userId;
  const DoctorsPage({Key? key, required this.specialty, this.userId})
    : super(key: key);

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  late final DoctorsController _controller;
  String? _selectedDoctorId;
  bool _listenerAdded = false;

  @override
  void initState() {
    super.initState();
    _controller = DoctorsController(DoctorsService());
    if (!_listenerAdded) {
      _controller.addListener(_onControllerUpdate);
      _listenerAdded = true;
    }
    _controller.loadDoctors(specialtyId: widget.specialty.id);
  }

  @override
  void dispose() {
    if (_listenerAdded) {
      _controller.removeListener(_onControllerUpdate);
    }
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecionar Doutor')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              _controller.isLoading
                  ? CircularProgressIndicator()
                  : _controller.error != null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _controller.error!,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed:
                            () => _controller.loadDoctors(
                              specialtyId: widget.specialty.id,
                            ),
                        child: Text('Tentar novamente'),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Especialidade: ${widget.specialty.name}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Doutor',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedDoctorId,
                        items:
                            _controller.doctors
                                .where(
                                  (doctor) =>
                                      doctor.specialty.id ==
                                      widget.specialty.id,
                                )
                                .map(
                                  (doctor) => DropdownMenuItem(
                                    value: doctor.id,
                                    child: Text(doctor.name),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDoctorId = value;
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed:
                            _selectedDoctorId == null
                                ? null
                                : () {
                                  final selectedDoctor = _controller.doctors
                                      .firstWhere(
                                        (d) => d.id == _selectedDoctorId,
                                      );
                                  Navigator.pushNamed(
                                    context,
                                    '/appointments',
                                    arguments: {
                                      'specialty': widget.specialty,
                                      'doctor': selectedDoctor,
                                      'userId': widget.userId,
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
