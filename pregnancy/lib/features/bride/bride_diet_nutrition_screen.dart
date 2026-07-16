import 'package:flutter/material.dart';

import '../../core/content/regional_content.dart';
import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';

class BrideDietNutritionScreen extends StatelessWidget {
  const BrideDietNutritionScreen({super.key});

  IconData _mealIcon(String meal) {
    switch (meal) {
      case 'Breakfast':
        return Icons.wb_sunny_outlined;
      case 'Lunch':
        return Icons.lunch_dining_outlined;
      case 'Evening Snack':
        return Icons.apple;
      default:
        return Icons.nightlife_outlined;
    }
  }

  IconData _tipIcon(String key) {
    switch (key) {
      case 'water':
        return Icons.water_drop_outlined;
      case 'eco':
        return Icons.eco_outlined;
      case 'heart':
        return Icons.favorite_outline;
      default:
        return Icons.no_food_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        final plans = RegionalContent.brideMealPlans();
        final tips = RegionalContent.brideNutritionTips();
        final region = UserPreferences.instance.region;

        return Scaffold(
          backgroundColor: const Color(0xFFFFF5F7),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF5F7),
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF2C3A55),
              ),
            ),
            title: const Text(
              'Diet & Nutrition',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3A55),
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
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
                          Text(
                            '${region.shortLabel} Meal Plan',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            RegionalContent.dietSectionBlurb(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.restaurant_menu_rounded,
                      color: AppColors.magenta,
                      size: 36,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Meal Plans',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 12),
              for (final day in plans) ...[
                _DayMealCard(
                  day: day.day,
                  focus: day.focus,
                  meals: [
                    for (final meal in day.meals)
                      (meal.$1, meal.$2, _mealIcon(meal.$1)),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 10),
              const Text(
                'Nutrition Tips for Brides',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 12),
              for (final tip in tips) ...[
                _TipTile(
                  icon: _tipIcon(tip.$3),
                  title: tip.$1,
                  subtitle: tip.$2,
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _DayMealCard extends StatelessWidget {
  const _DayMealCard({
    required this.day,
    required this.focus,
    required this.meals,
  });

  final String day;
  final String focus;
  final List<(String, String, IconData)> meals;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE8EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  focus,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.magenta,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < meals.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE8EF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    meals[i].$3,
                    size: 18,
                    color: AppColors.magenta,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meals[i].$1,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        meals[i].$2,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (i < meals.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _TipTile extends StatelessWidget {
  const _TipTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                    height: 1.35,
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
