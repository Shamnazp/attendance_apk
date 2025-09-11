import 'package:dio/dio.dart';

class PunchInService {
  final Dio _dio;
  PunchInService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: 'http://192.168.1.14:8000'));

  /// Calls backend punch-in QR view.
  /// Replace the path '/attendance/punch-in-qr/' with your real endpoint.
  Future<Response> punchInWithQR({
    required String qrToken,
    required double latitude,
    required double longitude,
    String? bearerToken, 
  }) async {
    if (bearerToken != null && bearerToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    }
    final data = {
      'qr_token': qrToken,
      'latitude': latitude,
      'longitude': longitude,
    };
    return _dio.post('/api/attendance/punch-in/', data: data);
  }
}
