import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'new_mother_baby_screen.dart';
import 'new_mother_community_screen.dart';
import 'new_mother_home_screen.dart';
import 'new_mother_plan_screen.dart';
import 'new_mother_recovery_screen.dart';

class NewMotherHomeShell extends StatefulWidget {
  const NewMotherHomeShell({
    super.key,
    this.userName = 'Ayesha',
    this.daysPostpartum = 8,
  });

  final String userName;
  final int daysPostpartum;

  @override
  State<NewMotherHomeShell> createState() => _NewMotherHomeShellState();
}

class _NewMotherHomeShellState extends State<NewMotherHomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      NewMotherHomeScreen(
        userName: widget.userName,
        daysPostpartum: widget.daysPostpartum,
      ),
      NewMotherBabyScreen(
        daysPostpartum: widget.daysPostpartum,
        motherName: widget.userName,
      ),
      NewMotherRecoveryScreen(daysPostpartum: widget.daysPostpartum),
      const NewMotherPlanScreen(),
      const NewMotherCommunityScreen(),
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
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                  icon: Icons.child_care_rounded,
                  label: 'Baby',
                  selected: _index == 1,
                  onTap: () => setState(() => _index = 1),
                ),
                _NavItem(
                  icon: Icons.favorite_outline,
                  label: 'Recovery',
                  selected: _index == 2,
                  onTap: () => setState(() => _index = 2),
                ),
                _NavItem(
                  icon: Icons.calendar_month_outlined,
                  label: 'Plan',
                  selected: _index == 3,
                  onTap: () => setState(() => _index = 3),
                ),
                _NavItem(
                  icon: Icons.groups_outlined,
                  label: 'Community',
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
            if (selected) ...[
              const SizedBox(height: 2),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.magenta,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
