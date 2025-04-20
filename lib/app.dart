// app.dart
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/dashboard/doctor_dashboard.dart';

class ObesmartApp extends StatelessWidget {
  const ObesmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ObéSmart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) =>  LoginScreen(),
        '/dashboard': (_) => const DoctorDashboard(),
      },
    );
  }
}