import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03A9F4);
  static const Color accent = Color(0xFF00BCD4);
  static const Color background = Color(0xFFF5F5F5);
  static const Color text = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color orange = Color(0xFFFFA500);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Dashboard Colors
  static Color dashboardBlue800 = Colors.blue[800]!;
  static Color dashboardGreen600 = Colors.green[600]!;
  static Color dashboardGrey200 = Colors.grey[200]!;
  static Color dashboardGrey100 = Colors.grey[100]!;
  static Color dashboardGrey300 = Colors.grey[300]!;
  static const Color dashboardGrey600 = Color(0xFF757575);
  static const Color dashboardLightBlueAccent = Colors.lightBlueAccent;
  static Color dashboardGreyShade200 = Colors.grey.shade200;
  static const Color dashboardGreenDark = Color.fromARGB(255, 8, 99, 11);
  static Color dashboardGrey700 = Colors.grey[700]!;
  static const Color blueAccent = Colors.blueAccent;
  static Color transparentGrey20 = Colors.grey.withOpacity(0.2);
  static Color transparentBlue10 = Colors.blue.withAlpha((0.1 * 255).round());
  static Color transparentGrey10 = Colors.grey.withAlpha((0.1 * 255).round());
  static const Color lightGreen = Color(0xFF90EE90);
  static const Color violet = Color(0xFFEE82EE);
  static const Color darkBlue = Color(0xFF00008B);
  static const Color darkGreen = Color(0xFF006400);
  static const Color Red = Color(0xFF8B0000);
  static const Color Violet = Color.fromARGB(255, 65, 2, 78);

  // Additional colors used throughout the project
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
  static const Color lightBlue = Colors.lightBlue;
  static const Color lightBlueAccent = Colors.lightBlueAccent;
  
  // Grey shades
  static Color grey50 = Colors.grey[50]!;
  static Color grey100 = Colors.grey[100]!;
  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;
  static Color grey800 = Colors.grey[800]!;
  static Color greyShade300 = Colors.grey.shade300;
  
  // Blue shades
  static Color blue200 = Colors.blue[200]!;
  static Color blue400 = Colors.blue[400]!;
  static Color blue600 = Colors.blue[600]!;
  static Color blue800 = Colors.blue[800]!;
  
  // Green shades
  static Color green600 = Colors.green[600]!;
  static Color green700 = Colors.green[700]!;
  
  // Orange shades
  static Color orange700 = Colors.orange[700]!;
  
  // Red shades
  static Color red700 = Colors.red[700]!;
  
  // Custom hex colors
  static const Color customGreen = Color(0xFF43A047);
  static const Color customDarkBlue = Color(0xFF183153);
  static const Color customBlack87 = Color(0xFF000000);
  
  // Success screen gradient colors
  static const Color punchOutGradient1 = Color(0xFFFFF3E0);
  static const Color punchOutGradient2 = Color(0xFFFFB74D);
  static const Color punchOutGradient3 = Color(0xFFFF9800);
  static const Color punchInGradient1 = Color(0xFFE8F5E9);
  static const Color punchInGradient2 = Color(0xFF81C784);
  static const Color punchInGradient3 = Color(0xFF4CAF50);
  
  // Shadow and overlay colors
  static Color black12 = Colors.black12;
  static Color blackWithOpacity5 = Colors.black.withOpacity(0.05);
  static Color greyWithOpacity1 = Colors.grey.withOpacity(0.1);
  static Color greyWithOpacity15 = Colors.grey.withOpacity(0.15);
  static Color greyWithOpacity2 = Colors.grey.withOpacity(0.2);
  
  // Transparent colors
  static const Color transparent = Colors.transparent;
  
  // Progress indicator colors
  static Color progressBackground = Colors.grey[200]!;
  static Color progressValue = Colors.green;
  
  // Status colors
  static Color statusApproved = Colors.green[700]!;
  static Color statusPending = Colors.orange[700]!;
  static Color statusRejected = Colors.red[700]!;
  static Color statusInProgress = Colors.green;
  static Color statusNotStarted = Colors.grey;
  static Color statusCompleted = Colors.green;
  static Color statusOverdue = Colors.red;
  
  // Priority colors
  static Color priorityLow = Colors.grey;
  static Color priorityMedium = Colors.orange;
  static Color priorityHigh = Colors.red;
  
  // Calendar colors
  static Color calendarDayText = Colors.grey[800]!;
  static Color calendarHeaderText = Colors.grey[600]!;
  static Color calendarMonthText = Colors.grey[800]!;
  
  // Button and interactive colors
  static Color buttonPrimary = Color(0xFF2196F3);
  static Color buttonSuccess = Colors.green;
  static Color buttonError = Colors.red;
  
  // Text colors
  static Color textPrimary = Colors.black87;
  static Color textSecondary = Colors.grey;
  static Color textSuccess = Colors.green;
  static Color textError = Colors.red;
  static Color textWarning = Colors.orange;
  
  // Border colors
  static Color borderGrey = Colors.grey;
  static Color borderLightGrey = Colors.grey[300]!;
  
  // Background colors
  static Color backgroundGrey50 = Colors.grey[50]!;
  static Color backgroundWhite = Colors.white;
  
  // Notification colors
  static Color notificationRed = Colors.red;
  static Color notificationBlue = Colors.blue;
  
  // Chart colors
  static Color chartLightGreen = Colors.lightGreen;
  static Color chartRed = Colors.red;
  static Color chartOrange = Colors.orange;
  static Color chartBlue = Colors.blue;
  
  // Work mode colors
  static Color workModeBlue = Colors.blue;
  static Color verificationOrange = Colors.orange;
  static Color checkInGreen = Colors.lightGreen;

  static const Color lightGreenBackground = Color(0xFFEFFFE9); // Very light green for Net Pay card backgrounds

  // Custom colors from project usage
  static const Color aliceBlue = Color(0xFFF0F8FF); // Used for backgrounds
  static const Color lightCream = Color(0xFFFFF8E1); // Used in dashboard_leave_apply.dart
  static const Color deepViolet = Color.fromARGB(255, 65, 2, 78); // Used in EmployeeDashboardScreen.dart
  static const Color black87 = Colors.black87; // Used for text
  static const List<Color> blueGradient = [lightBlue, blue]; // Used in dashboard_leave_apply.dart
} 