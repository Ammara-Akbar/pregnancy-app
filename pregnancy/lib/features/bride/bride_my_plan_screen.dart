import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BrideMyPlanScreen extends StatefulWidget {
  const BrideMyPlanScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<BrideMyPlanScreen> createState() => _BrideMyPlanScreenState();
}

class _BrideMyPlanScreenState extends State<BrideMyPlanScreen> {
  late final List<_CheckItem> _tests = [
    _CheckItem('Hemoglobin (Hb)', true),
    _CheckItem('Thalassemia Screening', true),
    _CheckItem('Blood Group', true),
    _CheckItem('Blood Sugar (FBS)', false),
    _CheckItem('Thyroid (TSH)', false),
    _CheckItem('Vitamin D', true),
    _CheckItem('Ultrasound / Pelvic Exam', false),
    _CheckItem('Rubella Immunity', false),
  ];

  int get _doneCount => _tests.where((t) => t.done).length;

  @override
  Widget build(BuildContext context) {
    final visibleTests = _tests.take(5).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'My Plan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xFF2C3A55),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                _PlanOverviewCard(),
                const SizedBox(height: 22),
                const Text(
                  'Today you will',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 12),
                _ScheduleCard(
                  items: const [
                    (
                      'Eat iron rich foods',
                      Icons.rice_bowl_rounded,
                      Color(0xFFE07A4A),
                    ),
                    (
                      'Take Folic Acid',
                      Icons.medication_rounded,
                      Color(0xFF4CAF7A),
                    ),
                    (
                      '30 min walk',
                      Icons.directions_walk_rounded,
                      Color(0xFF66BB6A),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    const Text(
                      'Pre-Marriage Test Checklist',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$_doneCount / ${_tests.length} completed',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                      for (var i = 0; i < visibleTests.length; i++) ...[
                        InkWell(
                          onTap: () {
                            final realIndex = _tests.indexOf(visibleTests[i]);
                            setState(() {
                              _tests[realIndex].done = !_tests[realIndex].done;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    visibleTests[i].title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2C3A55),
                                    ),
                                  ),
                                ),
                                _CheckCircle(done: visibleTests[i].done),
                              ],
                            ),
                          ),
                        ),
                        if (i < visibleTests.length - 1)
                          const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xFFF3E8ED),
                          ),
                      ],
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: AppColors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      16,
                                      20,
                                      28,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'All Pre-Marriage Tests',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF2C3A55),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        for (final test in _tests)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(test.title)),
                                                _CheckCircle(done: test.done),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.magenta,
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'View all',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _CheckItem {
  _CheckItem(this.title, this.done);

  final String title;
  bool done;
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: done ? AppColors.magenta : Colors.transparent,
        border: Border.all(
          color: done ? AppColors.magenta : AppColors.ringPink,
          width: 2,
        ),
      ),
      child: done
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}

class _PlanOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '90-Day Pre-Marriage Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Day 12 of 90',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.magenta,
                  ),
                ),
                SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: LinearProgressIndicator(
                    value: 0.13,
                    minHeight: 7,
                    backgroundColor: Color(0xFFF0C8D8),
                    color: AppColors.magenta,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/images/plan_calendar_day12.png',
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, color: AppColors.magenta),
                      SizedBox(height: 4),
                      Text(
                        'Day 12',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.magenta,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.items});

  final List<(String, IconData, Color)> items;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          for (var i = 0; i < items.length; i++) ...[
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: items[i].$3.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(items[i].$2, color: items[i].$3, size: 22),
              ),
              title: Text(
                items[i].$1,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3A55),
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.skipGrey,
              ),
              onTap: () {},
            ),
            if (i < items.length - 1)
              const Divider(height: 1, indent: 70, color: Color(0xFFF3E8ED)),
          ],
        ],
      ),
    );
  }
}
