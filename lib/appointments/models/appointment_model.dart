class AppointmentModel {
  final String id;
  final String? patientId;
  final String doctorId;
  final DateTime date;
  final bool booked;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.booked,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      date: DateTime.parse(json['date']),
      booked: json['booked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'booked': booked,
    };
  }
}
