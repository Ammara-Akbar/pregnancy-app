import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';

class ReadinessScoreScreen extends StatelessWidget {
  const ReadinessScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<HealthCheckupProvider>();
    final label = p.readinessLabel;
    final color = label == 'Excellent'
        ? HealthCheckupColors.green
        : label == 'Good'
            ? HealthCheckupColors.softPink
            : HealthCheckupColors.yellow;

    return HealthCheckupScaffold(
      title: 'Health Readiness Score',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: Column(
              children: [
                HealthProgressRing(
                  progress: p.readinessPercent / 100,
                  label: '${p.readinessPercent}%',
                  size: 180,
                  centerChild: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${p.readinessPercent}%',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: HealthCheckupColors.navy,
                        ),
                      ),
                      StatusChip(label: label, color: color),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Calculated from completed tests, BMI, lifestyle,\n'
                  'vaccinations, history, hydration, exercise & nutrition.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: HealthCheckupColors.muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: HealthCheckupColors.navy,
            ),
          ),
          const SizedBox(height: 10),
          _Factor('Completed tests', p.testProgress),
          _Factor('Lifestyle', p.lifestyle.score / 100),
          _Factor(
            'BMI',
            (p.lifestyle.bmi >= 18.5 && p.lifestyle.bmi <= 24.9) ? 1 : 0.6,
          ),
          _Factor('Hydration', (p.lifestyle.waterGlasses / 8).clamp(0, 1)),
          _Factor('Exercise', p.lifestyle.exercises ? 1 : 0.5),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _Legend(
                  title: 'Excellent',
                  subtitle: '85%+',
                  color: HealthCheckupColors.green,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _Legend(
                  title: 'Good',
                  subtitle: '70–84%',
                  color: HealthCheckupColors.softPink,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _Legend(
                  title: 'Needs Improvement',
                  subtitle: '<70%',
                  color: HealthCheckupColors.yellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Factor extends StatelessWidget {
  const _Factor(this.title, this.value);

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(value * 100).round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.softPink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: HealthCheckupColors.softPinkLight,
                color: HealthCheckupColors.softPink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: HealthCheckupColors.navy,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: HealthCheckupColors.muted),
          ),
        ],
      ),
    );
  }
}
