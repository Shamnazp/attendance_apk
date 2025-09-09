import 'package:flutter/material.dart';
import '../views/widgets/dashboard_leave_apply.dart';

class LeaveDashboardView extends StatefulWidget {
  const LeaveDashboardView({super.key});

  @override
  State<LeaveDashboardView> createState() => _LeaveDashboardViewState();
}

class _LeaveDashboardViewState extends State<LeaveDashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset("assets/logoimages.png"),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/Screenshot 2025-03-01 094607.png"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // TabBar stays the same, horizontal scroll just in case
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Dashboard"),
                  Tab(text: "Request Leave"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDashboardTab(),
                _buildRequestLeaveTab(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStatsCards(),
          const SizedBox(height: 32),
          const Divider(color: Colors.grey, thickness: 1),
          const SizedBox(height: 32),
          buildLeaveOverview(),
          const SizedBox(height: 32),
          const Divider(color: Colors.grey, thickness: 1),
          const SizedBox(height: 32),
          buildUpcomingLeave(),
        ],
      ),
    );
  }

  Widget _buildRequestLeaveTab() {
    return const Center(
      child: Text(
        'Request Leave Form Placeholder',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
