import 'package:flutter/material.dart';
import '../models/specialty_model.dart';
import '../services/specialties_service.dart';

class SpecialtiesController extends ChangeNotifier {
  final SpecialtiesService _service;
  List<SpecialtyModel> specialties = [];
  bool isLoading = false;
  String? error;

  SpecialtiesController(this._service);

  Future<void> loadSpecialties() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      specialties = await _service.fetchSpecialties();
    } catch (e) {
      error = 'Erro ao carregar especialidades';
    }
    isLoading = false;
    notifyListeners();
  }
}
