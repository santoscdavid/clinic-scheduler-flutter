class Endpoints {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // Usuários
  static const String fetchUsers = '$baseUrl/users';
  static const String fetchUserById = '$baseUrl/users/'; // append :id
  static const String createUser = '$baseUrl/users';
  static const String updateUser = '$baseUrl/users/'; // append :id
  static const String deleteUser = '$baseUrl/users/'; // append :id

  // Autenticação
  static const String authLogin = '$baseUrl/auth/login';

  // Médicos
  static const String fetchDoctors = '$baseUrl/doctors';
  static const String fetchDoctorSpecialties = '$baseUrl/doctors/specialties';
  static const String createDoctor = '$baseUrl/doctors';
  static const String createDoctorSpecialty = '$baseUrl/doctors/specialties';

  // Agendamentos
  static const String fetchAppointments = '$baseUrl/appointments';
  static const String createAvailableAppointment =
      '$baseUrl/appointments/available';
  static const String bookAppointment =
      '$baseUrl/appointments/book/'; // append :id
}
