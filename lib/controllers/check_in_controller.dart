import 'package:attendance_apk/qr_code_scanner.dart';
import 'package:attendance_apk/sevices/punch_in_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInController extends GetxController {
  final checkInTime = ''.obs;
  final checkOutTime = ''.obs;
  final checkInLocation = ''.obs;
  final punchInType = 'Onsite'.obs; 
  final isCheckedIn = false.obs;
  final checkInDate = ''.obs;

  final PunchInService _service = PunchInService();

  /// Ensure camera,location permissions
  Future<bool> _ensureCameraAndLocationPermissions() async {
    final camStatus = await Permission.camera.request();
    final locStatus = await Permission.locationWhenInUse.request();
    return camStatus.isGranted && locStatus.isGranted;
  }

  /// Get device position
  Future<Position> _getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission is permanently denied');
    }
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// Update punch type
  void updatePunchInType(String type) {
    punchInType.value = type;
  }

  /// Update check-in status
  void updateCheckInStatus(bool status, {String? punchInType}) {
    isCheckedIn.value = status;
    if (punchInType != null) this.punchInType.value = punchInType;
  }

  /// QR Scan wrapper
  Future<String?> scanQRCode() async {
    return await Get.to<String?>(() => const QRScannerScreen());
  }

  /// Punch In via QR
  Future<void> punchInViaQR(BuildContext context) async {
    if (!await _ensureCameraAndLocationPermissions()) {
      Get.snackbar('Permissions required', 'Camera and location permissions are required.');
      return;
    }

    final qrToken = await scanQRCode();
    if (qrToken == null || qrToken.isEmpty) return;

    final pos = await _getPosition();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final resp = await _service.punchInWithQR(
        qrCode: qrToken,
        latitude: pos.latitude,
        longitude: pos.longitude,
      );

      Navigator.pop(context);

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        final data = resp.data;
        if (data != null && data is Map && data['attendance'] != null) {
          final att = data['attendance'];
          checkInTime.value = att['in_time'] ?? DateFormat.jm().format(DateTime.now());
          checkInDate.value = att['date'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
          checkInLocation.value = att['location'] ?? "Office";
        } else {
          final now = DateTime.now();
          checkInTime.value = DateFormat.jm().format(now);
          checkInDate.value = DateFormat('yyyy-MM-dd').format(now);
          checkInLocation.value = "Office";
        }
        isCheckedIn.value = true;
        punchInType.value = 'Onsite';
        Get.snackbar('✅ Success', data['message'] ?? 'Punch In successful');
      } else {
        final message = resp.data?['message'] ?? 'Something went wrong';
        Get.snackbar('⚠️ Warning', message);
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      final serverMessage = e.response?.data['message'] ?? "Server error";
      Get.snackbar('❌ Error', serverMessage);
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar('❌ Error', e.toString());
    }
  }

  /// Punch Out via QR
  Future<void> punchOut(BuildContext context) async {
  if (!await _ensureCameraAndLocationPermissions()) {
    Get.snackbar('Permissions required', 'Camera and location permissions are required.');
    return;
  }

  final qrToken = await scanQRCode();
  if (qrToken == null || qrToken.isEmpty) return;

  final pos = await _getPosition();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    final resp = await _service.punchOutWithQR(
      qrCode: qrToken,
      latitude: pos.latitude,
      longitude: pos.longitude,
    );

    Navigator.pop(context);

    String message = 'Punch Out successful';

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      // Safely access resp.data
      if (resp.data != null && resp.data is Map<String, dynamic>) {
        final data = resp.data as Map<String, dynamic>;
        message = data['message'] ?? message;
      }

      checkOutTime.value = DateFormat.jm().format(DateTime.now());
      isCheckedIn.value = false;
      Get.snackbar('✅ Success', message);
    } else {
      // Handle failed response
      String errorMsg = 'Punch Out failed';
      if (resp.data != null && resp.data is Map<String, dynamic>) {
        errorMsg = resp.data['error'] ?? errorMsg;
      }
      Get.snackbar('⚠️ Warning', errorMsg);
    }
  } on DioException catch (e) {
    try { Navigator.pop(context); } catch (_) {}
    final serverMessage = e.response?.data is Map ? e.response?.data['message'] ?? 'Server error' : 'Server error';
    Get.snackbar('❌ Error', serverMessage);
  } catch (e) {
    try { Navigator.pop(context); } catch (_) {}
    Get.snackbar('❌ Error', e.toString());
  }
}
}