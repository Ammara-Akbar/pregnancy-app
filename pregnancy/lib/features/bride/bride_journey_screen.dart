import 'dart:math' as math;

import 'package:flutter/material.dart';

class BrideJourneyScreen extends StatelessWidget {
  const BrideJourneyScreen({super.key});

  static const int totalDays = 90;
  static const int currentDay = 25;

  static double get progress => currentDay / totalDays;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'My Journey',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D2A45),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF2D2A45),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FlowerBadge(),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bride-to-Be',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2D2A45),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Preparing for a healthy marriage and a happy future.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: Color(0xFF8A8490),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _ProgressCard(
            day: currentDay,
            totalDays: totalDays,
            percent: percent,
            progress: progress,
          ),
          const SizedBox(height: 22),
          const Text(
            'Journey Phases',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D2A45),
            ),
          ),
          const SizedBox(height: 14),
          const _PhasesTimeline(),
          const SizedBox(height: 18),
          const _MotivationCard(),
        ],
      ),
    );
  }
}

class _FlowerBadge extends StatelessWidget {
  const _FlowerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.local_florist_rounded,
        color: Color(0xFFE91E63),
        size: 26,
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.day,
    required this.totalDays,
    required this.percent,
    required this.progress,
  });

  final int day;
  final int totalDays;
  final int percent;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF5F8), Color(0xFFFDE2E8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D2A45),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Day $day of $totalDays',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B6570),
                  ),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 10,
                    child: Stack(
                      children: [
                        Container(color: const Color(0xFFF3D5DE)),
                        FractionallySizedBox(
                          widthFactor: progress.clamp(0.0, 1.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFF48FB1),
                                  Color(0xFFE91E63),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _ProgressRing(percent: percent, progress: progress),
        ],
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({required this.percent, required this.progress});

  final int percent;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(92, 92),
            painter: _RingPainter(progress: progress),
          ),
          // Decorative flower dots around ring
          ...List.generate(6, (i) {
            final angle = (i / 6) * math.pi * 2 - math.pi / 2;
            final r = 40.0;
            return Transform.translate(
              offset: Offset(math.cos(angle) * r, math.sin(angle) * r),
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8BBD0),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D2A45),
                  height: 1,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Completed',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8A8490),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final track = Paint()
      ..color = const Color(0xFFF3D5DE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFFF48FB1), Color(0xFFE91E63), Color(0xFFF48FB1)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _PhasesTimeline extends StatelessWidget {
  const _PhasesTimeline();

  static const _phases = [
    _PhaseData(
      number: 1,
      title: 'Pre-Wedding Wellness',
      days: 'Days 1 - 30',
      description: 'Build healthy habits and prepare your body & mind.',
      image: 'assets/images/bride_journey_phase1.png',
      active: true,
    ),
    _PhaseData(
      number: 2,
      title: 'Beauty & Glow',
      days: 'Days 31 - 60',
      description: 'Enhance your natural beauty inside and out.',
      image: 'assets/images/bride_journey_phase2.png',
      active: false,
    ),
    _PhaseData(
      number: 3,
      title: 'Emotional Well-being',
      days: 'Days 61 - 75',
      description: 'Stay positive, manage stress and feel your best.',
      image: 'assets/images/bride_journey_phase3.png',
      active: false,
    ),
    _PhaseData(
      number: 4,
      title: 'Pre-Wedding Prep',
      days: 'Days 76 - 90',
      description: 'Final preparation for your big day!',
      image: 'assets/images/bride_journey_phase4.png',
      active: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _phases.length; i++) ...[
          _PhaseRow(
            phase: _phases[i],
            isLast: i == _phases.length - 1,
          ),
        ],
      ],
    );
  }
}

class _PhaseData {
  const _PhaseData({
    required this.number,
    required this.title,
    required this.days,
    required this.description,
    required this.image,
    required this.active,
  });

  final int number;
  final String title;
  final String days;
  final String description;
  final String image;
  final bool active;
}

class _PhaseRow extends StatelessWidget {
  const _PhaseRow({required this.phase, required this.isLast});

  final _PhaseData phase;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: phase.active
                        ? const Color(0xFFE91E63)
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE91E63),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '${phase.number}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: phase.active
                          ? Colors.white
                          : const Color(0xFF2D2A45),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: const Color(0xFFF8BBD0),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
                decoration: BoxDecoration(
                  gradient: phase.active
                      ? const LinearGradient(
                          colors: [Color(0xFFFFF0F5), Color(0xFFFDE2E8)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  color: phase.active ? null : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: phase.active
                        ? const Color(0xFFF8BBD0)
                        : const Color(0xFFF3E8ED),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            phase.title,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF3A2450),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            phase.days,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE91E63),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            phase.description,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.35,
                              color: Color(0xFF7A7480),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        phase.image,
                        width: 78,
                        height: 78,
                        fit: BoxFit.cover,
                      ),
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
}

class _MotivationCard extends StatelessWidget {
  const _MotivationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8EE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.85,
              child: Image.asset(
                'assets/images/bride_journey_floral.png',
                width: 56,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.local_florist_outlined,
                  color: Color(0xFFF48FB1),
                  size: 28,
                ),
              ),
            ),
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.favorite_rounded, color: Color(0xFFE91E63), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 48),
                  child: Text(
                    "Every small step today leads to a beautiful tomorrow. You've got this!",
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3A2F36),
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
}
