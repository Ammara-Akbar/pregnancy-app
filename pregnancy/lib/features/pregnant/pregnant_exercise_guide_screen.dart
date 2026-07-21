import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _Exercise {
  const _Exercise({
    required this.image,
    required this.name,
    required this.duration,
    required this.benefit,
    required this.steps,
  });

  final String image;
  final String name;
  final String duration;
  final String benefit;
  final List<String> steps;
}

class _TrimesterGuide {
  const _TrimesterGuide({
    required this.label,
    required this.weeks,
    required this.intro,
    required this.exercises,
  });

  final String label;
  final String weeks;
  final String intro;
  final List<_Exercise> exercises;
}

const _guides = [
  _TrimesterGuide(
    label: '1st Trimester',
    weeks: 'Weeks 1–13',
    intro:
        'Your energy may be low, so keep it light and easy. Focus on '
        'building a gentle daily habit — even short sessions count.',
    exercises: [
      _Exercise(
        image: 'assets/images/exercise_walking.png',
        name: 'Brisk Walking',
        duration: '20–30 min · daily',
        benefit: 'Safe, easy cardio that boosts energy and reduces nausea.',
        steps: [
          'Wear supportive shoes and start at a slow pace.',
          'Speed up slightly until you breathe a little faster but can '
              'still hold a conversation.',
          'Slow down for the last 5 minutes to cool off.',
          'Sip water before and after your walk.',
        ],
      ),
      _Exercise(
        image: 'assets/images/exercise_kegel.png',
        name: 'Pelvic Floor Breathing (Kegels)',
        duration: '5 min · daily',
        benefit:
            'Strengthens the muscles that support your bladder and uterus '
            'for pregnancy and birth.',
        steps: [
          'Sit comfortably with a tall, relaxed back.',
          'Breathe in slowly and let your belly soften.',
          'As you breathe out, gently squeeze the muscles you would use '
              'to stop urine flow.',
          'Hold for 3–5 seconds, then fully relax. Repeat 10 times.',
        ],
      ),
    ],
  ),
  _TrimesterGuide(
    label: '2nd Trimester',
    weeks: 'Weeks 14–27',
    intro:
        'Energy usually returns now — a great time to gently build '
        'strength. Avoid exercises lying flat on your back from here on.',
    exercises: [
      _Exercise(
        image: 'assets/images/exercise_catcow.png',
        name: 'Cat-Cow Stretch',
        duration: '5–8 min · daily',
        benefit:
            'Relieves back pain, keeps your spine flexible and makes room '
            'for your growing bump.',
        steps: [
          'Come onto your hands and knees, wrists under shoulders.',
          'Breathe in, lift your head and tailbone, letting your belly '
              'drop gently (cow).',
          'Breathe out, round your back and tuck your chin (cat).',
          'Move slowly with your breath. Repeat 8–10 times.',
        ],
      ),
      _Exercise(
        image: 'assets/images/exercise_leg_lift.png',
        name: 'Side-Lying Leg Lifts',
        duration: '10 min · 3× a week',
        benefit:
            'Strengthens hips and thighs, which supports your changing '
            'posture and balance.',
        steps: [
          'Lie on your left side, propped on your forearm, knees soft.',
          'Straighten your top leg and lift it slowly to hip height.',
          'Lower it back down with control. Do 10–12 lifts.',
          'Roll over gently and repeat on the other side.',
        ],
      ),
    ],
  ),
  _TrimesterGuide(
    label: '3rd Trimester',
    weeks: 'Weeks 28–40',
    intro:
        'Focus on comfort, posture and preparing your body for birth. '
        'Slow down, use support, and rest whenever you need to.',
    exercises: [
      _Exercise(
        image: 'assets/images/exercise_birth_ball.png',
        name: 'Birth Ball Rocking',
        duration: '10–15 min · daily',
        benefit:
            'Eases back and pelvic pressure and can help baby settle into '
            'a good position for birth.',
        steps: [
          'Sit tall on a birth ball with feet flat and wide apart.',
          'Hold a wall or chair for balance if you need it.',
          'Slowly rock your hips side to side, then in gentle circles.',
          'Keep breathing slowly and stop if you feel tired.',
        ],
      ),
      _Exercise(
        image: 'assets/images/exercise_butterfly.png',
        name: 'Butterfly Stretch',
        duration: '5 min · daily',
        benefit:
            'Opens the hips and inner thighs, helping your body prepare '
            'for labor.',
        steps: [
          'Sit on a mat with your back straight — use a wall for support.',
          'Bring the soles of your feet together and let your knees '
              'relax outward.',
          'Hold your feet and breathe slowly for 30–60 seconds.',
          'Never bounce your knees — let gravity do the work.',
        ],
      ),
    ],
  ),
];

class PregnantExerciseGuideScreen extends StatefulWidget {
  const PregnantExerciseGuideScreen({super.key, this.initialTrimester = 0});

  final int initialTrimester;

  @override
  State<PregnantExerciseGuideScreen> createState() =>
      _PregnantExerciseGuideScreenState();
}

class _PregnantExerciseGuideScreenState
    extends State<PregnantExerciseGuideScreen> {
  late int _selected = widget.initialTrimester.clamp(0, 2);

  @override
  Widget build(BuildContext context) {
    final guide = _guides[_selected];
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        title: const Text(
          'Exercise Guide',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: _TrimesterTabs(
                selected: _selected,
                onChanged: (i) => setState(() => _selected = i),
              ),
            ),
            Expanded(
              child: ListView(
                key: ValueKey(_selected),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  _IntroCard(guide: guide),
                  const SizedBox(height: 14),
                  for (final exercise in guide.exercises) ...[
                    _ExerciseCard(exercise: exercise),
                    const SizedBox(height: 14),
                  ],
                  const _ListenToBodyCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrimesterTabs extends StatelessWidget {
  const _TrimesterTabs({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          for (var i = 0; i < _guides.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected == i
                        ? AppColors.magenta
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _guides[i].label,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: selected == i
                              ? AppColors.white
                              : AppColors.burgundy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _guides[i].weeks,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: selected == i
                              ? AppColors.white.withValues(alpha: 0.85)
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.guide});

  final _TrimesterGuide guide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ringPink),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.favorite_rounded,
            color: AppColors.magenta,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              guide.intro,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                fontWeight: FontWeight.w600,
                color: AppColors.burgundy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise});

  final _Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
            child: Image.asset(
              exercise.image,
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        exercise.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ),
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
                        exercise.duration,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  exercise.benefit,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: AppColors.mistPink, height: 1),
                const SizedBox(height: 12),
                const Text(
                  'How to do it',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                for (var i = 0; i < exercise.steps.length; i++) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.magenta,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            exercise.steps[i],
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
                  if (i != exercise.steps.length - 1) const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListenToBodyCard extends StatelessWidget {
  const _ListenToBodyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.tips_and_updates_outlined,
            color: AppColors.magenta,
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Listen to your body: stop if you feel pain, dizziness, '
              'bleeding or contractions, and check with your doctor before '
              'starting any new exercise.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
