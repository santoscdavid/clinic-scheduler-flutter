import 'package:flutter/material.dart';
import 'services/specialties_service.dart';
import 'controller/specialties_controller.dart';

class SpecialtiesPage extends StatefulWidget {
  @override
  _SpecialtiesPageState createState() => _SpecialtiesPageState();
}

class _SpecialtiesPageState extends State<SpecialtiesPage> {
  late final SpecialtiesController _controller;
  String? _selectedSpecialtyId;

  @override
  void initState() {
    super.initState();
    _controller = SpecialtiesController(SpecialtiesService());
    _controller.addListener(_onControllerUpdate);
    _controller.loadSpecialties();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecionar Especialidade')),
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
                        onPressed: _controller.loadSpecialties,
                        child: Text('Tentar novamente'),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Especialidade',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedSpecialtyId,
                        items:
                            _controller.specialties
                                .map(
                                  (specialty) => DropdownMenuItem(
                                    value: specialty.id,
                                    child: Text(specialty.name),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSpecialtyId = value;
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed:
                            _selectedSpecialtyId == null
                                ? null
                                : () async {
                                  final selected = _controller.specialties
                                      .firstWhere(
                                        (s) => s.id == _selectedSpecialtyId,
                                      );
                                  Navigator.pushNamed(
                                    context,
                                    '/doctors',
                                    arguments: selected,
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
