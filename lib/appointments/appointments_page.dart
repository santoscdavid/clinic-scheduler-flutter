import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'controller/appointments_controller.dart';
import 'services/appointments_services.dart';
import 'models/appointment_model.dart';
import 'package:clinic_scheduler_app/doctors/models/doctor_model.dart';
import 'package:clinic_scheduler_app/specialties/models/specialty_model.dart';

class AppointmentsPage extends StatelessWidget {
  final SpecialtyModel? specialty;
  final DoctorModel? doctor;
  final String? userId;
  const AppointmentsPage({Key? key, this.specialty, this.doctor, this.userId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) =>
              AppointmentsController(AppointmentsService())..loadAppointments(),
      child: Builder(
        builder:
            (context) => _AppointmentsPageBody(
              specialty: specialty,
              doctor: doctor,
              userId: userId,
            ),
      ),
    );
  }
}

class _AppointmentsPageBody extends StatefulWidget {
  final SpecialtyModel? specialty;
  final DoctorModel? doctor;
  final String? userId;
  const _AppointmentsPageBody({
    Key? key,
    this.specialty,
    this.doctor,
    this.userId,
  }) : super(key: key);

  @override
  State<_AppointmentsPageBody> createState() => _AppointmentsPageBodyState();
}

class _AppointmentsPageBodyState extends State<_AppointmentsPageBody> {
  AppointmentModel? _selectedAppointment;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Garante que userId está presente, senão mostra erro
    if (widget.userId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Erro'),
                content: Text(
                  'Usuário não identificado. Faça login novamente.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AppointmentsController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Agendar Consulta')),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/img_specialties.png', height: 200),
                  if (widget.specialty != null)
                    Text(
                      'Especialidade: ${widget.specialty!.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                  if (widget.doctor != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Doutor: ${widget.doctor!.name}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: 24),
                  if (controller.isLoading) CircularProgressIndicator(),
                  if (controller.error != null)
                    Text(
                      controller.error!,
                      style: TextStyle(color: Colors.red),
                    ),
                  if (!controller.isLoading && controller.error == null)
                    Builder(
                      builder: (context) {
                        final filteredAppointments =
                            controller.appointments
                                .where(
                                  (a) =>
                                      !a.booked &&
                                      (widget.doctor == null ||
                                          a.doctorId == widget.doctor!.id),
                                )
                                .toList();
                        if (filteredAppointments.isEmpty) {
                          return const Text(
                            'Não há horários disponíveis.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          );
                        }
                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                filteredAppointments
                                    .map(
                                      (
                                        appointment,
                                      ) => RadioListTile<AppointmentModel>(
                                        title: Text(
                                          'Data: '
                                          '${DateFormat('dd/MM/yy').format(appointment.date)}  '
                                          'Hora: ${DateFormat('HH:mm').format(appointment.date)}',
                                        ),
                                        value: appointment,
                                        groupValue: _selectedAppointment,
                                        onChanged: (AppointmentModel? value) {
                                          setState(() {
                                            _selectedAppointment = value;
                                          });
                                        },
                                      ),
                                    )
                                    .toList(),
                          ),
                        );
                      },
                    ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              minimum: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              child: ElevatedButton(
                onPressed:
                    _selectedAppointment != null
                        ? () async {
                          if (widget.userId == null) return;
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (context) =>
                                    Center(child: CircularProgressIndicator()),
                          );
                          final success = await controller.bookAppointment(
                            appointmentId: _selectedAppointment!.id,
                            userId: widget.userId!,
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Consulta agendada para '
                                  '${DateFormat('dd/MM/yy').format(_selectedAppointment!.date)}  '
                                  'Hora: ${DateFormat('HH:mm').format(_selectedAppointment!.date)}',
                                ),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/historic',
                                arguments: {'userId': widget.userId},
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao agendar consulta'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Confirmar Agendamento'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
