import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = context.watch<HealthCheckupProvider>().doctors;
    final provider = context.read<HealthCheckupProvider>();

    return HealthCheckupScaffold(
      title: 'Doctor Recommendation',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: const Text(
              'Nearby gynecologists for pre-marriage counseling and follow-up.',
              style: TextStyle(height: 1.4, color: HealthCheckupColors.muted),
            ),
          ),
          const SizedBox(height: 14),
          ...doctors.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: HealthCheckupColors.softPinkLight,
                          child: Text(
                            d.name.split(' ').last.substring(0, 1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: HealthCheckupColors.softPink,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: HealthCheckupColors.navy,
                                ),
                              ),
                              Text(
                                d.specialty,
                                style: const TextStyle(
                                  color: HealthCheckupColors.muted,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '${d.distance} · ★ ${d.rating}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: HealthCheckupColors.navy,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => provider.toggleSaveDoctor(d.id),
                          icon: Icon(
                            d.saved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: HealthCheckupColors.softPink,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () => _toast(context, 'Appointment booked'),
                            style: FilledButton.styleFrom(
                              backgroundColor: HealthCheckupColors.softPink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text('Book Appointment'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                _toast(context, 'Teleconsultation started'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: HealthCheckupColors.softPink,
                              side: const BorderSide(
                                color: HealthCheckupColors.softPink,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text('Teleconsult'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
