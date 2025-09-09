import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../controllers/check_in_controller.dart';
import '../constants/app_colors.dart';

class AttendanceCalendarPage extends StatefulWidget {
  const AttendanceCalendarPage({super.key});

  @override
  State<AttendanceCalendarPage> createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late final CheckInController checkInController;

  @override
  void initState() {
    super.initState();
    checkInController = Get.find<CheckInController>();
  }

  int getTotalDaysOfMonth(DateTime date) {
    final beginningNextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1)).day;
  }

  @override
  Widget build(BuildContext context) {
    int totalDays = getTotalDaysOfMonth(_focusedDay);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.black),
        title: const Text(
          'Attendance Calendar',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCalendarSection(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Days: $totalDays',
                    style: const TextStyle(color: AppColors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const AttendanceOverviewCards(),
            const SizedBox(height: 7),
            const SizedBox(height: 12),
            _buildDonutChart(),
            const SizedBox(height: 20),
            _buildDetailedInfo(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    final Map<int, Color> customDayColors = {
      9: AppColors.chartLightGreen,
      10: AppColors.chartLightGreen,
      16: AppColors.chartLightGreen,
      17: AppColors.chartLightGreen,
      24: AppColors.chartRed,
      25: AppColors.chartOrange,
      6: AppColors.lightBlue,
    };
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyShade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: AppColors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: TextStyle(
            color: AppColors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        calendarStyle: const CalendarStyle(
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final color = customDayColors[day.day];
            return Center(
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: color ?? AppColors.transparent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: color != null ? AppColors.white : AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            final color = customDayColors[day.day];
            return Center(
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: color ?? AppColors.transparent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: color != null ? AppColors.white : AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDonutChart() {
    return SizedBox(
      width: 220,
      height: 220,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 60,
          sectionsSpace: 1,
          startDegreeOffset: 400,
          sections: [
            PieChartSectionData(
              color: AppColors.chartLightGreen,
              value: 20,
              title: '20 Days',
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),
              radius: 55,
            ),
            PieChartSectionData(
              color: AppColors.chartRed,
              value: 3,
              title: '03 Days',
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),
              radius: 55,
            ),
            PieChartSectionData(
              color: AppColors.chartOrange,
              value: 2,
              title: '02 Days',
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),
              radius: 55,
            ),
            PieChartSectionData(
              color: AppColors.chartBlue,
              value: 6,
              title: '06 Days',
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),
              radius: 55,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedInfo(BuildContext context) {
    final formattedDate = DateFormat('MMMM d, yyyy').format(_selectedDay);

    return Obx(() {
      String verificationType;
      if (checkInController.punchInType.value == 'Onsite') {
        verificationType = 'QR';
      } else if (checkInController.punchInType.value == 'Work From Home') {
        verificationType = 'Selfie';
      } else {
        verificationType = '--'; // Default or unknown
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formattedDate, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status', style: TextStyle(fontSize: 14, color: AppColors.grey)),
                Text('Present', style: TextStyle(fontSize: 14, color: AppColors.checkInGreen)),
              ],
            ),
            const SizedBox(height: 16),
            // Check-In and Check-Out Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _infoBlock(context, Icons.access_time, 'Check-In', checkInController.checkInTime.value),
                ),
                const SizedBox(width: 16), // Spacer between blocks
                Expanded(
                  child: _infoBlock(context, Icons.access_time, 'Check-Out', checkInController.checkOutTime.value.isEmpty ? '--' : checkInController.checkOutTime.value),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Work Mode and Verification Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _infoBlock(context, null, 'Work Mode', checkInController.punchInType.value, chipColor: AppColors.workModeBlue), // No icon
                ),
                const SizedBox(width: 16), // Spacer between blocks
                Expanded(
                  child: _infoBlock(context, null, 'Verification', verificationType, chipColor: AppColors.verificationOrange), // No icon
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Location Block
            _infoBlock(context, Icons.location_on, 'Location', checkInController.checkInLocation.value, isFullWidth: true),
            const SizedBox(height: 12),
            // Notes Block
            _infoBlock(context, Icons.edit_note, 'Notes', 'Worked on UI Bug Fixing', isFullWidth: true),
          ],
        ),
      );
    });
  }

  static Widget _infoBlock(BuildContext context, IconData? icon, String title, String subtitle, {Color? chipColor, bool isFullWidth = false}) {
    Color? iconColor;
    if (title == 'Check-In' || title == 'Check-Out') {
      iconColor = AppColors.checkInGreen;
    } else {
      iconColor = AppColors.grey700;
    }
    return Container(
      width: isFullWidth ? double.infinity : MediaQuery.of(context).size.width * 0.45,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyShade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) ...[ // Conditionally add icon if not null
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 2),
                chipColor != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: chipColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          subtitle,
                          style: TextStyle(fontSize: 12, color: chipColor, fontWeight: FontWeight.w500),
                        ),
                      )
                    : Text(subtitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AttendanceOverviewCards extends StatelessWidget {
  const AttendanceOverviewCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _OverviewCard(label: 'Presence', value: '20', textColor: AppColors.chartLightGreen),
          _OverviewCard(label: 'Absence', value: '03', textColor: AppColors.chartRed),
          _OverviewCard(label: 'Leaves', value: '02', textColor: AppColors.chartOrange),
          _OverviewCard(label: 'Late', value: '06', textColor: AppColors.chartBlue),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;

  const _OverviewCard({required this.label, required this.value, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWithOpacity5,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
} 