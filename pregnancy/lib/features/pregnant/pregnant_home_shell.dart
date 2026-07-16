import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_community_screen.dart';
import 'pregnant_home_screen.dart';
import 'pregnant_journey_screen.dart';
import 'pregnant_profile_screen.dart';
import 'pregnant_tools_screen.dart';

class PregnantHomeShell extends StatefulWidget {
  const PregnantHomeShell({
    super.key,
    this.userName = 'Ayesha',
    this.weeksPregnant = 12,
  });

  final String userName;
  final int weeksPregnant;

  @override
  State<PregnantHomeShell> createState() => _PregnantHomeShellState();
}

class _PregnantHomeShellState extends State<PregnantHomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final fullName = widget.userName.contains(' ')
        ? widget.userName
        : '${widget.userName} Khan';

    final pages = [
      PregnantHomeScreen(
        userName: widget.userName,
        weeksPregnant: widget.weeksPregnant,
      ),
      PregnantJourneyScreen(
        weeksPregnant: widget.weeksPregnant,
        userName: widget.userName,
      ),
      PregnantToolsScreen(weeksPregnant: widget.weeksPregnant),
      const PregnantCommunityScreen(),
      PregnantProfileScreen(
        userName: fullName,
        weeksPregnant: widget.weeksPregnant,
      ),
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
                  icon: Icons.favorite_outline,
                  label: 'Journey',
                  selected: _index == 1,
                  onTap: () => setState(() => _index = 1),
                ),
                _NavItem(
                  icon: Icons.local_florist_outlined,
                  label: 'Tools',
                  selected: _index == 2,
                  onTap: () => setState(() => _index = 2),
                ),
                _NavItem(
                  icon: Icons.forum_outlined,
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
