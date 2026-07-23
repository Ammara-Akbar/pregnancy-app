import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../models/health_checkup_models.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';
import 'ai_report_screen.dart';
import 'category_detail_screen.dart';
import 'doctor_screen.dart';
import 'final_summary_screen.dart';
import 'lifestyle_screen.dart';
import 'readiness_score_screen.dart';
import 'upload_reports_screen.dart';

/// Entry point — wraps feature with Provider.
class BrideHealthCheckupFlow extends StatelessWidget {
  const BrideHealthCheckupFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HealthCheckupProvider()..simulateLoad(),
      child: const HealthCheckupDashboardScreen(),
    );
  }
}

class HealthCheckupDashboardScreen extends StatelessWidget {
  const HealthCheckupDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HealthCheckupProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return HealthCheckupScaffold(
      title: 'Pre-Marriage Health',
      actions: [
        IconButton(
          tooltip: 'Readiness score',
          onPressed: () => _push(context, const ReadinessScoreScreen()),
          icon: const Icon(Icons.insights_rounded),
        ),
      ],
      body: provider.loading
          ? ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                ShimmerBox(height: 180),
                SizedBox(height: 14),
                ShimmerBox(),
                SizedBox(height: 14),
                ShimmerBox(),
                SizedBox(height: 14),
                ShimmerBox(),
              ],
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              children: [
                PremiumCard(
                  gradient: HealthCheckupColors.cardGradient,
                  child: Column(
                    children: [
                      const Text(
                        'Pre-Marriage Health Check',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: HealthCheckupColors.navy,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Prepare your body for a healthy future pregnancy.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: HealthCheckupColors.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 18),
                      HealthProgressRing(
                        progress: provider.readinessPercent / 100,
                        label: '${provider.readinessPercent}%',
                        subtitle: 'Health Readiness',
                        size: 148,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${provider.completedTests} / ${provider.totalTests} Tests Completed',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: HealthCheckupColors.navy,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            final first = provider.categories.first;
                            _push(
                              context,
                              CategoryDetailScreen(categoryId: first.id),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: HealthCheckupColors.softPink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Continue Assessment',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const SizedBox(height: 12),
                ...provider.categories.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CategoryCard(
                      category: c,
                      onTap: () => _push(
                        context,
                        CategoryDetailScreen(categoryId: c.id),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'More',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const SizedBox(height: 12),
                _QuickLink(
                  icon: Icons.upload_file_rounded,
                  title: 'Upload Medical Reports',
                  onTap: () => _push(context, const UploadReportsScreen()),
                ),
                _QuickLink(
                  icon: Icons.auto_awesome_rounded,
                  title: 'AI Report Explanation',
                  onTap: () => _push(context, const AiReportScreen()),
                ),
                _QuickLink(
                  icon: Icons.self_improvement_rounded,
                  title: 'Lifestyle Assessment',
                  onTap: () => _push(context, const LifestyleScreen()),
                ),
                _QuickLink(
                  icon: Icons.local_hospital_rounded,
                  title: 'Doctor Recommendation',
                  onTap: () => _push(context, const DoctorScreen()),
                ),
                _QuickLink(
                  icon: Icons.emoji_events_rounded,
                  title: 'Final Summary',
                  onTap: () => _push(context, const FinalSummaryScreen()),
                  color: isDark ? null : HealthCheckupColors.softPinkLight,
                ),
              ],
            ),
    );
  }

  void _push(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});

  final HealthCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = category.completedCount == category.totalCount
        ? HealthCheckupColors.green
        : category.completedCount == 0
            ? HealthCheckupColors.muted
            : HealthCheckupColors.softPink;

    return PremiumCard(
      onTap: onTap,
      child: Row(
        children: [
          Hero(
            tag: 'cat_${category.id.name}',
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: category.accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(category.icon, color: category.accent, size: 26),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: HealthCheckupColors.navy,
                        ),
                      ),
                    ),
                    if (category.optional)
                      const StatusChip(
                        label: 'Optional',
                        color: Color(0xFF5BA8D9),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  category.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: HealthCheckupColors.muted,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: category.progress,
                    minHeight: 7,
                    backgroundColor: HealthCheckupColors.softPinkLight,
                    color: category.accent,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${category.completedCount}/${category.totalCount}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: HealthCheckupColors.navy,
                      ),
                    ),
                    const Spacer(),
                    StatusChip(
                      label: category.statusLabel,
                      color: statusColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.chevron_right_rounded,
            color: HealthCheckupColors.muted,
          ),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        color: color,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: HealthCheckupColors.softPink),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: HealthCheckupColors.navy,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: HealthCheckupColors.muted),
          ],
        ),
      ),
    );
  }
}

/// Compact home/tools card entry.
class PreMarriageHealthHomeCard extends StatelessWidget {
  const PreMarriageHealthHomeCard({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      gradient: HealthCheckupColors.cardGradient,
      onTap: onContinue,
      child: Row(
        children: [
          const HealthProgressRing(
            progress: 0.78,
            label: '78%',
            subtitle: 'Readiness',
            size: 86,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pre-Marriage Health Check',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Prepare your body for a healthy future pregnancy.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: HealthCheckupColors.muted,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '8 / 10 Tests Completed',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: HealthCheckupColors.softPinkDark,
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: onContinue,
                  style: FilledButton.styleFrom(
                    backgroundColor: HealthCheckupColors.softPink,
                    foregroundColor: Colors.white,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue Assessment',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
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
