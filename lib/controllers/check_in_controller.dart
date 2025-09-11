import 'package:attendance_apk/qr_code_scanner.dart';
import 'package:attendance_apk/sevices/punch_in_service.dart';
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

  Future<bool> _ensureCameraAndLocationPermissions() async {
    final camStatus = await Permission.camera.request();
    final locStatus = await Permission.locationWhenInUse.request();
    if (!camStatus.isGranted) return false;
    if (!locStatus.isGranted) return false;
    return true;
  }

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

  /// Update status
  void updateCheckInStatus(bool status, {String? punchInType}) {
    isCheckedIn.value = status;
    if (punchInType != null) {
      this.punchInType.value = punchInType;
    }
  }

  /// QR Scan wrapper
  Future<String?> scanQRCode() async {
    return await Get.to<String?>(() => const QRScannerScreen());
  }

  /// Work From Home Punch In
  Future<bool> punchInWorkFromHome() async {
    try {
      final now = DateTime.now();
      checkInTime.value = DateFormat.jm().format(now);
      checkInDate.value = DateFormat('yyyy-MM-dd').format(now);
      checkInLocation.value = "Home";
      isCheckedIn.value = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Punch In via QR
  Future<void> punchInViaQR(BuildContext context, {String? bearerToken}) async {
    try {
      final ok = await _ensureCameraAndLocationPermissions();
      if (!ok) {
        Get.snackbar('Permissions required', 'Camera and location permissions are required.');
        return;
      }

      final qrToken = await Navigator.push<String?>(
        context,
        MaterialPageRoute(builder: (_) => const QRScannerScreen()),
      );
      if (qrToken == null || qrToken.isEmpty) {
        return;
      }

      final pos = await _getPosition();

      final dialog = const Center(child: CircularProgressIndicator());
      showDialog(context: context, barrierDismissible: false, builder: (_) => dialog);

      final resp = await _service.punchInWithQR(
        qrToken: qrToken,
        latitude: pos.latitude,
        longitude: pos.longitude,
        bearerToken: bearerToken,
      );

      Navigator.pop(context); // dismiss loading

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        final data = resp.data;
        if (data != null && data is Map && data['attendance'] != null) {
          final att = data['attendance'];
          checkInTime.value = att['in_time'] ?? DateFormat.jm().format(DateTime.now());
          checkInDate.value = att['date'] ?? DateFormat.yMd().format(DateTime.now());
          checkInLocation.value = att['location'] ?? checkInLocation.value;
        } else {
          final now = DateTime.now();
          checkInTime.value = DateFormat.jm().format(now);
          checkInDate.value = DateFormat('yyyy-MM-dd').format(now);
        }
        isCheckedIn.value = true;
        Get.snackbar('Success', data['message'] ?? 'Punch In successful');
      } else {
        final err = resp.data?['error'] ?? 'Something went wrong';
        Get.snackbar('Error', err);
      }
    } catch (e) {
      try { Navigator.pop(context); } catch (_) {}
      Get.snackbar('Error', e.toString());
    }
  }

  /// Punch Out via QR
  Future<void> punchOutViaQR(BuildContext context, {String? bearerToken}) async {
    try {
      final ok = await _ensureCameraAndLocationPermissions();
      if (!ok) {
        Get.snackbar('Permissions required', 'Camera and location permissions are required.');
        return;
      }

      final qrToken = await Navigator.push<String?>(
        context,
        MaterialPageRoute(builder: (_) => const QRScannerScreen()),
      );
      if (qrToken == null || qrToken.isEmpty) return;

      final pos = await _getPosition();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()));

      final resp = await _service.punchInWithQR(
        qrToken: qrToken,
        latitude: pos.latitude,
        longitude: pos.longitude,
        bearerToken: bearerToken,
      );

      Navigator.pop(context); // dismiss loading

      if (resp.statusCode == 200) {
        final data = resp.data;
        checkOutTime.value = DateFormat.jm().format(DateTime.now());
        isCheckedIn.value = false;
        Get.snackbar('Success', data['message'] ?? 'Punch Out successful');
      } else {
        Get.snackbar('Error', resp.data?['error'] ?? 'Punch out failed');
      }
    } catch (e) {
      try { Navigator.pop(context); } catch (_) {}
      Get.snackbar('Error', e.toString());
    }
  }
    /// Update check-in time manually
  void updateCheckInTime(String time) {
    checkInTime.value = time;
  }

  /// Update check-out time manually
  void updateCheckOutTime(String time) {
    checkOutTime.value = time;
  }
}
