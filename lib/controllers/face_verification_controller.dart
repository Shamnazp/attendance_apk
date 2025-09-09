import 'package:get/get.dart';

class FaceVerificationController extends GetxController {
  final RxInt currentStep = 0.obs; 

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<bool> takePhoto() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
} 