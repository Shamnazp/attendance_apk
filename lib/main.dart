import 'package:attendance_apk/views/EmployeeDashboardScreen.dart';
import 'package:attendance_apk/controllers/employee_dashboard_controller.dart';
import 'package:attendance_apk/controllers/check_in_controller.dart';
import 'package:attendance_apk/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      title: 'Employee Attendance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,

      initialBinding: BindingsBuilder(() {
        Get.put(CheckInController());
        Get.put(EmployeeDashboardController());
      }),

      home: const LoginView(),
    );
  }
}
