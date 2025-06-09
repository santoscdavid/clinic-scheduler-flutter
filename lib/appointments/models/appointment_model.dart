import 'package:clinic_scheduler_app/doctors/models/doctor_model.dart';

class AppointmentModel {
  final String id;
  final String? patientId;
  final String doctorId;
  final DateTime date;
  final bool booked;
  final DoctorModel? doctor;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.booked,
    this.doctor,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'].toString(),
      patientId: json['patientId']?.toString(),
      doctorId: json['doctorId'].toString(),
      date: DateTime.parse(json['date']),
      booked: json['booked'],
      doctor:
          json['doctor'] != null ? DoctorModel.fromJson(json['doctor']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'booked': booked,
      if (doctor != null) 'doctor': doctor!.toJson(),
    };
  }
}
