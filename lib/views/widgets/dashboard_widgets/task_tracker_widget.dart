import 'package:attendance_apk/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TaskTrackerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  const TaskTrackerWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
  return buildTaskDetailCard(context, tasks[index], isFirst: index == 0);
}
,
    );
  }
}

Widget buildTaskDetailCard(BuildContext context, Map<String,dynamic> task, {bool isFirst = false})
 {
  Color getStatusColor(String status) {
    switch (status) {
      case "Not Started":
      case "In Progress":
        return AppColors.statusNotStarted;
      case "Completed":
        return AppColors.statusCompleted;
      case "Overdue":
        return AppColors.statusOverdue;
      default:
        return AppColors.statusNotStarted;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return AppColors.priorityLow;
      case "Medium":
        return isFirst ? AppColors.orange : AppColors.priorityMedium;
      case "High":
        return AppColors.priorityHigh;
      default:
        return AppColors.priorityLow;
    }
  }

  // Progress Row
Widget progressRow = Wrap(
  spacing: 10,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            value: task["progress"] / 100,
            backgroundColor: AppColors.progressBackground,
            color: AppColors.progressValue,
            strokeWidth: 3,
          ),
        ),
        Text(
          '${task["progress"]}%',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    if (task["status"] != "Completed" && task["progress"] < 100)
      Text(
        "${100 - task["progress"]} days remaining",
        style: TextStyle(
          fontSize: 12,
          color: AppColors.textWarning,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    if (task["assignedBy"] != null)
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.assignment_ind, size: 14, color: AppColors.grey),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              'Assigned By (optional)',
              style: TextStyle(fontSize: 12, color: AppColors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
  ],
);



  // Priority Row
  // Priority Row
Widget priorityRow = SizedBox(
  width: double.infinity, // 👈 Add this
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Text("Priority: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
        Text("Low",
            style: TextStyle(
                fontSize: 12,
                color: AppColors.priorityLow,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text("Medium",
            style: TextStyle(
                fontSize: 12,
                color: getPriorityColor("Medium"),
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text("High",
            style: TextStyle(
                fontSize: 12,
                color: AppColors.priorityHigh,
                fontWeight: FontWeight.bold)),
      ],
    ),
  ),
);


  // Actions Row
  Widget actionsRow = Wrap(
  spacing: 10,
  runSpacing: 5,
  children: [
    for (var action in ["Start", "Update", "Complete"])
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: action,
            groupValue: null,
            onChanged: null,
          ),
          Text(action, style: const TextStyle(fontSize: 10)),
        ],
      ),
  ],
);


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
        // Task Title and Due Date
        Row(
  children: [
    // Task Title
    Expanded(
      flex: 2,
      child: Text(
        task["title"] ?? "",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    const SizedBox(width: 8),

    // Due Date (always ellipsize)
    Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Due Date: ${task["dueDate"] ?? ""}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  ],
)

,
        const SizedBox(height: 10),

        // Status Row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text("Status: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
              Text(task["status"] ?? "",
                  style: TextStyle(
                      fontSize: 12, color: getStatusColor(task["status"] ?? ""))),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Progress Row
        progressRow,
        const SizedBox(height: 10),

        // Priority Row
        priorityRow,
        const SizedBox(height: 10),

        // Actions Row
        actionsRow,
      ],
    ),
  );
}
