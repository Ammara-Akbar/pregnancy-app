import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_plan_personalize_screen.dart';

class BridePlanOverviewScreen extends StatelessWidget {
  const BridePlanOverviewScreen({super.key});

  static const _features = [
    (
      Icons.calendar_month_rounded,
      '90-Day Pre-Marriage Plan',
      'Daily goals, habits & progress tracking',
    ),
    (
      Icons.science_outlined,
      'Health Checkup Guide',
      'Important tests & doctor appointments',
    ),
    (
      Icons.restaurant_rounded,
      'Diet & Nutrition Plans',
      'Desi diet plans to build a healthy body',
    ),
    (
      Icons.self_improvement_rounded,
      'Exercise & Yoga',
      'Easy workouts for energy & fitness',
    ),
    (
      Icons.water_drop_outlined,
      'Period & Hormonal Health',
      'Cycle tracking & hormonal balance',
    ),
    (
      Icons.menu_book_rounded,
      'Expert Articles & Tips',
      'Guidance on health, beauty & wellness',
    ),
    (
      Icons.notifications_active_outlined,
      'Reminders & Motivation',
      'Stay on track with smart reminders',
    ),
    (
      Icons.verified_user_outlined,
      'Privacy First',
      'Your data is 100% private & secure',
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
                    height: 280 + topInset,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        DecoratedBox(
                          decoration: const BoxDecoration(
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
                          right: 0,
                          top: topInset + 20,
                          bottom: 24,
                          width: MediaQuery.sizeOf(context).width * 0.40,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/journey_bride.png',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: MediaQuery.sizeOf(context).width * 0.42,
                          top: topInset + 48,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bride-to-be\nPlan',
                                style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.burgundyDeep,
                                  height: 1.15,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'A complete 90-day plan to prepare your body, mind and health for a happy married life.',
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
                    offset: const Offset(0, -28),
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
                              fontFamily: 'sans-serif',
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
                          const SizedBox(height: 12),
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
              16 + MediaQuery.paddingOf(context).bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const BridePlanPersonalizeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.burgundyDeep,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'sans-serif',
                  ),
                ),
                child: const Text('Continue with Bride-to-be Plan'),
              ),
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
            color: const Color(0xFFFCE8EF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.magenta, size: 22),
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
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  height: 1.35,
                  fontFamily: 'sans-serif',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
