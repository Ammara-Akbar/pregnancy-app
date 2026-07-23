import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_community_screen.dart';
import 'bride_home_screen.dart';
import 'bride_my_plan_screen.dart';
import 'bride_profile_screen.dart';
import 'bride_reports_screen.dart';

class BrideHomeShell extends StatefulWidget {
  const BrideHomeShell({super.key, this.userName = 'Ayesha'});

  final String userName;

  @override
  State<BrideHomeShell> createState() => _BrideHomeShellState();
}

class _BrideHomeShellState extends State<BrideHomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final fullName = widget.userName.contains(' ')
        ? widget.userName
        : '${widget.userName} Khan';

    // Matches design: Home · Journey · Tools · Community · Profile
    final pages = [
      BrideHomeScreen(userName: widget.userName),
      BrideMyPlanScreen(onBack: () => setState(() => _index = 0)),
      const BrideReportsScreen(),
      const BrideCommunityScreen(),
      BrideProfileScreen(userName: fullName),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: _index == 0,
                  onTap: () => setState(() => _index = 0),
                ),
                _NavItem(
                  icon: Icons.favorite_outline,
                  label: 'Journey',
                  selected: _index == 1,
                  onTap: () => setState(() => _index = 1),
                ),
                _NavItem(
                  icon: Icons.work_outline_rounded,
                  label: 'Tools',
                  selected: _index == 2,
                  onTap: () => setState(() => _index = 2),
                ),
                _NavItem(
                  icon: Icons.groups_outlined,
                  label: 'Community',
                  selected: _index == 3,
                  onTap: () => setState(() => _index = 3),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  selected: _index == 4,
                  onTap: () => setState(() => _index = 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.magenta : AppColors.skipGrey;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
