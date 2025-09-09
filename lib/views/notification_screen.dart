import 'package:attendance_apk/constants/app_colors.dart';
import 'package:attendance_apk/views/widgets/dashboard_widgets.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<_NotificationItem> _notifications = [
    _NotificationItem(
      icon: Icons.close,
      iconColor: AppColors.red,
      title: 'Missed Punch',
      subtitle: 'Missed Clock-in Detected. Please update your attendance or contact HR.',
      backgroundColor: AppColors.white,
    ),
    _NotificationItem(
      icon: Icons.access_time,
      iconColor: AppColors.orange,
      title: 'Late Attendance',
      subtitle: 'You\'re running late! Your clock-in time is beyond the scheduled shift start.',
      backgroundColor: AppColors.white,
    ),
    _NotificationItem(
      icon: Icons.calendar_today,
      iconColor: AppColors.blue,
      title: 'Daily Summary',
      subtitle: 'Your attendance today: Clock-in at 9:12 AM, Clock-out at 6:05 PM. Total hours: 8.53',
      backgroundColor: AppColors.white,
    ),
    _NotificationItem(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      title: 'Leave Approval',
      subtitle: 'Your leave request for June 15 has been approved. Enjoy your day off!',
      backgroundColor: AppColors.white,
    ),
    _NotificationItem(
      icon: Icons.cancel,
      iconColor: AppColors.red,
      title: 'Leave Rejection',
      subtitle: 'Leave request declined. Please check with your manager for details.',
      backgroundColor: AppColors.white,
    ),
    _NotificationItem(
      icon: Icons.update,
      iconColor: AppColors.blue,
      title: 'Shift Update',
      subtitle: 'Shift updated: New shift time is 10:00 AM – 7:00 PM, effective from June 14.',
      backgroundColor: AppColors.white,
    ),
  ];

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _notifications.isEmpty
          ? Center(child: Text('No notifications'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              separatorBuilder: (context, i) => const SizedBox(height: 16),
              itemBuilder: (context, i) => GestureDetector(
                onTap: () => _removeNotification(i),
                child: _buildNotificationItem(
                  icon: _notifications[i].icon,
                  iconColor: _notifications[i].iconColor,
                  title: _notifications[i].title,
                  subtitle: _notifications[i].subtitle,
                  backgroundColor: _notifications[i].backgroundColor,
                ),
              ),
            ),
      bottomNavigationBar: Container(
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Go back to Home/Dashboard
              },
              child: DashboardWidgets.buildBottomNavItem(Icons.home, 'Home', true),
            ),
            GestureDetector(
              onTap: () {},
              child: DashboardWidgets.buildBottomNavItem(Icons.history, 'History', false),
            ),
            GestureDetector(
              onTap: () {},
              child: DashboardWidgets.buildBottomNavItem(Icons.calendar_today, 'Leave', false),
            ),
            GestureDetector(
              onTap: () {},
              child: DashboardWidgets.buildBottomNavItem(Icons.person, 'Profile', false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color backgroundColor;

  _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
  });
}