import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _PlanQuestion {
  const _PlanQuestion({
    required this.title,
    required this.icon,
    required this.options,
  });

  final String title;
  final IconData icon;
  final List<String> options;
}

class PregnantBirthPlanScreen extends StatefulWidget {
  const PregnantBirthPlanScreen({super.key});

  @override
  State<PregnantBirthPlanScreen> createState() =>
      _PregnantBirthPlanScreenState();
}

class _PregnantBirthPlanScreenState extends State<PregnantBirthPlanScreen> {
  static const _questions = [
    _PlanQuestion(
      title: 'Birth Environment',
      icon: Icons.light_mode_outlined,
      options: ['Dim lights', 'Soft music', 'Quiet room', 'No preference'],
    ),
    _PlanQuestion(
      title: 'Pain Relief',
      icon: Icons.spa_outlined,
      options: [
        'Epidural',
        'Breathing techniques',
        'Massage',
        'Decide during labor',
      ],
    ),
    _PlanQuestion(
      title: 'During Labor',
      icon: Icons.directions_walk_rounded,
      options: ['Move freely', 'Birthing ball', 'Water birth', 'Rest in bed'],
    ),
    _PlanQuestion(
      title: 'Delivery Moments',
      icon: Icons.favorite_outline_rounded,
      options: [
        'Partner present',
        'Skin-to-skin right away',
        'Partner cuts the cord',
        'Delayed cord clamping',
      ],
    ),
    _PlanQuestion(
      title: 'After Birth',
      icon: Icons.child_care_rounded,
      options: [
        'Breastfeed right away',
        'Formula feeding',
        'Mixed feeding',
        'Decide later',
      ],
    ),
  ];

  final Map<String, String> _choices = {};

  void _save() {
    final missing = _questions.length - _choices.length;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: missing == 0 ? AppColors.magenta : AppColors.textMuted,
        behavior: SnackBarBehavior.floating,
        content: Text(
          missing == 0
              ? 'Birth plan saved! Share it with your care team.'
              : 'Almost there - $missing section${missing == 1 ? '' : 's'} left to choose.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final answered = _choices.length;
    final progress = answered / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Birth Plan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Choose your preferences for the big day',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/birth_plan_hero.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Plan',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '$answered',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.burgundy,
                            ),
                            children: [
                              TextSpan(
                                text: ' of ${_questions.length} chosen',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 9,
                            backgroundColor: AppColors.ringPink,
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.magenta,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          answered == _questions.length
                              ? 'Plan complete - ready to save!'
                              : 'Pick one option in each section',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: answered == _questions.length
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: answered == _questions.length
                                ? AppColors.magenta
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            for (final question in _questions)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.mistPink),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.blush,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            question.icon,
                            size: 19,
                            color: AppColors.magenta,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          question.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const Spacer(),
                        if (_choices.containsKey(question.title))
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 18,
                            color: AppColors.magenta,
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final option in question.options)
                          _OptionChip(
                            label: option,
                            selected: _choices[question.title] == option,
                            onTap: () {
                              setState(() {
                                _choices[question.title] = option;
                              });
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.blush,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 20,
                    color: AppColors.magenta,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tip\nA birth plan is a wish list, not a contract. '
                      'Discuss it with your doctor and stay flexible on the day.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.5,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: FilledButton.icon(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.save_alt_rounded),
                label: const Text(
                  'Save Birth Plan',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.magenta : AppColors.softPink,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.magenta : AppColors.mistPink,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
