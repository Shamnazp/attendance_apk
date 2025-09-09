import 'package:attendance_apk/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WorkSummaryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> summaries;
  const WorkSummaryWidget({Key? key, required this.summaries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: summaries.length,
      itemBuilder: (context, index) {
        return buildWorkSummaryCard(summaries[index]);
      },
    );
  }
}

Widget buildWorkSummaryCard(Map<String, dynamic> summary) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(15),
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
          summary["title"]!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.statusCompleted,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          summary["desc"]!,
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
              "View",
              style: TextStyle(color: AppColors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
} 