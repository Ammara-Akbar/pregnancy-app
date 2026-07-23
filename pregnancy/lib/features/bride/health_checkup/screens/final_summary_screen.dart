import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';

class FinalSummaryScreen extends StatelessWidget {
  const FinalSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<HealthCheckupProvider>();

    return HealthCheckupScaffold(
      title: 'Final Summary',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: Column(
              children: [
                const Text(
                  'Congratulations 🎉',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'You completed ${p.completedTests}/${p.totalTests} tests',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HealthCheckupColors.muted,
                  ),
                ),
                const SizedBox(height: 16),
                HealthProgressRing(
                  progress: p.readinessPercent / 100,
                  label: '${p.readinessPercent}%',
                  subtitle: 'Health Readiness',
                  size: 160,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Recommendations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: HealthCheckupColors.navy,
            ),
          ),
          const SizedBox(height: 10),
          const _RecTile(
            icon: Icons.wb_sunny_rounded,
            title: 'Improve Vitamin D',
            detail: 'Add safe sun exposure and discuss supplements.',
          ),
          const _RecTile(
            icon: Icons.directions_walk_rounded,
            title: 'Exercise',
            detail: 'Aim for 30 minutes of movement most days.',
          ),
          const _RecTile(
            icon: Icons.water_drop_rounded,
            title: 'Drink more water',
            detail: 'Target 8+ glasses daily for glow & energy.',
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _toast(context, 'PDF download started'),
                  icon: const Icon(Icons.picture_as_pdf_rounded),
                  label: const Text('Download PDF'),
                  style: FilledButton.styleFrom(
                    backgroundColor: HealthCheckupColors.softPink,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _toast(context, 'Shared with doctor'),
                  icon: const Icon(Icons.share_rounded),
                  label: const Text('Share'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HealthCheckupColors.softPink,
                    side: const BorderSide(color: HealthCheckupColors.softPink),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _RecTile extends StatelessWidget {
  const _RecTile({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: HealthCheckupColors.softPinkLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: HealthCheckupColors.softPink),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: HealthCheckupColors.navy,
                    ),
                  ),
                  Text(
                    detail,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: HealthCheckupColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
