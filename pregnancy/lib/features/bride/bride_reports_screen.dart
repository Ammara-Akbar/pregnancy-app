import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BrideReportsScreen extends StatelessWidget {
  const BrideReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            children: [
              const Text(
                'Reports',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF2C3A55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Health Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _OverviewCircleCard(
                  title: 'Wellness Score',
                  center: '78%',
                  subtitle: 'Good',
                  subtitleColor: Color(0xFF4CAF7A),
                  progress: 0.78,
                  color: AppColors.magenta,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _OverviewCircleCard(
                  title: 'Tests Completed',
                  center: '4/8',
                  subtitle: '',
                  progress: 0.5,
                  color: AppColors.magenta,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _OverviewCircleCard(
                  title: 'Habits Followed',
                  center: '8/12',
                  subtitle: '',
                  progress: 8 / 12,
                  color: Color(0xFFE07A4A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          _ProgressMetricTile(
            icon: Icons.monitor_weight_outlined,
            iconColor: AppColors.magenta,
            title: 'Weight',
            value: '65 kg',
            badge: '- 1.5 kg',
            badgeColor: AppColors.magenta,
          ),
          _ProgressMetricTile(
            icon: Icons.local_drink_rounded,
            iconColor: const Color(0xFF5BA8D9),
            title: 'Water Intake',
            value: '6 / 8 glasses',
            badge: 'Good',
            badgeColor: const Color(0xFF4CAF7A),
          ),
          _ProgressMetricTile(
            icon: Icons.directions_walk_rounded,
            iconColor: const Color(0xFF66BB6A),
            title: 'Steps',
            value: '5,320 steps',
            badge: 'Improving',
            badgeColor: const Color(0xFFE07A4A),
          ),
          _ProgressMetricTile(
            icon: Icons.bedtime_outlined,
            iconColor: const Color(0xFF7E57C2),
            title: 'Sleep',
            value: '7.2 hrs',
            badge: 'Good',
            badgeColor: const Color(0xFF4CAF7A),
          ),
          const SizedBox(height: 18),
          const Text(
            'Reports & Tests',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const _ReportTile(
                  icon: Icons.bloodtype_outlined,
                  title: 'Hemoglobin (Hb)',
                  value: '12.2 g/dL',
                ),
                const Divider(height: 1, indent: 62, color: Color(0xFFF3E8ED)),
                const _ReportTile(
                  icon: Icons.biotech_outlined,
                  title: 'Thalassemia Screening',
                  value: 'Negative',
                ),
                const Divider(height: 1, indent: 62, color: Color(0xFFF3E8ED)),
                const _ReportTile(
                  icon: Icons.water_drop_outlined,
                  title: 'Blood Group',
                  value: 'B+',
                ),
                const Divider(height: 1, indent: 62, color: Color(0xFFF3E8ED)),
                const _ReportTile(
                  icon: Icons.science_outlined,
                  title: 'Blood Sugar (FBS)',
                  value: '92 mg/dL',
                ),
                const Divider(height: 1, indent: 62, color: Color(0xFFF3E8ED)),
                const _ReportTile(
                  icon: Icons.favorite_outline,
                  title: 'Thyroid (TSH)',
                  value: '2.1 mIU/L',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.magenta,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View all reports',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
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

class _OverviewCircleCard extends StatelessWidget {
  const _OverviewCircleCard({
    required this.title,
    required this.center,
    required this.progress,
    required this.color,
    this.subtitle = '',
    this.subtitleColor,
  });

  final String title;
  final String center;
  final String subtitle;
  final Color? subtitleColor;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: color.withValues(alpha: 0.15),
                  color: color,
                ),
                Text(
                  center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3A55),
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: subtitleColor ?? AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgressMetricTile extends StatelessWidget {
  const _ProgressMetricTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.badge,
    required this.badgeColor,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String badge;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: badgeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.blush,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.magenta, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF7A).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Normal',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4CAF7A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
