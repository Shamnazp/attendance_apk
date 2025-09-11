import 'package:attendance_apk/constants/app_colors.dart';
import 'package:attendance_apk/controllers/employee_dashboard_controller.dart';
import 'package:attendance_apk/views/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'widgets/dashboard_widgets.dart';
import 'leave_apply_screen.dart';
import 'attendance_screen.dart';
import '../controllers/check_in_controller.dart';
import 'leave_status_screen.dart';

class EmployeeDashboardScreen extends GetView<EmployeeDashboardController> {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkInController = Get.find<CheckInController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.dashboardBlue800,
                                  AppColors.dashboardGreen600,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.zero,
                                bottomLeft: Radius.zero,
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/Screenshot 2025-03-01 094607.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.currentUser.value?.name ??
                                              'User',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Obx(
                                        () => Text(
                                          controller.currentUser.value?.email ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.dashboardGrey200,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 35,
                          top: 9,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.transparentGrey20,
                                  spreadRadius: 6,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/logoimages.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.transparentGrey20,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Obx(
                              () => Text(
                                'Good Morning,\n${controller.currentUser.value?.name ?? 'User'}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.textLight,
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Obx(
                          () => Card(
                            color: Color(0xFFF0F8FF),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.isCheckedIn.value
                                        ? "You are Punch-in ${controller.checkInTime.value}"
                                        : "You haven't Punched-in yet",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          controller.isCheckedIn.value
                                              ? AppColors.success
                                              : AppColors.error,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  if (controller.isCheckedIn.value) ...[
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          size: 16,
                                          color: AppColors.orange,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${controller.checkInTime.value}_${controller.checkInDate.value}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: AppColors.error,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            "Location/IP (for remote attendance)",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.textLight,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed:
                                              controller.isCheckedIn.value
                                                  ? null
                                                  : () {
                                                    // Set punch-in time
                                                    final now = TimeOfDay.now();
                                                    final formattedTime = now
                                                        .format(context);
                                                    checkInController
                                                        .updateCheckInTime(
                                                          formattedTime,
                                                        );
                                                    if (!controller
                                                        .isCheckedIn
                                                        .value) {
                                                      _showPunchInTypeDialog(
                                                        context,
                                                      );
                                                    }
                                                  },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller.isCheckedIn.value
                                                    ? AppColors.dashboardGrey300
                                                    : AppColors.blueAccent,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.login,
                                                color:
                                                    controller.isCheckedIn.value
                                                        ? AppColors
                                                            .dashboardGrey600
                                                        : AppColors.white,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Punch In',
                                                style: TextStyle(
                                                  color:
                                                      controller
                                                              .isCheckedIn
                                                              .value
                                                          ? AppColors
                                                              .dashboardGrey600
                                                          : AppColors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed:
                                              controller.isCheckedIn.value
                                                  ? () {
                                                    // Set punch-out time
                                                    final now = TimeOfDay.now();
                                                    final formattedTime = now
                                                        .format(context);
                                                    checkInController
                                                        .updateCheckOutTime(
                                                          formattedTime,
                                                        );
                                                    controller.checkOut();
                                                  }
                                                  : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller.isCheckedIn.value
                                                    ? AppColors.blueAccent
                                                    : AppColors
                                                        .dashboardGrey300,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                color:
                                                    controller.isCheckedIn.value
                                                        ? AppColors.white
                                                        : AppColors
                                                            .dashboardGrey600,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Punch Out',
                                                style: TextStyle(
                                                  color:
                                                      controller
                                                              .isCheckedIn
                                                              .value
                                                          ? AppColors.white
                                                          : AppColors
                                                              .dashboardGrey600,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Overview",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  DashboardWidgets.buildOverviewCard(
                                    "20",
                                    "Presence",
                                    AppColors.dashboardGreenDark,
                                  ),
                                  DashboardWidgets.buildOverviewCard(
                                    "03",
                                    "Absence",
                                    AppColors.error,
                                  ),
                                  DashboardWidgets.buildOverviewCard(
                                    "02",
                                    "Leaves",
                                    AppColors.orange,
                                  ),
                                ],
                              ),
                              Obx(
                                () =>
                                    controller.showTasks.value
                                        ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  DashboardWidgets.performanceTab(
                                                    "My Tasks",
                                                    0,
                                                    controller
                                                        .selectedTabIndex
                                                        .value,
                                                    controller.changeTab,
                                                  ),
                                                  DashboardWidgets.performanceTab(
                                                    "Task Tracker",
                                                    1,
                                                    controller
                                                        .selectedTabIndex
                                                        .value,
                                                    controller.changeTab,
                                                  ),
                                                  DashboardWidgets.performanceTab(
                                                    "Ongoing & Pending Tasks",
                                                    2,
                                                    controller
                                                        .selectedTabIndex
                                                        .value,
                                                    controller.changeTab,
                                                  ),
                                                  DashboardWidgets.performanceTab(
                                                    "Work Summary",
                                                    3,
                                                    controller
                                                        .selectedTabIndex
                                                        .value,
                                                    controller.changeTab,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 13),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Sort By:",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),

                                                  // Deadline Radio
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio<String>(
                                                        value: 'Deadline',
                                                        groupValue:
                                                            controller
                                                                .selectedSortOption
                                                                .value,
                                                        onChanged: (
                                                          String? value,
                                                        ) {
                                                          if (value != null)
                                                            controller
                                                                .changeSortOption(
                                                                  value,
                                                                );
                                                        },
                                                        activeColor:
                                                            AppColors.black,
                                                      ),
                                                      const Text("Deadline"),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 16),

                                                  // Project Radio
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio<String>(
                                                        value: 'Project',
                                                        groupValue:
                                                            controller
                                                                .selectedSortOption
                                                                .value,
                                                        onChanged: (
                                                          String? value,
                                                        ) {
                                                          if (value != null)
                                                            controller
                                                                .changeSortOption(
                                                                  value,
                                                                );
                                                        },
                                                        activeColor:
                                                            AppColors.black,
                                                      ),
                                                      const Text("Project"),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Icon(
                                                    Icons.tune,
                                                    color: AppColors.black,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(height: 13),
                                            getTaskList(
                                              controller.selectedTabIndex.value,
                                            ),
                                          ],
                                        )
                                        : const SizedBox(),
                              ),
                              const SizedBox(height: 25),
                              const Text(
                                "Dashboard",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const AttendanceCalendarPage(),
                                        ),
                                      );
                                    },
                                    child: DashboardWidgets.dashboardItem(
                                      Icons.calendar_today,
                                      "Attendance",
                                      AppColors.lightGreen,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const LeaveApplyScreen(),
                                        ),
                                      );
                                    },
                                    child: DashboardWidgets.dashboardItem(
                                      Icons.logout,
                                      "Leaves",
                                      AppColors.orange,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => LeaveStatusScreen(),
                                        ),
                                      );
                                    },
                                    child: DashboardWidgets.dashboardItem(
                                      Icons.info,
                                      "Leave Status",
                                      const Color.fromARGB(255, 65, 2, 78),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(builder: (context) => HolidayListScreen()),
                                  //     );
                                  //   },
                                  //   child: DashboardWidgets.dashboardItem(Icons.event_note, "Holiday List", AppColors.darkBlue),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(builder: (context) => PayslipScreen()),
                                  //     );
                                  //   },
                                  //   child: DashboardWidgets.dashboardItem(Icons.receipt_long, "Payslip", AppColors.darkGreen),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(builder: (context) => ReportPage()),
                                  //     );
                                  //   },
                                  //   child: DashboardWidgets.dashboardItem(Icons.bar_chart, "Reports", AppColors.Red),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.changeTab(0);
                      },
                      child: DashboardWidgets.buildBottomNavItem(
                        Icons.home,
                        'Home',
                        controller.selectedTabIndex.value == 0,
                      ),
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   controller.changeTab(1);
                      // },
                      child: DashboardWidgets.buildBottomNavItem(
                        Icons.history,
                        'History',
                        controller.selectedTabIndex.value == 1,
                      ),
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   controller.changeTab(2);
                      // },
                      child: DashboardWidgets.buildBottomNavItem(
                        Icons.calendar_today,
                        'Leave',
                        controller.selectedTabIndex.value == 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const EmployeeProfileScreen()),
                        // );
                      },
                      child: DashboardWidgets.buildBottomNavItem(
                        Icons.person,
                        'Profile',
                        controller.selectedTabIndex.value == 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTaskList(int tabIndex) {
    return ListView.separated(
      itemCount: controller.getCurrentTaskList().length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
      itemBuilder: (context, index) {
        final task = controller.getCurrentTaskList()[index];
        if (tabIndex == 0) {
          return DashboardWidgets.buildMyTaskCard(task);
        } else if (tabIndex == 1) {
          return DashboardWidgets.buildTaskDetailCard(task);
        } else if (tabIndex == 2) {
          return DashboardWidgets.buildOngoingTaskCard(task);
        } else if (tabIndex == 3) {
          return DashboardWidgets.buildWorkSummaryCard();
        } else {
          return DashboardWidgets.buildTaskDetailCard(task);
        }
      },
    );
  }

void _showPunchInTypeDialog(BuildContext context) {
  final checkInController = Get.find<CheckInController>();

  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title Row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Punch-In Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),

          /// Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Are you working from home or on site today?',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 20),

          /// Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                /// On Site
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      checkInController.updatePunchInType('Onsite');
                      await checkInController.punchInViaQR(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'On Site',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                /// Work From Home
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      checkInController.updatePunchInType('Work From Home');
                      bool success = await checkInController.punchInWorkFromHome();
                      if (success) {
                        Get.snackbar("Success", "Punch In Successful (WFH)");
                        checkInController.updateCheckInStatus(true, punchInType: 'Work From Home');
                      } else {
                        Get.snackbar("Failed", "WFH Punch In Failed");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Work From Home',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
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
}
}
