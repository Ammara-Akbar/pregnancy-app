import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_diet_screen.dart';
import 'pregnant_trimester_diet.dart';

class PregnantTodaysPlanScreen extends StatefulWidget {
  const PregnantTodaysPlanScreen({
    super.key,
    this.initialTab = 0,
    this.weeksPregnant = 12,
  });

  final int initialTab;
  final int weeksPregnant;

  @override
  State<PregnantTodaysPlanScreen> createState() =>
      _PregnantTodaysPlanScreenState();
}

class _PregnantTodaysPlanScreenState extends State<PregnantTodaysPlanScreen> {
  late int _tab = widget.initialTab.clamp(0, 3);
  final _tabs = const ['Tasks', 'Diet', 'Exercise', 'Tips'];

  late final List<_TaskItem> _tasks = [
    _TaskItem('Take Iron Tablet', Icons.medication_rounded, const Color(0xFF4CAF7A), true),
    _TaskItem('Take Folic Acid', Icons.medication_liquid_rounded, const Color(0xFF4CAF7A), true),
    _TaskItem('Drink 8 glasses of water', Icons.local_drink_rounded, const Color(0xFF5BA8D9), false),
    _TaskItem('30 min walk', Icons.directions_walk_rounded, const Color(0xFF5BA8D9), false),
    _TaskItem('Do breathing exercise', Icons.air_rounded, const Color(0xFF5BA8D9), false),
    _TaskItem("Read today's tip", Icons.menu_book_rounded, const Color(0xFFE07A4A), true),
  ];

  int get _done => _tasks.where((t) => t.done).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(_done),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Today's Plan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  for (var i = 0; i < _tabs.length; i++) ...[
                    GestureDetector(
                      onTap: () => setState(() => _tab = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _tab == i
                              ? const Color(0xFF8B6BA8)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _tab == i
                                ? const Color(0xFF8B6BA8)
                                : AppColors.ringPink,
                          ),
                        ),
                        child: Text(
                          _tabs[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _tab == i
                                ? Colors.white
                                : const Color(0xFF2C3A55),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Tuesday, 18 June 2024',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (_tab == 0) ...[
                    Container(
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
                          const Text(
                            'Day Progress',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$_done / ${_tasks.length} completed',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: _done / _tasks.length,
                              minHeight: 10,
                              backgroundColor: const Color(0xFFEDE4F5),
                              color: const Color(0xFF8B6BA8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your Tasks',
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
                              onTap: () {
                                setState(() => _tasks[i].done = !_tasks[i].done);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: _tasks[i]
                                            .color
                                            .withValues(alpha: 0.12),
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
                                      child: Text(
                                        _tasks[i].title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF2C3A55),
                                          decoration: _tasks[i].done
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _tasks[i].done
                                            ? const Color(0xFF8B6BA8)
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: _tasks[i].done
                                              ? const Color(0xFF8B6BA8)
                                              : AppColors.ringPink,
                                          width: 2,
                                        ),
                                      ),
                                      child: _tasks[i].done
                                          ? const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (i < _tasks.length - 1)
                              const Divider(
                                height: 1,
                                indent: 62,
                                color: Color(0xFFF3E8ED),
                              ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE8EF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "You're doing great! 💜 Consistency today, healthy baby tomorrow.",
                              style: TextStyle(
                                fontSize: 13.5,
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
                              'assets/images/floral_encouragement.png',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (_tab == 1) ...[
                    Builder(
                      builder: (context) {
                        final plan = PregnantTrimesterDiet.forWeek(
                          widget.weeksPregnant,
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${plan.label} meals',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plan.focusTitle,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(height: 12),
                            for (final meal in plan.meals)
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal.$2,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.magenta,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      meal.$3,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textMuted,
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => PregnantDietScreen(
                                      weeksPregnant: widget.weeksPregnant,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('See full trimester diet guide'),
                            ),
                          ],
                        );
                      },
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          '${_tabs[_tab]} content coming soon',
                          style: const TextStyle(color: AppColors.textMuted),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItem {
  _TaskItem(this.title, this.icon, this.color, this.done);

  final String title;
  final IconData icon;
  final Color color;
  bool done;
}
