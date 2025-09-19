// punch_in_service.dart (updated)
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PunchInService {
  final Dio _dio;

  PunchInService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'http://192.168.1.14:8000', 
              headers: {'Content-Type': 'application/json'},
            )) {
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<void> _setAuthHeader() async {
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<Response> punchInWithQR({
    required String qrCode,
    required double latitude,
    required double longitude,
  }) async {
    await _setAuthHeader();
    final data = {'qr_code': qrCode, 'latitude': latitude, 'longitude': longitude};
    try {
      return await _dio.post('/api/punch-in/', data: data);
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: '/api/punch-in/'),
            statusCode: 500,
            data: {'message': 'Something went wrong'},
          );
    }
  }

  Future<Response> punchOutWithQR({
    required String qrCode,
    required double latitude,
    required double longitude,
    int? attendanceId, // optional - include if server requires
  }) async {
    await _setAuthHeader();

    final data = {
      'qr_code': qrCode,
      'latitude': latitude,
      'longitude': longitude,
      if (attendanceId != null) 'attendance_id': attendanceId,
    };

    try {
      // use the correct path exactly as backend expects
      return await _dio.post('/api/punch-out/', data: data);
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: '/api/punch-out/'),
            statusCode: 500,
            data: {'message': 'Something went wrong'},
          );
    }
  }
}
