import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import 'bride_all_reports_screen.dart';
import 'bride_health_report.dart';
import 'bride_report_detail_screen.dart';

class BrideReportsScreen extends StatefulWidget {
  const BrideReportsScreen({super.key});

  @override
  State<BrideReportsScreen> createState() => _BrideReportsScreenState();
}

class _BrideReportsScreenState extends State<BrideReportsScreen> {
  int _periodIndex = 0; // 0 week, 1 month
  late List<BrideHealthReport> _reports = List.of(BrideHealthReport.defaults);

  double get _wellnessScore {
    final normals =
        _reports.where((r) => r.status == BrideReportStatus.normal).length;
    if (_reports.isEmpty) return 0;
    return normals / _reports.length;
  }

  int get _testsDone =>
      _reports.where((r) => r.status != BrideReportStatus.pending).length;

  Future<void> _openReport(BrideHealthReport report) async {
    final updated = await Navigator.of(context).push<BrideHealthReport>(
      MaterialPageRoute(
        builder: (_) => BrideReportDetailScreen(report: report),
      ),
    );
    if (updated != null && mounted) {
      setState(() {
        final i = _reports.indexWhere((r) => r.id == updated.id);
        if (i != -1) _reports[i] = updated;
      });
    }
  }

  Future<void> _openAllReports() async {
    final updated = await Navigator.of(context).push<List<BrideHealthReport>>(
      MaterialPageRoute(
        builder: (_) => BrideAllReportsScreen(reports: _reports),
      ),
    );
    if (updated != null && mounted) {
      setState(() => _reports = List.of(updated));
    }
  }

