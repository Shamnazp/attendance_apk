import 'package:attendance_apk/constants/app_colors.dart';
import 'package:attendance_apk/controllers/face_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FaceVerificationScreen extends GetView<FaceVerificationController> {
  final String? checkInTime;
  final bool isPunchOut;
  final String? punchInType;

  FaceVerificationScreen({
    super.key,
    this.checkInTime,
    this.isPunchOut = false,
    this.punchInType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(() {
          switch (controller.currentStep.value) {
            case 0:
              if (punchInType == 'On Site') {
                return _buildQRVerificationScreen(context);
              } else {
                return _buildFirstScreen(context);
              }
            case 1:
              return _buildSecondScreen(context);
            case 2:
              return _buildSuccessScreen(context);
            default:
              if (punchInType == 'On Site') {
                return _buildQRVerificationScreen(context);
              } else {
                return _buildFirstScreen(context); // Fallback
              }
          }
        }),
      ),
    );
  }

  Widget _buildFirstScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Face Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Please capture your face',
              style: TextStyle(fontSize: 16, color: AppColors.textLight),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dashboardGrey600.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Lottie.asset(
                'assets/animations/Animation - 1750145128601.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: ElevatedButton(
            onPressed: () => controller.nextStep(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
            ),
            child: const Text(
              'Take Photo',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 158),
      ],
    );
  }

  Widget _buildQRVerificationScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'QR Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Please scan the QR code',
              style: TextStyle(fontSize: 16, color: AppColors.textLight),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dashboardGrey600.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Lottie.asset(
                'assets/animations/Animation - 1750150314770.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: ElevatedButton(
            onPressed: () => controller.nextStep(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
            ),
            child: const Text(
              'Scan QR',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 158),
      ],
    );
  }

  Widget _buildSecondScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.white, AppColors.transparentBlue10],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // shrink wrap content
                children: [
                  Text(
                    isPunchOut
                        ? 'Verify your face for punch out'
                        : 'Center your face',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isPunchOut
                        ? 'Point your face right at the box to verify punch out'
                        : 'Point your face right at the box,\nthen take a photo',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Bottom action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _circleButton(Icons.camera_alt),
              InkWell(
                onTap: () => controller.nextStep(),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 60, color: AppColors.white),
                ),
              ),
              _circleButton(Icons.flash_on),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _circleButton(IconData icon) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: AppColors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppColors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Icon(icon, size: 28, color: AppColors.black),
  );
}

  Widget _buildSuccessScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.back(result: true);
    });

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              isPunchOut
                  ? [
                    AppColors.punchOutGradient1,
                    AppColors.punchOutGradient2,
                    AppColors.punchOutGradient3,
                  ]
                  : [
                    AppColors.punchInGradient1,
                    AppColors.punchInGradient2,
                    AppColors.punchInGradient3,
                  ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: isPunchOut ? AppColors.punchOutGradient3 : AppColors.success,
            ),
            const SizedBox(height: 20),
            Text(
              isPunchOut
                  ? 'Punch Out successfully at ${checkInTime ?? ''}'
                  : 'Punch In successfully at ${checkInTime ?? ''}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
