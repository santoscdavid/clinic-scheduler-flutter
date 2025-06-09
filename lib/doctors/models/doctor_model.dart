import 'package:clinic_scheduler_app/specialties/models/specialty_model.dart';

class DoctorModel {
  final String id;
  final String name;
  final SpecialtyModel specialty;

  DoctorModel({required this.id, required this.name, required this.specialty});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      specialty: SpecialtyModel.fromJson(json['specialty']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'specialty': specialty.toJson()};
  }
}
