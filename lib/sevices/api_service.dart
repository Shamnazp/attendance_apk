import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // BACKEND LAPTOP IP
  static const String baseUrl = "http://192.168.1.14:8000";

  // Login API Call
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("$baseUrl/api/login/");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      // Save token
      final token = data['access'] ?? "";
      await prefs.setString("token", token);

      // Save role and employee_id if provided
      await prefs.setString("role", data['user']?['role'] ?? "");
      await prefs.setString("employee_id", data['user']?['employee_id'] ?? "");

      return {"success": true, "data": data};
    } else {
      try {
        final body = jsonDecode(response.body);
        return {"success": false, "message": body['detail'] ?? "Login failed"};
      } catch (_) {
        return {"success": false, "message": "Login failed"};
      }
    }
  }

  //Forgot Password API
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse("$baseUrl/api/forgot-password/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {"success": true, "data": jsonDecode(response.body)};
    } else {
      try {
        final body = jsonDecode(response.body);
        return {
          "success": false,
          "message": body['detail'] ?? "Request failed",
        };
      } catch (_) {
        return {"success": false, "message": "Request failed"};
      }
    }
  }

  //Verify OTP API
  static Future<Map<String, dynamic>> verifyOtp(
    String email,
    String otp,
  ) async {
    final url = Uri.parse("$baseUrl/api/verify-otp/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "otp": otp}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {"success": true, "data": jsonDecode(response.body)};
    } else {
      try {
        final body = jsonDecode(response.body);
        return {
          "success": false,
          "message": body['detail'] ?? "OTP verification failed",
        };
      } catch (_) {
        return {"success": false, "message": "OTP verification failed"};
      }
    }
  }

  //Reset Password API
  static Future<Map<String, dynamic>> resetPassword(
    String email,
    String newPassword,
  ) async {
    final url = Uri.parse("$baseUrl/api/reset-password/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "new_password": newPassword}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {"success": true, "data": jsonDecode(response.body)};
    } else {
      try {
        final body = jsonDecode(response.body);
        return {
          "success": false,
          "message": body['error'] ?? body['detail'] ?? "Reset password failed",
        };
      } catch (_) {
        return {"success": false, "message": "Reset password failed"};
      }
    }
  }
}
