import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../services/doctors_service.dart';

class DoctorsController extends ChangeNotifier {
  final DoctorsService _service;
  List<DoctorModel> doctors = [];
  bool isLoading = false;
  String? error;

  DoctorsController(this._service);

  Future<void> loadDoctors({String? specialtyId}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      doctors = await _service.fetchDoctors(specialtyId: specialtyId);
    } catch (e) {
      error = 'Erro ao carregar médicos';
    }
    isLoading = false;
    notifyListeners();
  }
}
