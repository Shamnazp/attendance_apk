import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';


void showCustomSearchDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dialog",
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(top: 40),
            width: 600,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackWithOpacity5,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row with back + button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back, size: 20, color: AppColors.black),
                        SizedBox(width: 8),
                        Text("05 May 2025", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.customGreen, // Use AppColors
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.play_arrow, color: AppColors.white, size: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Search History",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sick Leave....", style: TextStyle(color: AppColors.grey600)),
                      SizedBox(height: 20),
                      Text("23 May 2025", style: TextStyle(color: AppColors.grey600)),
                      SizedBox(height: 20),
                      Text("Casual leaves ...", style: TextStyle(color: AppColors.grey600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
} 