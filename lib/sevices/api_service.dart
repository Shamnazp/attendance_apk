import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // BACKEND LAPTOP IP 
static const String baseUrl = "http://192.168.1.44:8000";
  /// Login API Call
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse("$baseUrl/api/login/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {"success": true, "data": jsonDecode(response.body)};
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
        return {"success": false, "message": body['detail'] ?? "Request failed"};
      } catch (_) {
        return {"success": false, "message": "Request failed"};
      }
    }
  }

  //Verify OTP API
  static Future<Map<String, dynamic>> verifyOtp(
      String email, String otp) async {
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
        return {"success": false, "message": body['detail'] ?? "OTP verification failed"};
      } catch (_) {
        return {"success": false, "message": "OTP verification failed"};
      }
    }
  }

    //Reset Password API
static Future<Map<String, dynamic>> resetPassword(
    String email, String newPassword) async {
  final url = Uri.parse("$baseUrl/api/reset-password/");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "new_password": newPassword,   
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return {"success": true, "data": jsonDecode(response.body)};
  } else {
    try {
      final body = jsonDecode(response.body);
      return {
        "success": false,
        "message": body['error'] ?? body['detail'] ?? "Reset password failed"
      };
    } catch (_) {
      return {"success": false, "message": "Reset password failed"};
    }
  }
}

  }


  


