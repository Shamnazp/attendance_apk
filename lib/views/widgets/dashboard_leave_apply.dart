import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildStatsCards() {
  return Row(
    children: [
      buildInfoCard('Pending Request', '1', '29 days remaining this year', icon: Icons.hourglass_top),
      const SizedBox(width: 10),
      buildInfoCard('Team Member on Leave', '2', '29 days remaining this year', icon: Icons.group),
    ],
  );
}

Widget buildInfoCard(String title, String value, String subtitle, {IconData? icon}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 4, offset: const Offset(2, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
              if (icon != null) ...[
                Icon(icon, color: Colors.blue, size: 22),
              ]
            ],
          ),
          const SizedBox(height: 44),
          Center(
            child: Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
          Text(subtitle, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
        ],
      ),
    ),
  );
}

Widget buildLeaveOverview() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 4, offset: const Offset(2, 2))
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Leave Overview", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text("Your leave distribution for the current year", style: GoogleFonts.poppins(fontSize: 12)),
        const SizedBox(height: 55),
        Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: barChart("Q1", 0.6),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: barChart("Q2", 0.5),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: barChart("Q3", 0.4),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: barChart("Q4", 0.2),
    ),
  ],
),

        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total days: 20", style: GoogleFonts.poppins(fontSize: 12)),
            Text("Remaining: 29", style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
      ],
    ),
  );
}

Widget barChart(String label, double heightFactor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        height: 80, // fixed height container
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80 * heightFactor, // dynamic height
            width: 55,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.lightBlue, Colors.blue],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}


Widget buildUpcomingLeave() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 4, offset: const Offset(2, 2))
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upcoming Leave", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Text("Your scheduled time off", style: GoogleFonts.poppins(fontSize: 12)),
        const SizedBox(height: 25),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Annual Leave", style: GoogleFonts.poppins(fontSize: 15)),
            ),
            Row(
              children: [
                Expanded(
                  child: Text("April 22–24, 2025 (3 days)", style: GoogleFonts.poppins(fontSize: 13)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: const Text("Pending", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 26),
        Card(
          color: Color(0xFFFFF8E1), // light cream color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 90),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Approval",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Your leave request is awaiting manager approval.",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
} 