import 'package:get/get.dart';

class CheckInController extends GetxController {
  final checkInTime = '09:00 AM'.obs;
  final checkOutTime = RxString('');
  final checkInLocation = 'Office Location'.obs;
  final punchInType = 'Onsite'.obs;

  void updateCheckInTime(String time) {
    checkInTime.value = time;
  }

  void updateCheckOutTime(String time) {
    checkOutTime.value = time;
  }

  void updateCheckInLocation(String location) {
    checkInLocation.value = location;
  }

  void updatePunchInType(String type) {
    punchInType.value = type;
  }
} 