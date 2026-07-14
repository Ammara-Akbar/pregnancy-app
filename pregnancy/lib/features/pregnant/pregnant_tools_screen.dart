import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantToolsScreen extends StatelessWidget {
  const PregnantToolsScreen({super.key});

  static const _essentials = [
    (Icons.directions_walk_rounded, 'Kick Counter', Color(0xFF4CAF7A)),
    (Icons.timer_outlined, 'Contraction Timer', Color(0xFFC24D7F)),
    (Icons.monitor_weight_outlined, 'Weight Tracker', Color(0xFF5BA8D9)),
    (Icons.water_drop_outlined, 'Water Tracker', Color(0xFF42A5F5)),
    (Icons.medical_services_outlined, 'Symptom Checker', Color(0xFF8B6BA8)),
    (Icons.medication_rounded, 'Medicine Reminder', Color(0xFFE07A4A)),
  ];

  static const _guides = [
    (Icons.calendar_month_rounded, 'Pregnancy Week by Week', 'Track baby growth & changes'),
    (Icons.restaurant_rounded, 'Food & Nutrition', 'Safe foods & meal ideas'),
    (Icons.self_improvement_rounded, 'Exercises & Yoga', 'Safe moves for every stage'),
    (Icons.airline_seat_flat, 'Labor & Delivery', 'Prepare for birth day'),
    (Icons.baby_changing_station, 'Breastfeeding Guide', 'Latching & milk tips'),
    (Icons.favorite_outline, 'Baby Care Basics', 'Newborn care essentials'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            children: [
              const Text(
                'Tools',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded, color: Color(0xFF2C3A55)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Daily Essentials',
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
              childAspectRatio: 1.35,
            ),
            itemBuilder: (context, index) {
              final item = _essentials[index];
              return Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                elevation: 0,
                shadowColor: Colors.black12,
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
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: item.$3.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item.$1, color: item.$3, size: 24),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.$2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 22),
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
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Talk to our experts anytime.',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/journey_mother_in_law.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
                'Chat Now',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
