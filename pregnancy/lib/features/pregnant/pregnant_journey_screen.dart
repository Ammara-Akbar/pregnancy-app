import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_baby_size.dart';

class PregnantJourneyScreen extends StatelessWidget {
  const PregnantJourneyScreen({
    super.key,
    required this.weeksPregnant,
    this.userName = 'Ayesha',
    this.onBack,
  });

  final int weeksPregnant;
  final String userName;
  final VoidCallback? onBack;

  PregnantBabySize get _babySize => PregnantBabySize.forWeek(weeksPregnant);

  String get _trimester {
    if (weeksPregnant <= 13) return '1st Trimester';
    if (weeksPregnant <= 27) return '2nd Trimester';
    return '3rd Trimester';
  }

  int get _trimesterIndex {
    if (weeksPregnant <= 13) return 0;
    if (weeksPregnant <= 27) return 1;
    if (weeksPregnant <= 40) return 2;
    return 3;
  }

  int get _weeksToGo => (40 - weeksPregnant).clamp(0, 40);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            children: [
              const Text(
                'My Journey',
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'You are ',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2C3A55),
                          ),
                          children: [
                            TextSpan(
                              text: '$weeksPregnant weeks pregnant',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.magenta,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.magenta.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _trimester,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.magenta,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Due date: 25 Dec 2024',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        '$_weeksToGo weeks to go!',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: weeksPregnant / 40,
                          minHeight: 7,
                          backgroundColor: const Color(0xFFF0C8D8),
                          color: AppColors.magenta,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 84,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    border: Border.all(color: AppColors.ringPink, width: 2),
                    color: AppColors.white,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    PregnantBabySize.fetusAssetForWeek(weeksPregnant),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Journey Progress',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              Text(
                '$weeksPregnant / 40 weeks',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _TrimesterTimeline(activeIndex: _trimesterIndex),
          const SizedBox(height: 22),
          const Text(
            'Today in Your Journey',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Week $weeksPregnant • Day 3',
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.magenta,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _babySize.blurb,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _babySize.imageAsset,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Upcoming Milestones',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 10),
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
            child: const Column(
              children: [
                _MilestoneTile(
                  week: 'Week 16',
                  title: "Baby's first movements",
                  icon: Icons.child_care_rounded,
                ),
                Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                _MilestoneTile(
                  week: 'Week 20',
                  title: 'Anomaly scan',
                  icon: Icons.health_and_safety_outlined,
                ),
                Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                _MilestoneTile(
                  week: 'Week 24',
                  title: 'Baby is the size of a corn',
                  icon: Icons.eco_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "You're doing great, $userName! Every day brings you closer to meeting your little one.",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3A55),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/pregnant_body_week.png',
                    width: 64,
                    height: 72,
                    fit: BoxFit.cover,
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

class _TrimesterTimeline extends StatelessWidget {
  const _TrimesterTimeline({required this.activeIndex});

  final int activeIndex;

  static const _labels = [
    '1st Trimester',
    '2nd Trimester',
    '3rd Trimester',
    'Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i <= activeIndex
                      ? AppColors.magenta
                      : AppColors.white,
                  border: Border.all(
                    color: i <= activeIndex
                        ? AppColors.magenta
                        : AppColors.ringPink,
                    width: 2,
                  ),
                ),
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: i <= activeIndex
                        ? Colors.white
                        : const Color(0xFF2C3A55),
                  ),
                ),
              ),
              if (i < 3)
                Expanded(
                  child: Container(
                    height: 3,
                    color: i < activeIndex
                        ? AppColors.magenta
                        : AppColors.ringPink,
                  ),
                ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < 4; i++)
              Expanded(
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight:
                        i == activeIndex ? FontWeight.w700 : FontWeight.w500,
                    color: i == activeIndex
                        ? AppColors.magenta
                        : AppColors.textMuted,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  const _MilestoneTile({
    required this.week,
    required this.title,
    required this.icon,
  });

  final String week;
  final String title;
  final IconData icon;

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
                  week,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.magenta,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3A55),
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
