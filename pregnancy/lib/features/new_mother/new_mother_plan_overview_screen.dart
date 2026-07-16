import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../subscription/subscription_plan.dart';
import 'new_mother_plan_personalize_screen.dart';

class NewMotherPlanOverviewScreen extends StatelessWidget {
  const NewMotherPlanOverviewScreen({
    super.key,
    this.selectedPlan,
    this.yearly = false,
  });

  final SubscriptionPlan? selectedPlan;
  final bool yearly;

  static const _features = [
    (
      Icons.favorite_rounded,
      'Postpartum Recovery Guide',
      'Physical & emotional recovery tips',
    ),
    (
      Icons.local_drink_outlined,
      'Feeding Tracker',
      'Breastfeeding / formula tracking & reminders',
    ),
    (
      Icons.child_care_rounded,
      'Baby Care Guide',
      'Umbilical care, bathing, sleep & more',
    ),
    (
      Icons.calendar_month_rounded,
      'Vaccine & Checkup Schedule',
      "Timely reminders for your baby's vaccines",
    ),
    (
      Icons.restaurant_rounded,
      "Mother's Nutrition Plan",
      'Recovery diet & hydration guidance',
    ),
    (
      Icons.sentiment_satisfied_alt_rounded,
      'Mood & Mental Health Support',
      'Daily mood check-ins & support',
    ),
    (
      Icons.notifications_active_outlined,
      'Emergency Support',
      'Important signs & when to seek help',
    ),
    (
      Icons.article_outlined,
      'Expert Articles & Tips',
      'Trusted advice for new mothers',
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
                    height: 270 + topInset,
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
                          right: -8,
                          top: topInset + 24,
                          bottom: 24,
                          width: MediaQuery.sizeOf(context).width * 0.48,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/journey_new_mother.png',
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
                                'New Mother\nPlan',
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
                                'Support for you and your baby during the most important first months.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF5A4A52),
                                  height: 1.45,
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
                          builder: (_) => NewMotherPlanPersonalizeScreen(
                            selectedPlan: selectedPlan ??
                                SubscriptionPlan.forJourney('new_mother').first,
                            yearly: yearly,
                          ),
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
                    child: const Text('Continue with New Mother Plan'),
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