  void _showMetricDetail(_Metric metric) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            24 + MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8DDE2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: metric.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(metric.icon, color: metric.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          metric.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                        Text(
                          metric.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: metric.badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      metric.badge,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: metric.badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                metric.detail,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4A3A42),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 12),
              ...metric.tips.map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: AppColors.magenta,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Upload from camera/gallery coming soon. Sample report added.'),
      ),
    );
    setState(() {
      _reports.insert(
        0,
        BrideHealthReport(
          id: 'new_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Vitamin D',
          value: '28 ng/mL',
          unitNote: 'Optimal range usually 30–50 ng/mL',
          status: BrideReportStatus.attention,
          icon: Icons.wb_sunny_outlined,
          dateLabel: 'Today',
          summary:
              'Slightly below optimal. Add sunlight and discuss supplements with your doctor.',
          recommendations: const [
            'Get 10–15 minutes of morning sunlight when possible.',
            'Include eggs, fortified milk, and fatty fish.',
            'Recheck levels after doctor-guided supplementation.',
          ],
        ),
      );
    });
  }

  List<_Metric> get _metrics {
    final week = _periodIndex == 0;
    return [
      _Metric(
        icon: Icons.monitor_weight_outlined,
        color: AppColors.magenta,
        title: 'Weight',
        value: week ? '65 kg' : '65.8 kg avg',
        badge: week ? '- 1.5 kg' : '- 2.1 kg',
        badgeColor: AppColors.magenta,
        detail:
            'Your weight trend is steady for bridal wellness. Focus on strength and energy, not crash diets.',
        tips: UserPreferences.instance.isDesi
            ? const [
                'Prefer home-cooked roti + sabzi over fried snacks.',
                'Track weekly, not daily, for a calmer mindset.',
              ]
            : const [
                'Prefer balanced plates over restrictive crash diets.',
                'Track weekly, not daily, for a calmer mindset.',
              ],
      ),
      _Metric(
        icon: Icons.local_drink_rounded,
        color: const Color(0xFF5BA8D9),
        title: 'Water Intake',
        value: week ? '6 / 8 glasses' : '7 / 8 avg',
        badge: 'Good',
        badgeColor: const Color(0xFF4CAF7A),
        detail:
            'Hydration supports glow, digestion, and energy through wedding prep.',
        tips: const [
          'Keep a bottle nearby and sip every 1–2 hours.',
          'Add lemon or mint if plain water feels boring.',
        ],
      ),
      _Metric(
        icon: Icons.directions_walk_rounded,
        color: const Color(0xFF66BB6A),
        title: 'Steps',
        value: week ? '5,320 steps' : '6,100 avg',
        badge: 'Improving',
        badgeColor: const Color(0xFFE07A4A),
        detail:
            'Movement improves mood and sleep. Aim for a gentle daily walk streak.',
        tips: const [
          'Split walks into 2×15 minutes on busy days.',
          'Invite a friend for accountability.',
        ],
      ),
      _Metric(
        icon: Icons.bedtime_outlined,
        color: const Color(0xFF7E57C2),
        title: 'Sleep',
        value: week ? '7.2 hrs' : '6.9 hrs avg',
        badge: week ? 'Good' : 'Fair',
        badgeColor: week ? const Color(0xFF4CAF7A) : const Color(0xFFE07A4A),
        detail:
            'Protect sleep during wedding planning — rest is part of your bridal plan.',
        tips: const [
          'Keep screens away 30 minutes before bed.',
          'Try a short breathing exercise if your mind is racing.',
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scorePct = (_wellnessScore * 100).round();
    final habitsFollowed = _periodIndex == 0 ? 8 : 34;
    final habitsTotal = _periodIndex == 0 ? 12 : 48;

    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF5F7),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _addReport,
            backgroundColor: AppColors.magenta,
            icon: const Icon(Icons.upload_file_rounded, color: Colors.white),
            label: const Text(
              'Add report',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
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
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0E4EA),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          _PeriodChip(
                            label: 'Week',
                            selected: _periodIndex == 0,
                            onTap: () => setState(() => _periodIndex = 0),
                          ),
                          _PeriodChip(
                            label: 'Month',
                            selected: _periodIndex == 1,
                            onTap: () => setState(() => _periodIndex = 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  UserPreferences.instance.isDesi
                      ? 'Track tests, habits, and bridal wellness in one place.'
                      : 'Track screenings, habits, and bridal wellness in one place.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Health Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _OverviewCircleCard(
                        title: 'Wellness Score',
                        center: '$scorePct%',
                        subtitle: scorePct >= 75
                            ? 'Good'
                            : scorePct >= 50
                                ? 'Fair'
                                : 'Focus',
                        subtitleColor: scorePct >= 75
                            ? const Color(0xFF4CAF7A)
                            : const Color(0xFFE07A4A),
                        progress: _wellnessScore.clamp(0.05, 1),
                        color: AppColors.magenta,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _OverviewCircleCard(
                        title: 'Tests Completed',
                        center: '$_testsDone/${_reports.length}',
                        progress: _reports.isEmpty
                            ? 0
                            : _testsDone / _reports.length,
                        color: AppColors.magenta,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _OverviewCircleCard(
                        title: 'Habits Followed',
                        center: '$habitsFollowed/$habitsTotal',
                        progress: habitsFollowed / habitsTotal,
                        color: const Color(0xFFE07A4A),
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
                for (final metric in _metrics)
                  _ProgressMetricTile(
                    metric: metric,
                    onTap: () => _showMetricDetail(metric),
                  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Reports & Tests',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _openAllReports,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.magenta,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View all',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                      for (var i = 0;
                          i < _reports.take(5).length;
                          i++) ...[
                        _ReportTile(
                          report: _reports[i],
                          onTap: () => _openReport(_reports[i]),
                        ),
                        if (i < _reports.take(5).length - 1)
                          const Divider(
                            height: 1,
                            indent: 62,
                            color: Color(0xFFF3E8ED),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Metric {
  const _Metric({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.badge,
    required this.badgeColor,
    required this.detail,
    required this.tips,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String badge;
  final Color badgeColor;
  final String detail;
  final List<String> tips;
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.magenta : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF6A5A62),
          ),
        ),
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
  const _ProgressMetricTile({required this.metric, required this.onTap});

  final _Metric metric;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
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
                  color: metric.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(metric.icon, color: metric.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      metric.value,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: metric.badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  metric.badge,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: metric.badgeColor,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, color: AppColors.skipGrey),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({required this.report, required this.onTap});

  final BrideHealthReport report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
              child: Icon(report.icon, color: AppColors.magenta, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    report.value,
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
                color: report.status.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                report.status.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: report.status.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
