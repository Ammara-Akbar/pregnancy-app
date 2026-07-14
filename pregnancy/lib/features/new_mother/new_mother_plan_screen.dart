import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NewMotherPlanScreen extends StatefulWidget {
  const NewMotherPlanScreen({super.key});

  @override
  State<NewMotherPlanScreen> createState() => _NewMotherPlanScreenState();
}

class _NewMotherPlanScreenState extends State<NewMotherPlanScreen> {
  int _selectedDay = 2;

  static const _days = [
    ('Mon', '13'),
    ('Tue', '14'),
    ('Wed', '15'),
    ('Thu', '16'),
    ('Fri', '17'),
    ('Sat', '18'),
    ('Sun', '19'),
  ];

  late final List<_PlanTask> _tasks = [
    _PlanTask(
      Icons.local_drink_rounded,
      const Color(0xFF5BA8D9),
      'Drink 8 glasses of water',
      '8 / 8 glasses',
      true,
    ),
    _PlanTask(
      Icons.restaurant_rounded,
      const Color(0xFF4CAF7A),
      'Eat protein rich breakfast',
      'Completed',
      true,
    ),
    _PlanTask(
      Icons.bedtime_rounded,
      const Color(0xFF8B6BA8),
      'Rest when baby sleeps',
      '2 / 2 naps',
      true,
    ),
    _PlanTask(
      Icons.self_improvement_rounded,
      const Color(0xFF8B6BA8),
      'Pelvic floor exercises',
      '2 / 3 sets',
      false,
    ),
    _PlanTask(
      Icons.wb_sunny_rounded,
      const Color(0xFFE07A4A),
      'Evening walk',
      '15 min',
      false,
    ),
  ];

  static const _otherPlans = [
    (Icons.eco_rounded, 'Nutrition Plan', 'Eat well, heal well', Color(0xFF4CAF7A)),
    (Icons.self_improvement_rounded, 'Fitness Plan', 'Gentle exercises', Color(0xFF8B6BA8)),
    (Icons.spa_rounded, 'Self Care Plan', 'Mind & body care', Color(0xFFC24D7F)),
    (Icons.nightlight_round, 'Sleep Plan', 'Better rest', Color(0xFF5BA8D9)),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text(
            'My Plan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Personalized plan for your recovery and your baby's well-being.",
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 68,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _days.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = index == _selectedDay;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDay = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 52,
                    decoration: BoxDecoration(
                      color: selected ? AppColors.magenta : AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? AppColors.magenta
                            : AppColors.ringPink,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _days[index].$1,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? Colors.white
                                : AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _days[index].$2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: selected
                                ? Colors.white
                                : const Color(0xFF2C3A55),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "Today's Plan",
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
                for (var i = 0; i < _tasks.length; i++) ...[
                  InkWell(
                    onTap: () => setState(() => _tasks[i].done = !_tasks[i].done),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: _tasks[i].color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _tasks[i].icon,
                              color: _tasks[i].color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _tasks[i].title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3A55),
                                  ),
                                ),
                                Text(
                                  _tasks[i].subtitle,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            _tasks[i].done
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: _tasks[i].done
                                ? const Color(0xFF4CAF7A)
                                : AppColors.ringPink,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i < _tasks.length - 1)
                    const Divider(
                      height: 1,
                      indent: 64,
                      color: Color(0xFFF3E8ED),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Other Plans',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _otherPlans.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final item = _otherPlans[index];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFF0E4EA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: item.$4.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item.$1, color: item.$4, size: 22),
                    ),
                    const Spacer(),
                    Text(
                      item.$2,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.$3,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PlanTask {
  _PlanTask(this.icon, this.color, this.title, this.subtitle, this.done);

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  bool done;
}
