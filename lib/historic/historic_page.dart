import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../appointments/models/appointment_model.dart';
import 'historic_controller.dart';

class HistoricPage extends StatefulWidget {
  final String? userId;
  const HistoricPage({Key? key, this.userId}) : super(key: key);

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  late Future<List<AppointmentModel>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = HistoricController().getUserAppointments(
      widget.userId ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => Navigator.of(context).pushReplacementNamed(
                '/home',
                arguments: {'userId': widget.userId},
              ),
        ),
        title: const Text('Histórico de Consultas'),
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar histórico.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhum histórico disponível.',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            );
          }
          final appointments = snapshot.data!;
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return ListTile(
                leading: const Icon(Icons.event_available),
                title: Text(
                  'Consulta com médico: '
                  '${appt.doctor != null ? appt.doctor!.name : appt.doctorId}',
                ),
                subtitle: Text(
                  'Data: '
                  '${DateFormat('dd/MM/yy').format(appt.date)}  '
                  'Hora: ${DateFormat('HH:mm').format(appt.date)}',
                ),
                trailing:
                    appt.booked
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
              );
            },
          );
        },
      ),
    );
  }
}
