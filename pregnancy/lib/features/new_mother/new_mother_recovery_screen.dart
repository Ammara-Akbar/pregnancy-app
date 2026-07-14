import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NewMotherRecoveryScreen extends StatefulWidget {
  const NewMotherRecoveryScreen({
    super.key,
    required this.daysPostpartum,
    this.onBack,
  });

  final int daysPostpartum;
  final VoidCallback? onBack;

  @override
  State<NewMotherRecoveryScreen> createState() =>
      _NewMotherRecoveryScreenState();
}

class _NewMotherRecoveryScreenState extends State<NewMotherRecoveryScreen> {
  int _moodIndex = -1;

  late final List<_FocusItem> _focus = [
    _FocusItem(
      Icons.luggage_outlined,
      'Rest & Relax',
      'Take short breaks when baby sleeps',
      AppColors.magenta,
      true,
    ),
    _FocusItem(
      Icons.eco_rounded,
      'Nutrition',
      'Eat balanced meals',
      const Color(0xFF4CAF7A),
      true,
    ),
    _FocusItem(
      Icons.local_drink_rounded,
      'Hydration',
      'Drink plenty of water',
      const Color(0xFF5BA8D9),
      true,
    ),
    _FocusItem(
      Icons.self_improvement_rounded,
      'Pelvic Floor Exercises',
      '2 of 3 sets completed',
      const Color(0xFF8B6BA8),
      false,
      progress: 2 / 3,
    ),
    _FocusItem(
      Icons.spa_outlined,
      'Mindful Moment',
      '5 min deep breathing',
      const Color(0xFF8B6BA8),
      false,
    ),
  ];

  static const _moods = [
    (Icons.sentiment_very_satisfied_rounded, 'Great', Color(0xFF4CAF7A)),
    (Icons.sentiment_satisfied_alt_rounded, 'Good', Color(0xFFFFCA28)),
    (Icons.sentiment_neutral_rounded, 'Okay', Color(0xFFFFA726)),
    (Icons.sentiment_dissatisfied_rounded, 'Tired', Color(0xFFFF8A65)),
    (Icons.sentiment_very_dissatisfied_rounded, 'Overwhelmed', Color(0xFFEF5350)),
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
                'My Recovery',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF2C3A55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
                      const Text(
                        'Recovery Progress',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${widget.daysPostpartum} Days Postpartum',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '20%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.magenta,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                          value: 0.2,
                          minHeight: 8,
                          backgroundColor: Color(0xFFF0C8D8),
                          color: AppColors.magenta,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Keep going, you're doing great!",
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/journey_new_mother.png',
                    width: 72,
                    height: 84,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "Today's Focus",
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
                for (var i = 0; i < _focus.length; i++) ...[
                  InkWell(
                    onTap: () {
                      setState(() => _focus[i].done = !_focus[i].done);
                    },
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
                              color: _focus[i].color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _focus[i].icon,
                              color: _focus[i].color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _focus[i].title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3A55),
                                  ),
                                ),
                                Text(
                                  _focus[i].subtitle,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_focus[i].progress != null)
                            SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                value: _focus[i].progress,
                                strokeWidth: 3,
                                backgroundColor: AppColors.ringPink,
                                color: AppColors.magenta,
                              ),
                            )
                          else
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _focus[i].done
                                    ? AppColors.magenta
                                    : Colors.transparent,
                                border: Border.all(
                                  color: _focus[i].done
                                      ? AppColors.magenta
                                      : AppColors.ringPink,
                                  width: 2,
                                ),
                              ),
                              child: _focus[i].done
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
                  if (i < _focus.length - 1)
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
            'How are you feeling today?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < _moods.length; i++)
                GestureDetector(
                  onTap: () => setState(() => _moodIndex = i),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _moods[i].$3.withValues(
                            alpha: _moodIndex == i ? 0.22 : 0.1,
                          ),
                          border: Border.all(
                            color: _moodIndex == i
                                ? _moods[i].$3
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(_moods[i].$1, color: _moods[i].$3, size: 26),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _moods[i].$2,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: _moodIndex == i
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _moodIndex == i
                              ? _moods[i].$3
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Postpartum bleeding can last for 2-6 weeks. It\'s normal.',
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
                    'assets/images/journey_new_mother.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
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

class _FocusItem {
  _FocusItem(
    this.icon,
    this.title,
    this.subtitle,
    this.color,
    this.done, {
    this.progress,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  bool done;
  final double? progress;
}
