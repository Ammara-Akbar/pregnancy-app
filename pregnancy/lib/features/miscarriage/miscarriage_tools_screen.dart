import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MiscarriageToolsScreen extends StatelessWidget {
  const MiscarriageToolsScreen({super.key});

  static const _essentials = [
    (Icons.health_and_safety_outlined, 'Miscarriage\nPrevention', Color(0xFF8B6BA8)),
    (Icons.monitor_heart_outlined, 'Symptoms\nChecker', Color(0xFFC24D7F)),
    (Icons.calendar_month_outlined, 'Cycle\nTracker', Color(0xFFD45A8C)),
    (Icons.egg_outlined, 'Ovulation\nCalculator', Color(0xFFE07A4A)),
    (Icons.medication_rounded, 'Medicine\nReminder', Color(0xFF4CAF7A)),
    (Icons.water_drop_outlined, 'Water\nTracker', Color(0xFF5BA8D9)),
  ];

  static const _guides = [
    (
      Icons.menu_book_rounded,
      'Miscarriage Prevention Guide',
      'Tips to reduce risks and stay healthy',
    ),
    (
      Icons.favorite_outline,
      'Care After Miscarriage',
      'Physical and emotional recovery tips',
    ),
    (
      Icons.restaurant_rounded,
      'Healthy Diet Plan',
      'Foods that support your healing',
    ),
    (
      Icons.self_improvement_rounded,
      'Exercise & Yoga',
      'Safe exercises for recovery',
    ),
    (
      Icons.event_available_outlined,
      'When Can I Try Again?',
      'Know when your body is ready',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tools & Guidance',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Everything you need to take care of yourself',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded, color: Color(0xFF2C3A55)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Essential Tools',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _essentials.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              final item = _essentials[index];
              return Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF0E4EA)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: item.$3.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item.$1, color: item.$3, size: 22),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.$2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3A55),
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Guides & Resources',
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
            child: Column(
              children: [
                for (var i = 0; i < _guides.length; i++) ...[
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.blush,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _guides[i].$1,
                        color: AppColors.magenta,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      _guides[i].$2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    subtitle: Text(
                      _guides[i].$3,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.skipGrey,
                    ),
                    onTap: () {},
                  ),
                  if (i < _guides.length - 1)
                    const Divider(
                      height: 1,
                      indent: 70,
                      color: Color(0xFFF3E8ED),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.ringPink),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Facing heavy bleeding, severe pain or any emergency?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                          height: 1.35,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.health_and_safety_rounded,
                      color: AppColors.magenta,
                      size: 36,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.magenta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Get Help Now',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
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
