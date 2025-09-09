import 'package:flutter/material.dart';
import '../views/widgets/dashboard_leave_apply.dart';
import '../views/widgets/custom_calendar.dart';
import '../views/widgets/custom_app_bar.dart';
import '../../constants/app_colors.dart';

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({super.key});

  @override
  State<LeaveStatusScreen> createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // For the custom calendar day coloring
  final Map<int, Map<String, dynamic>> _leaves = {
    3: {'type': 'Approved', 'color': AppColors.green},
    12: {'type': 'Approved', 'color': AppColors.green},
    16: {'type': 'Rejected', 'color': AppColors.red},
    20: {'type': 'Pending', 'color': AppColors.orange},
    25: {'type': 'Upcoming', 'color': AppColors.blue},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSummaryCards(context),
            const SizedBox(height: 20),
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildLeaveTable(),
            const SizedBox(height: 20),
            buildLeaveOverview(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopSummaryCards(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double spacing = 12;
    final double cardWidth = (screenWidth - 32 - spacing) / 2;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        _infoCard(cardWidth, Icons.event_busy, "Leave Taken", "16 days", "10 days remaining this month", AppColors.blue, showProgress: true),
        _infoCard(cardWidth, Icons.event_available, "Leave Balance", "8 days", "29 days remaining this month", AppColors.blue),
        _infoCard(cardWidth, Icons.hourglass_bottom, "Pending Request", "1 request", "29 days remaining this month", AppColors.blue),
        _infoCard(cardWidth, Icons.check_circle_outline, "Approved Leaves", "5 leaves", "29 days remaining this month", AppColors.blue),
        _infoCard(cardWidth, Icons.cancel_outlined, "Rejected Leaves", "2 leaves", "29 days remaining this month", AppColors.blue),
        _infoCard(cardWidth, Icons.upcoming, "Upcoming Leaves", "1 leave", "Scheduled (25 June)", AppColors.blue),
      ],
    );
  }

  Widget _infoCard(double width, IconData icon, String title, String value, String subtitle, Color iconColor, {bool showProgress = false}) {
    return Container(
      width: width,
      height: showProgress ? 150 : 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWithOpacity5,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 13, color: AppColors.grey))),
              Icon(icon, size: 18, color: iconColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: AppColors.grey),
          ),
          if (showProgress) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.6,
                backgroundColor: AppColors.grey300,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
                minHeight: 6,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return CustomCalendar(
      focusedDate: _focusedDay,
      events: _leaves,
      onDayTap: (day) {
        // Handle day tap if needed
        print('Tapped on day: $day');
      },
      onMonthChanged: (newDate) {
        setState(() {
          _focusedDay = newDate;
        });
      },
      showNavigationArrows: true,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildLeaveTable() {
    return Table(
      border: TableBorder.all(color: AppColors.grey300),
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        _tableRow("Date", "Leave Type", "Status", "Reason", isHeader: true),
        _tableRow("10 June", "Sick Leave", "Approved", "Fever"),
        _tableRow("20 June", "Casual Leave", "Pending", "Family Function"),
        _tableRow("01 July", "WFH", "Rejected", "No backup"),
      ],
    );
  }

  TableRow _tableRow(String d, String l, String s, String r, {bool isHeader = false}) {
    final cells = [d, l, s, r];
    return TableRow(
      children: List.generate(cells.length, (i) => _tableCell(cells[i], isHeader: isHeader, columnIndex: i)),
    );
  }

  Widget _tableCell(String text, {bool isHeader = false, int columnIndex = 0}) {
    Color? textColor;
    if (!isHeader && columnIndex == 2) {
      if (text.toLowerCase() == 'approved') {
        textColor = AppColors.statusApproved;
      } else if (text.toLowerCase() == 'pending') {
        textColor = AppColors.statusPending;
      } else if (text.toLowerCase() == 'rejected') {
        textColor = AppColors.statusRejected;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? AppColors.blue : (textColor ?? AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    // You can update navigation logic as needed
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(Icons.home, 'Home', true, () {}),
          _buildBottomNavItem(Icons.history, 'History', false, () {}),
          _buildBottomNavItem(Icons.calendar_today, 'Leave', false, () {}),
          _buildBottomNavItem(Icons.person, 'Profile', false, () {}),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.lightBlueAccent : AppColors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.blueAccent : AppColors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}