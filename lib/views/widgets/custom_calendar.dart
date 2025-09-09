import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime focusedDate;
  final Map<int, Map<String, dynamic>> events;
  final Function(int)? onDayTap;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool showNavigationArrows;
  final Function(DateTime)? onMonthChanged;

  const CustomCalendar({
    Key? key,
    required this.focusedDate,
    required this.events,
    this.onDayTap,
    this.height,
    this.margin,
    this.padding,
    this.showNavigationArrows = false,
    this.onMonthChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(20),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
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
        children: [
          if (showNavigationArrows) _buildMonthNavigation(),
          _buildDaysOfWeek(),
          const SizedBox(height: 8),
          _buildMonthLabel(),
          const SizedBox(height: 12),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildMonthNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            final previousMonth = DateTime(focusedDate.year, focusedDate.month - 1);
            onMonthChanged?.call(previousMonth);
          },
          icon: const Icon(Icons.chevron_left, color: AppColors.blue),
        ),
        IconButton(
          onPressed: () {
            final nextMonth = DateTime(focusedDate.year, focusedDate.month + 1);
            onMonthChanged?.call(nextMonth);
          },
          icon: const Icon(Icons.chevron_right, color: AppColors.blue),
        ),
      ],
    );
  }

  Widget _buildDaysOfWeek() {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: days.map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: AppColors.calendarHeaderText,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildMonthLabel() {
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '${monthNames[focusedDate.month - 1]} ${focusedDate.year}',
        style: TextStyle(
          fontSize: 15,
          color: AppColors.calendarMonthText,
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    final lastDayOfMonth = DateTime(focusedDate.year, focusedDate.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // Convert to 0-based (Sunday = 0)
    
    final totalDays = firstWeekday + daysInMonth;
    final weeks = (totalDays / 7).ceil();

    return Column(
      children: List.generate(weeks, (weekIndex) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 1;
              
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const Expanded(child: SizedBox());
              }
              
              return Expanded(child: _buildCalendarDay(dayNumber));
            }),
          ),
        );
      }),
    );
  }

  Widget _buildCalendarDay(int day) {
    final hasEvent = events.containsKey(day);
    final eventData = events[day];
    final isToday = day == DateTime.now().day && 
                   focusedDate.month == DateTime.now().month && 
                   focusedDate.year == DateTime.now().year;

    return GestureDetector(
      onTap: () => onDayTap?.call(day),
      child: Container(
        height: height ?? 40,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: hasEvent 
              ? (eventData!['color'] as Color).withOpacity(0.8) 
              : isToday 
                  ? AppColors.blue.withOpacity(0.1)
                  : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: isToday 
              ? Border.all(color: AppColors.blue, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              color: hasEvent 
                  ? AppColors.white 
                  : isToday 
                      ? AppColors.blue
                      : AppColors.calendarDayText,
              fontWeight: (hasEvent || isToday) ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
} 