import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_plan_personalize_screen.dart';

class PregnantPlanOverviewScreen extends StatelessWidget {
  const PregnantPlanOverviewScreen({super.key});

  static const _features = [
    (
      Icons.calendar_month_rounded,
      'Weekly Pregnancy Guide',
      "Track your baby's growth week by week",
    ),
    (
      Icons.restaurant_rounded,
      'Diet & Nutrition Plans',
      'Healthy meal plans for every trimester',
    ),
    (
      Icons.medication_rounded,
      'Tablet & Reminder Alerts',
      'Never miss folic acid & supplements',
    ),
    (
      Icons.self_improvement_rounded,
      'Exercise & Yoga',
      'Safe pregnancy exercises for every stage',
    ),
    (
      Icons.fact_check_outlined,
      'Checkup & Test Tracker',
      'Track appointments & pregnancy tests',
    ),
    (
      Icons.health_and_safety_outlined,
      'Danger Signs & Emergency',
      'Know when to seek urgent care',
    ),
    (
      Icons.child_friendly_outlined,
      'Birth Preparation',
      'Get ready for labour & delivery',
    ),
    (
      Icons.favorite_outline,
      'Post-Delivery Support',
      'Care for you and your newborn',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.softPink,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 260 + topInset,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFF5F8),
                                Color(0xFFF8DDE8),
                                Color(0xFFF3C9D8),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: topInset + 8,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -10,
                          top: topInset + 28,
                          bottom: 20,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/journey_pregnant.png',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: MediaQuery.sizeOf(context).width * 0.42,
                          top: topInset + 56,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pregnant\nWomen Plan',
                                style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.magenta,
                                  height: 1.15,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Your complete companion for a healthy pregnancy and a safe delivery.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF5A4A52),
                                  height: 1.45,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Transform.translate(
                    offset: const Offset(0, -24),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "What's included?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                          const SizedBox(height: 18),
                          for (final feature in _features) ...[
                            _FeatureRow(
                              icon: feature.$1,
                              title: feature.$2,
                              subtitle: feature.$3,
                            ),
                            if (feature != _features.last)
                              const SizedBox(height: 16),
                          ],
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.fromLTRB(
              20,
              8,
              20,
              12 + MediaQuery.paddingOf(context).bottom,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PregnantPlanPersonalizeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.magenta,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Continue with Pregnant Plan'),
                  ),
                ),
                const SizedBox(height: 14),
                const _StepDots(activeIndex: 1, count: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE4F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF8B6BA8), size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 9 : 7,
          height: active ? 9 : 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.magenta : AppColors.ringPink,
          ),
        );
      }),
    );
  }
}
