import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DashboardWidgets {
  static Widget buildOverviewCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(color: color, fontSize: 14)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget performanceTab(String label, int index, int selectedTabIndex, Function(int) onTap) {
    bool isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blueAccent : AppColors.grey200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (label == "My Tasks") Icon(Icons.task, size: 16, color: AppColors.black),
              if (label == "Task Tracker") Icon(Icons.track_changes, size: 16, color: AppColors.black),
              if (label == "Ongoing & Pending Tasks") Icon(Icons.loop, size: 16, color: AppColors.black),
              if (label == "Work Summary") Icon(Icons.work, size: 16, color: AppColors.black),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(color: isSelected ? AppColors.white : AppColors.black)),
            ],
          ),
        ),
      ),
    );
  }

  // status indicators
  static Widget buildStatusIndicator(String label, Color color, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? color : AppColors.transparent, width: 1.5)
            ),
          ),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: isSelected && label == "In Progress" ? AppColors.statusInProgress : (isSelected ? AppColors.black : AppColors.grey))),
        ],
      ),
    );
  }

  // priority options
  static Widget buildPriorityOption(String label, Color color, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: isSelected ? AppColors.black : AppColors.grey, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  static Widget dashboardItem(IconData icon, String label, Color iconColor) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,  
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.grey700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget buildBottomNavItem(IconData icon, String label, bool isSelected) {
    return Column(
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
    );
  }

  // New helper method for building a single task detail card
  static Widget buildTaskDetailCard(Map<String, dynamic> task) {
    Color getStatusColor(String status) {
      switch (status) {
        case "Not Started": return AppColors.statusNotStarted;
        case "In Progress": return AppColors.statusNotStarted;
        case "Completed": return AppColors.statusCompleted;
        case "Overdue": return AppColors.statusOverdue;
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
          // Task Title and Due Date
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
                'Due Date: ${task["dueDate"]}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Status
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text("Status: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
                DashboardWidgets.buildStatusIndicator("Not Started", getStatusColor(task["status"]), task["status"] == "Not Started"),
                DashboardWidgets.buildStatusIndicator("In Progress", getStatusColor(task["status"]), task["status"] == "In Progress"),
                DashboardWidgets.buildStatusIndicator("Completed", getStatusColor(task["status"]), task["status"] == "Completed"),
                DashboardWidgets.buildStatusIndicator("Overdue", getStatusColor(task["status"]), task["status"] == "Overdue"),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Progress
          Row(
            children: [
              Text("Progress: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
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
                  Text('${task["progress"]}%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(width: 10),
              Text(
                task["status"] == "Completed" ? "" : (task["progress"] < 100 ? "${100 - task["progress"]} days remaining" : ""),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textWarning,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (task["assignedBy"] != null)
                Row(
                  children: [
                    Icon(Icons.assignment_ind, size: 14, color: AppColors.grey),
                    const SizedBox(width: 5),
                    Text(
                      'Assigned By (optional)',
                      style: TextStyle(fontSize: 12, color: AppColors.grey),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Priority
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text("Priority: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
                DashboardWidgets.buildPriorityOption("Low", getPriorityColor("Low"), task["priority"] == "Low"),
                DashboardWidgets.buildPriorityOption("Medium", getPriorityColor("Medium"), task["priority"] == "Medium"),
                DashboardWidgets.buildPriorityOption("High", getPriorityColor("High"), task["priority"] == "High"),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "Start",
                    groupValue: null,  
                    onChanged: null,
                    activeColor: AppColors.blueAccent,
                  ),
                  Text("Start", style: TextStyle(fontSize: 10, color: AppColors.black)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "Update",
                    groupValue: null,  
                    onChanged: null,
                    activeColor: AppColors.blueAccent,
                  ),
                  Text("Update", style: TextStyle(fontSize: 10, color: AppColors.black)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "Complete",
                    groupValue: null, // Not interactive for now
                    onChanged: null,
                    activeColor: AppColors.blueAccent,
                  ),
                  Text("Complete", style: TextStyle(fontSize: 10, color: AppColors.black)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // My Tasks tab
  static Widget buildMyTaskCard(Map<String, dynamic> task) {
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

  // method for Ongoing & Pending Tasks tab
  static Widget buildOngoingTaskCard(Map<String, dynamic> task) {
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
          const SizedBox(height: 10),

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

  // method for Work Summary tab
  static Widget buildWorkSummaryCard() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DashboardWidgets.buildWorkSummaryItem(Icons.calendar_today, "Total Working Days", "20"),
        DashboardWidgets.buildWorkSummaryItem(Icons.access_time, "Total Hours worked", "160 hours"),
        DashboardWidgets.buildWorkSummaryItem(Icons.schedule, "Average Daily Hours", "8.0 hours"),
        DashboardWidgets.buildWorkSummaryItem(Icons.bar_chart, "Productivity Indicator", "80%"),
        DashboardWidgets.buildWorkSummaryItem(Icons.people, "Projects Involved", "Revenue Dashboard"),
        DashboardWidgets.buildWorkSummaryItem(Icons.assignment, "Leave Taken", "2 days"),
      ],
    );
  }

  //  for individual work summary item
  static Widget buildWorkSummaryItem(IconData icon, String label, String value) {
    return Container(
      width: 30,
      height: 15,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppColors.blueAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
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