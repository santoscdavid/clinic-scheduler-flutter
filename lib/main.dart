import 'package:flutter/material.dart';

import '../appointments/appointments_page.dart';
import '../doctors/doctors_page.dart';
import '../historic/historic_page.dart';
import '../home_page.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'doctors/models/doctor_model.dart';
import 'specialties/models/specialty_model.dart';
import 'specialties/specialties_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Scheduler App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.light,
          primary: Colors.lightBlue,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.lightBlue,
          surface: Colors.white,
          onSurface: Colors.black, // textos em preto
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          displayLarge: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Colors.black),
          displaySmall: TextStyle(color: Colors.black),
          headlineLarge: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.black),
          headlineSmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
          labelLarge: TextStyle(color: Colors.black),
          labelMedium: TextStyle(color: Colors.black),
          labelSmall: TextStyle(color: Colors.black),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/specialties': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          String? userId;
          if (args is Map && args['userId'] != null) {
            userId = args['userId'] as String;
          }
          return SpecialtiesPage(userId: userId);
        },
        '/doctors': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map && args['specialty'] != null) {
            return DoctorsPage(
              specialty: args['specialty'],
              userId: args['userId'],
            );
          }
          // fallback: pode mostrar erro ou retornar uma tela vazia
          return Scaffold(
            appBar: AppBar(title: Text('Erro')),
            body: Center(child: Text('Especialidade não informada!')),
          );
        },
        '/appointments': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          String? userId;
          SpecialtyModel? specialty;
          DoctorModel? doctor;
          if (args is Map) {
            userId = args['userId'] as String?;
            specialty = args['specialty'] as SpecialtyModel?;
            doctor = args['doctor'] as DoctorModel?;
          }
          return AppointmentsPage(
            specialty: specialty,
            doctor: doctor,
            userId: userId,
          );
        },
        '/historic': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          String? userId;
          if (args is Map && args['userId'] != null) {
            userId = args['userId'] as String;
          }
          return HistoricPage(userId: userId);
        },
      },
    );
  }
}
