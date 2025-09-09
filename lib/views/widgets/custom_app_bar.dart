import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/employee_dashboard_controller.dart';
import '../EmployeeDashboardScreen.dart';
import 'custom_search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showSearch;
  final bool showNotifications;
  final bool showProfile;
  final bool showDashboardNavigation;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;

  const CustomAppBar({
    Key? key,
    this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.showSearch = true,
    this.showNotifications = true,
    this.showProfile = true,
    this.showDashboardNavigation = false,
    this.searchController,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _buildLogoButton(context),
              const SizedBox(width: 10),
              if (showSearch) _buildSearchBar(context),
              if (showSearch) const SizedBox(width: 10),
              if (showNotifications) _buildNotificationButton(),
              if (showNotifications) const SizedBox(width: 10),
              if (showProfile) _buildProfileAvatar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onBackPressed != null) {
          onBackPressed!();
        } else if (showDashboardNavigation) {
          // Navigate to dashboard
          if (!Get.isRegistered<EmployeeDashboardController>()) {
            Get.lazyPut(() => EmployeeDashboardController());
          }
          Get.to(() => const EmployeeDashboardScreen());
        } else if (showBackButton) {
          // Default back navigation
          Navigator.of(context).pop();
        }
      },
      child: const CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage('assets/logoimages.png'),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showCustomSearchDialog(context);
        },
        child: AbsorbPointer(
          child: Container(
            height: 38,
            color: AppColors.white,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(color: AppColors.grey, fontSize: 16),
              onChanged: onSearchChanged,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity15,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Stack(
          children: [
            const Icon(Icons.notifications, color: AppColors.blue, size: 28),
            Positioned(
              right: 0,
              top: 2,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return const CircleAvatar(
      radius: 18,
      backgroundImage: AssetImage('assets/Screenshot 2025-03-01 094607.png'),
    );
  }
} 