import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_exercise_guide_screen.dart';

class _Activity {
  const _Activity({
    required this.icon,
    required this.color,
    required this.title,
    required this.duration,
    required this.description,
    required this.steps,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String duration;
  final String description;
  final List<String> steps;
}

const _activities = [
  _Activity(
    icon: Icons.directions_walk_rounded,
    color: AppColors.iconHealth,
    title: 'Gentle Walk',
    duration: '20–30 min',
    description: 'Boosts energy, mood and circulation.',
    steps: [
      'Wear comfortable shoes and start slowly.',
      'Keep a pace where you can still talk easily.',
      'Finish with a glass of water and a short rest.',
    ],
  ),
  _Activity(
    icon: Icons.self_improvement_rounded,
    color: AppColors.iconBaby,
    title: 'Prenatal Stretch',
    duration: '10–15 min',
    description: 'Eases back pain and releases tension.',
    steps: [
      'Sit tall and roll your shoulders back 5 times.',
      'Stretch your neck gently side to side.',
      'On all fours, slowly arch and round your back (cat-cow).',
    ],
  ),
  _Activity(
    icon: Icons.chair_alt_outlined,
    color: AppColors.iconMedicine,
    title: 'Pelvic Tilts',
    duration: '5 min',
    description: 'Strengthens your core and eases lower back ache.',
    steps: [
      'Stand with your back against a wall, knees soft.',
      'Tilt your pelvis so your lower back touches the wall.',
      'Hold for 4 seconds, release, and repeat 10 times.',
    ],
  ),
  _Activity(
    icon: Icons.pool_rounded,
    color: AppColors.iconCalendar,
    title: 'Swimming or Water Walk',
    duration: '20 min',
    description: 'The water supports your bump — easy on the joints.',
    steps: [
      'Enter the pool slowly and warm up with easy movement.',
      'Swim or walk laps at a relaxed, steady pace.',
      'Stop if you feel tired — comfort comes first.',
    ],
  ),
];

class PregnantGentleMovementScreen extends StatefulWidget {
  const PregnantGentleMovementScreen({super.key, this.weeksPregnant = 12});

  final int weeksPregnant;

  @override
  State<PregnantGentleMovementScreen> createState() =>
      _PregnantGentleMovementScreenState();
}

class _PregnantGentleMovementScreenState
    extends State<PregnantGentleMovementScreen> {
  int? _expanded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        title: const Text(
          'Gentle Movement',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const _HeroCard(),
            const SizedBox(height: 12),
            _ExerciseGuideBanner(
              onTap: () {
                final trimester = widget.weeksPregnant <= 13
                    ? 0
                    : widget.weeksPregnant <= 27
                    ? 1
                    : 2;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PregnantExerciseGuideScreen(
                      initialTrimester: trimester,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Why it helps',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: _BenefitChip(
                    icon: Icons.bolt_rounded,
                    label: 'More\nenergy',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _BenefitChip(
                    icon: Icons.sentiment_satisfied_alt_rounded,
                    label: 'Better\nmood',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _BenefitChip(
                    icon: Icons.bedtime_outlined,
                    label: 'Deeper\nsleep',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _BenefitChip(
                    icon: Icons.healing_outlined,
                    label: 'Less back\npain',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Today's gentle activities",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < _activities.length; i++) ...[
              _ActivityCard(
                activity: _activities[i],
                expanded: _expanded == i,
                onTap: () =>
                    setState(() => _expanded = _expanded == i ? null : i),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 8),
            const _SafetyCard(),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/gentle_movement_hero.png',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Move a little, feel a lot better',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.burgundy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Light daily movement is safe for most pregnancies and helps '
            'your body prepare for birth. Listen to your body and go at '
            'your own pace.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseGuideBanner extends StatelessWidget {
  const _ExerciseGuideBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.magenta, AppColors.burgundyDeep],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trimester Exercise Guide',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Illustrated exercises with steps for every stage',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFFF3D6E2),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitChip extends StatelessWidget {
  const _BenefitChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.magenta, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: AppColors.burgundy,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.activity,
    required this.expanded,
    required this.onTap,
  });

  final _Activity activity;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: expanded ? AppColors.magenta : AppColors.mistPink,
              width: expanded ? 1.4 : 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: activity.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(activity.icon, color: activity.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          activity.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blush,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      activity.duration,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.burgundy,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.skipGrey,
                  ),
                ],
              ),
              if (expanded) ...[
                const SizedBox(height: 12),
                const Divider(color: AppColors.mistPink, height: 1),
                const SizedBox(height: 12),
                for (var i = 0; i < activity.steps.length; i++) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.blush,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.ringPink),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.burgundy,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            activity.steps[i],
                            style: const TextStyle(
                              fontSize: 12.5,
                              height: 1.4,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (i != activity.steps.length - 1) const SizedBox(height: 8),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ringPink),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, color: AppColors.burgundy, size: 20),
              SizedBox(width: 8),
              Text(
                'Stay safe',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.burgundy,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _SafetyRow('Stop if you feel pain, dizziness or short of breath.'),
          SizedBox(height: 6),
          _SafetyRow('Avoid lying flat on your back after the 1st trimester.'),
          SizedBox(height: 6),
          _SafetyRow('Keep water nearby and avoid overheating.'),
          SizedBox(height: 6),
          _SafetyRow('Check with your doctor before starting a new activity.'),
        ],
      ),
    );
  }
}

class _SafetyRow extends StatelessWidget {
  const _SafetyRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.circle, size: 6, color: AppColors.magenta),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              fontWeight: FontWeight.w600,
              color: AppColors.burgundy,
            ),
          ),
        ),
      ],
    );
  }
}
