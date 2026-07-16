import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import 'pregnant_trimester_diet.dart';

class PregnantDietScreen extends StatefulWidget {
  const PregnantDietScreen({super.key, required this.weeksPregnant});

  final int weeksPregnant;

  @override
  State<PregnantDietScreen> createState() => _PregnantDietScreenState();
}

class _PregnantDietScreenState extends State<PregnantDietScreen> {
  late int _trimesterIndex =
      PregnantTrimesterDiet.trimesterIndexForWeek(widget.weeksPregnant);

  IconData _chipIcon(int index) {
    switch (index) {
      case 0:
        return Icons.spa_outlined;
      case 1:
        return Icons.favorite_outline;
      default:
        return Icons.child_care_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        final plans = PregnantTrimesterDiet.all();
        final plan = plans[_trimesterIndex.clamp(0, plans.length - 1)];
        final region = UserPreferences.instance.region.shortLabel;
        final currentIndex =
            PregnantTrimesterDiet.trimesterIndexForWeek(widget.weeksPregnant);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$region trimester meal guide',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Week ${widget.weeksPregnant} · ${plans[currentIndex].label}. '
                      'Tap a trimester below to explore meals and tips.',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4A3A42),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (var i = 0; i < plans.length; i++) ...[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _trimesterIndex = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _trimesterIndex == i
                                ? AppColors.magenta
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _trimesterIndex == i
                                  ? AppColors.magenta
                                  : const Color(0xFFF0D6E0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _chipIcon(i),
                                size: 18,
                                color: _trimesterIndex == i
                                    ? AppColors.white
                                    : AppColors.magenta,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                plans[i].label.replaceAll(' Trimester', ''),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _trimesterIndex == i
                                      ? AppColors.white
                                      : const Color(0xFF2C3A55),
                                ),
                              ),
                              Text(
                                plans[i].weekRange
                                    .replaceAll('Weeks ', 'W ')
                                    .replaceAll('–', '-'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _trimesterIndex == i
                                      ? AppColors.white.withValues(alpha: 0.9)
                                      : AppColors.textMuted,
                                ),
                              ),
                              if (i == currentIndex) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _trimesterIndex == i
                                        ? AppColors.white.withValues(alpha: 0.2)
                                        : const Color(0xFFFCE8EF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Yours',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: _trimesterIndex == i
                                          ? AppColors.white
                                          : AppColors.magenta,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (i < plans.length - 1) const SizedBox(width: 8),
                  ],
                ],
              ),
              const SizedBox(height: 18),
              Text(
                plan.focusTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                plan.focusBody,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textMuted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              const _SectionTitle('Key nutrients'),
              const SizedBox(height: 10),
              for (final n in plan.nutrients) _NutrientCard(n),
              const SizedBox(height: 8),
              const _SectionTitle('Sample day meals'),
              const SizedBox(height: 10),
              for (final meal in plan.meals) _MealCard(meal),
              const SizedBox(height: 8),
              const _SectionTitle('Include more of'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final food in plan.includeFoods)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF7F0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        food,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2F6B4F),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              const _SectionTitle('Guidance tips'),
              const SizedBox(height: 10),
              for (final tip in plan.tips) _TipCard(tip),
              const SizedBox(height: 8),
              const _SectionTitle('Limit or avoid'),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F0),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFF5D0CB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in plan.avoidItems) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.close_rounded,
                              size: 16,
                              color: Color(0xFFC45C4A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF5A3A36),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (item != plan.avoidItems.last)
                        const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This guide supports healthy habits. Always follow your doctor or midwife for personal advice.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textMuted.withValues(alpha: 0.9),
                  height: 1.35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2C3A55),
      ),
    );
  }
}

class _NutrientCard extends StatelessWidget {
  const _NutrientCard(this.item);

  final (IconData, String, String) item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
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
            child: Icon(item.$1, color: AppColors.magenta, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.$3,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                    height: 1.3,
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

class _MealCard extends StatelessWidget {
  const _MealCard(this.meal);

  final (IconData, String, String) meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
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
            child: Icon(meal.$1, color: AppColors.magenta),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.$2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  meal.$3,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                    height: 1.3,
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

class _TipCard extends StatelessWidget {
  const _TipCard(this.tip);

  final (String, String) tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tip.$1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.magenta,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tip.$2,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
