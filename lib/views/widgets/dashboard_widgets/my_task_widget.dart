import 'package:attendance_apk/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyTaskWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  const MyTaskWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return buildMyTaskCard(tasks[index]);
      },
    );
  }
}

Widget buildMyTaskCard(Map<String, dynamic> task) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: AppColors.greyWithOpacity1,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task["title"]!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.statusCompleted,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          task["desc"]!,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Start",
              style: TextStyle(color: AppColors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
} 