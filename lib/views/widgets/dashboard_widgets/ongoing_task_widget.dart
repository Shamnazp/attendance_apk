import 'package:attendance_apk/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OngoingTaskWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  const OngoingTaskWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return buildOngoingTaskCard(tasks[index]);
      },
    );
  }
}

Widget buildOngoingTaskCard(Map<String, dynamic> task) {
  Color getStatusColor(String status) {
    switch (status) {
      case "Ongoing Task": return AppColors.statusCompleted;
      case "Pending Task": return AppColors.textWarning;
      default: return AppColors.statusNotStarted;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Low": return AppColors.priorityLow;
      case "Medium": return AppColors.priorityMedium;
      case "High": return AppColors.priorityHigh;
      default: return AppColors.priorityLow;
    }
  }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task["title"]!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.statusCompleted,
              ),
            ),
            Text(
              '${task["progress"]}% Done',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text("Status: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
            Text(
              task["status"]!,
              style: TextStyle(
                fontSize: 12,
                color: getStatusColor(task["status"]),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (task["startDate"] != null)
          Text(
            'Start date: ${task["startDate"]}',
            style: TextStyle(fontSize: 12, color: AppColors.grey),
          ),
        if (task["expectedCompletion"] != null)
          Text(
            'Expected completion: ${task["expectedCompletion"]}',
            style: TextStyle(fontSize: 12, color: AppColors.grey),
          ),
        if (task["assignedDate"] != null)
          Text(
            'Assigned date: ${task["assignedDate"]}',
            style: TextStyle(fontSize: 12, color: AppColors.grey),
          ),
        if (task["dueDate"] != null)
          Text(
            'Due date: ${task["dueDate"]}',
            style: TextStyle(fontSize: 12, color: AppColors.grey),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Priority: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
                Text(
                  task["priority"]!,
                  style: TextStyle(
                    fontSize: 12,
                    color: getPriorityColor(task["priority"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Make as Done",
                style: TextStyle(color: AppColors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    ),
  );
} 