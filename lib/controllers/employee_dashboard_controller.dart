import 'package:attendance_apk/constants/app_colors.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';
import 'package:flutter/material.dart';
import '../views/face_verification_screen.dart';
import '../controllers/face_verification_controller.dart';

class EmployeeDashboardController extends GetxController {
  // Observable variables
  final RxInt selectedTabIndex = 0.obs;
  final RxString selectedSortOption = 'Deadline'.obs;
  
  // User information
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  
  // Task lists
  final RxList<Map<String, dynamic>> myTasks = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> taskTracker = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> ongoingTasks = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> workSummary = <Map<String, dynamic>>[].obs;

  // Attendance related
  final RxBool isCheckedIn = false.obs;
  final RxString checkInTime = ''.obs;
  final RxString checkInDate = ''.obs;
  final RxString checkInLocation = ''.obs;
  final RxBool showTasks = false.obs;
  final RxString punchInMethod = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
    // loadUserData();
  }

  // void loadUserData() {
  //   final AuthController authController = Get.find<AuthController>();
  //   currentUser.value = authController.getCurrentUser();
  // }

  void loadInitialData() {
    
    myTasks.value = [
      {
        "title": "UI/UX Design Implementation",
        "desc": "Translating design specs into interactive UI using HTML, CSS, JavaScript.",
        "dueDate": "18-06-2025",
        "status": "Not Started",
        "progress": 0,
        "priority": "Low",
        "assignedBy": null
      },
      {
        "title": "Responsive Design",
        "desc": "Ensure the application works on all screen sizes.",
        "dueDate": "20-06-2025",
        "status": "In Progress",
        "progress": 45,
        "priority": "Medium",
        "assignedBy": "John Doe"
      },
      {
        "title": "Back-end Development",
        "desc": "Creating APIs and databases for managing data.",
        "dueDate": "25-06-2025",
        "status": "Completed",
        "progress": 100,
        "priority": "High",
        "assignedBy": null
      },
      {
        "title": "Server-Side Logic",
        "desc": "Implement backend logic and data processing.",
        "dueDate": "01-07-2025",
        "status": "Overdue",
        "progress": 75,
        "priority": "Medium",
        "assignedBy": "Jane Smith"
      },
    ];

    
    taskTracker.value = [
      {
        "title": "UI/UX Design Implementation",
        "desc": "Ensure consistency across modules.",
        "dueDate": "10-07-2025",
        "status": "In Progress",
        "progress": 60,
        "priority": "Low",
        "assignedBy": "John Doe"
      },
      {
        "title": "Responsive Design",
        "desc": "Automate testing and build pipeline.",
        "dueDate": "05-07-2025",
        "status": "Not Started",
        "progress": 0,
        "priority": "High",
        "assignedBy": null
      },
      {
        "title": "UI/UX Design Implementation",
        "desc": "Ensure consistency across modules.",
        "dueDate": "10-07-2025",
        "status": "In Progress",
        "progress": 60,
        "priority": "Low",
        "assignedBy": "John Doe"
      },
      {
        "title": "UI/UX Design Implementation",
        "desc": "Ensure consistency across modules.",
        "dueDate": "10-07-2025",
        "status": "In Progress",
        "progress": 60,
        "priority": "Low",
        "assignedBy": "John Doe"
      }
    ];

    
    ongoingTasks.value = [
      {
        "title": "UI/UX Design Implementation",
        "desc": "Resolve token expiration issue.",
        "status": "Ongoing Task",
        "startDate": "12-05-2025",
        "expectedCompletion": "12-06-2025",
        "priority": "High",
        "progress": 80
      },
      {
        "title": "Responsive Design",
        "desc": "Implement analytics dashboard UI.",
        "status": "Pending Task",
        "assignedDate": "12-05-2025",
        "dueDate": "12-06-2025",
        "priority": "Medium",
        "progress": 45
      },
      {
        "title": "Bug Fix: Login Issue",
        "desc": "Resolve token expiration issue.",
        "status": "Ongoing Task",
        "startDate": "10-05-2025",
        "expectedCompletion": "10-06-2025",
        "priority": "High",
        "progress": 90
      },
      {
        "title": "Design Dashboard",
        "desc": "Implement analytics dashboard UI.",
        "status": "Pending Task",
        "assignedDate": "08-05-2025",
        "dueDate": "08-06-2025",
        "priority": "Low",
        "progress": 20
      },
      {
        "title": "Bug Fix: Login Issue",
        "desc": "Resolve token expiration issue.",
        "status": "Ongoing Task",
        "startDate": "10-05-2025",
        "expectedCompletion": "10-06-2025",
        "priority": "High",
        "progress": 90
      }
    ];

    
    workSummary.value = [
      {
        "title": "Client Meeting Notes",
        "desc": "Summarize discussion points and action items.",
        "dueDate": "30-07-2025",
        "status": "Completed",
        "progress": 100,
        "priority": "High",
        "assignedBy": null
      }
    ];

    // Set initial attendance status
    isCheckedIn.value = false;
    showTasks.value = false;
    checkInTime.value = "09:00 AM";
    checkInDate.value = "11-06-2025";
    checkInLocation.value = "Location/IP (for remote attendance)";
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void changeSortOption(String option) {
    selectedSortOption.value = option;
  }

  Future<bool> showFaceRecognitionDialog({bool isPunchOut = false, String? punchInType}) async {
    bool? result = await Get.to<bool>(
      () => FaceVerificationScreen(
        checkInTime: checkInTime.value,
        isPunchOut: isPunchOut,
        punchInType: punchInType,
      ),
      binding: BindingsBuilder(() {
        Get.put<FaceVerificationController>(FaceVerificationController());
      }),
    );
    return result ?? false;
  }

  Future<void> checkIn() async {
    // Show face recognition dialog
    final bool result = await showFaceRecognitionDialog();
    
    if (result) {
      updateCheckInStatus(true);
    }
  }

  void updateCheckInStatus(bool success, {String? punchInType}) {
    if (success) {
      isCheckedIn.value = true;
      showTasks.value = true;
      checkInTime.value = DateTime.now().toString().substring(11, 16);
      checkInDate.value = DateTime.now().toString().substring(0, 10);
      // Update punchInMethod when check-in is successful
      if (punchInType != null) {
        this.punchInMethod.value = punchInType;
      }
    } else {
      // Handle case where face recognition failed or was cancelled
      isCheckedIn.value = false;
      showTasks.value = false; // Ensure tasks are hidden if check-in fails
    }
  }

  Future<void> checkOut() async {
    // Show confirmation dialog
    bool? confirm = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Icon(Icons.warning_amber_rounded, size: 60, color: AppColors.orange), // Warning icon
            const SizedBox(height: 10),
            const Text(
              'Do you really want to checkout!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(result: false); // Just close dialog for now
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: AppColors.dashboardGrey300),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Update Task',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Punch Out',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    if (confirm != true) {
      return; // User cancelled
    }

    // Show face recognition dialog for punch out
    final bool result = await showFaceRecognitionDialog(isPunchOut: true, punchInType: punchInMethod.value);
    
    if (result) {
      // Update check-out status
      isCheckedIn.value = false;
      showTasks.value = false;
      checkInTime.value = DateTime.now().toString().substring(11, 16);
      // Add check-out time and other logic here
    }
  }

  List<Map<String, dynamic>> getCurrentTaskList() {
    switch (selectedTabIndex.value) {
      case 0:
        return myTasks;
      case 1:
        return taskTracker;
      case 2:
        return ongoingTasks;
      case 3:
        return workSummary;
      default:
        return myTasks; // Fallback
    }
  }
} 