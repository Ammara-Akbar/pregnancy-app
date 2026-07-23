import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../models/health_checkup_models.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';

class AiReportScreen extends StatelessWidget {
  const AiReportScreen({super.key});

  Color _color(HealthSeverity s) => switch (s) {
        HealthSeverity.normal => HealthCheckupColors.green,
        HealthSeverity.caution => HealthCheckupColors.yellow,
        HealthSeverity.critical => HealthCheckupColors.red,
      };

  Color _bg(HealthSeverity s) => switch (s) {
        HealthSeverity.normal => HealthCheckupColors.greenSoft,
        HealthSeverity.caution => HealthCheckupColors.yellowSoft,
        HealthSeverity.critical => HealthCheckupColors.redSoft,
      };

  @override
  Widget build(BuildContext context) {
    final findings = context.watch<HealthCheckupProvider>().findings;

    return HealthCheckupScaffold(
      title: 'AI Report Explanation',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: const Row(
              children: [
                Icon(Icons.auto_awesome_rounded,
                    color: HealthCheckupColors.softPink),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Color-coded insights from your uploaded labs. '
                    'This is guidance — not a diagnosis.',
                    style: TextStyle(
                      height: 1.35,
                      color: HealthCheckupColors.muted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...findings.map((f) {
            final c = _color(f.severity);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PremiumCard(
                color: _bg(f.severity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          f.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: HealthCheckupColors.navy,
                          ),
                        ),
                        const Spacer(),
                        StatusChip(label: f.status, color: c),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Recommendation',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: HealthCheckupColors.navy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      f.recommendation,
                      style: const TextStyle(
                        height: 1.4,
                        color: HealthCheckupColors.navy,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
