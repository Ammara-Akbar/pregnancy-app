import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_diet_screen.dart';
import 'pregnant_exercise_guide_screen.dart';
import 'pregnant_trimester_diet.dart';

class _PlanTask {
  _PlanTask({required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;
  bool done = false;
}

class _DailyExercise {
  const _DailyExercise({
    required this.name,
    required this.image,
    required this.duration,
    required this.benefit,
    required this.steps,
  });

  final String name;
  final String image;
  final String duration;
  final String benefit;
  final List<String> steps;
}

class _DailyTip {
  const _DailyTip({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;
}

class _TrimesterPlan {
  const _TrimesterPlan({
    required this.label,
    required this.focus,
    required this.tasks,
    required this.exercises,
    required this.tips,
  });

  final String label;
  final String focus;
  final List<({String title, String subtitle, IconData icon})> tasks;
  final List<_DailyExercise> exercises;
  final List<_DailyTip> tips;
}

const _trimesterPlans = [
  _TrimesterPlan(
    label: '1st Trimester',
    focus: 'Rest, nourish your body and build gentle daily habits.',
    tasks: [
      (
        title: 'Take prescribed prenatal vitamins',
        subtitle: 'Take them with food if they make you feel nauseous.',
        icon: Icons.medication_rounded,
      ),
      (
        title: 'Drink 8–10 glasses of water',
        subtitle: 'Small, regular sips can be easier during nausea.',
        icon: Icons.water_drop_outlined,
      ),
      (
        title: 'Eat a small nourishing snack',
        subtitle: 'Try fruit, yogurt, nuts or whole-grain toast.',
        icon: Icons.apple_rounded,
      ),
      (
        title: 'Take a gentle 20-minute walk',
        subtitle: 'Slow down whenever your body asks for rest.',
        icon: Icons.directions_walk_rounded,
      ),
      (
        title: 'Practice pelvic floor breathing',
        subtitle: 'Complete 10 gentle contractions with full relaxation.',
        icon: Icons.air_rounded,
      ),
      (
        title: 'Plan an early bedtime',
        subtitle: 'Fatigue is common while your body supports early growth.',
        icon: Icons.bedtime_outlined,
      ),
    ],
    exercises: [
      _DailyExercise(
        name: 'Brisk Walking',
        image: 'assets/images/exercise_walking.png',
        duration: '20 min',
        benefit: 'Gentle cardio that can support energy and mood.',
        steps: [
          'Start slowly in supportive shoes.',
          'Walk at a pace where you can still talk comfortably.',
          'Cool down for 3–5 minutes and drink water.',
        ],
      ),
      _DailyExercise(
        name: 'Pelvic Floor Breathing',
        image: 'assets/images/exercise_kegel.png',
        duration: '5 min',
        benefit: 'Builds awareness and support around the pelvic floor.',
        steps: [
          'Sit tall and relax your shoulders and belly.',
          'Breathe out and gently lift the pelvic floor.',
          'Hold briefly, fully relax, and repeat 10 times.',
        ],
      ),
    ],
    tips: [
      _DailyTip(
        title: 'Manage morning sickness',
        body:
            'Try small meals every 2–3 hours and keep a plain snack near your bed.',
        icon: Icons.restaurant_rounded,
      ),
      _DailyTip(
        title: 'Protect your energy',
        body:
            'Tiredness is common now. Short rests and an earlier bedtime are useful, not lazy.',
        icon: Icons.bedtime_outlined,
      ),
      _DailyTip(
        title: 'Support early development',
        body:
            'Take folic acid or prenatal supplements exactly as advised by your clinician.',
        icon: Icons.favorite_outline_rounded,
      ),
      _DailyTip(
        title: 'Move gently',
        body:
            'Choose comfortable activity and avoid overheating, breath-holding or pushing through pain.',
        icon: Icons.directions_walk_rounded,
      ),
    ],
  ),
  _TrimesterPlan(
    label: '2nd Trimester',
    focus: 'Build comfortable strength and support your changing posture.',
    tasks: [
      (
        title: 'Take prescribed prenatal vitamins',
        subtitle: 'Follow the dose and timing given by your clinician.',
        icon: Icons.medication_rounded,
      ),
      (
        title: 'Drink 8–10 glasses of water',
        subtitle: 'Drink extra around exercise and in warm weather.',
        icon: Icons.water_drop_outlined,
      ),
      (
        title: 'Choose an iron-rich meal',
        subtitle: 'Pair lentils, greens or meat with vitamin C foods.',
        icon: Icons.restaurant_rounded,
      ),
      (
        title: 'Complete gentle strength movement',
        subtitle: 'Try cat-cow or side-lying leg lifts.',
        icon: Icons.self_improvement_rounded,
      ),
      (
        title: 'Notice your baby’s movement',
        subtitle: 'Begin learning what feels usual for your baby.',
        icon: Icons.child_care_rounded,
      ),
      (
        title: 'Stretch and reset your posture',
        subtitle: 'Relax your shoulders and avoid standing too long.',
        icon: Icons.accessibility_new_rounded,
      ),
    ],
    exercises: [
      _DailyExercise(
        name: 'Cat-Cow Stretch',
        image: 'assets/images/exercise_catcow.png',
        duration: '5–8 min',
        benefit: 'Gently mobilizes the spine and may ease back tension.',
        steps: [
          'Come onto hands and knees with a neutral spine.',
          'Breathe in as you gently lift your chest and tailbone.',
          'Breathe out as you softly round your back. Repeat 8 times.',
        ],
      ),
      _DailyExercise(
        name: 'Side-Lying Leg Lifts',
        image: 'assets/images/exercise_leg_lift.png',
        duration: '10 min',
        benefit: 'Strengthens the hips that support posture and balance.',
        steps: [
          'Lie on your side with your head and bump supported.',
          'Lift the top leg slowly without rolling your hips back.',
          'Lower with control. Repeat 10 times on each side.',
        ],
      ),
    ],
    tips: [
      _DailyTip(
        title: 'Adjust your sleep position',
        body:
            'Side sleeping may feel more comfortable. Use pillows under your bump and between your knees.',
        icon: Icons.bed_outlined,
      ),
      _DailyTip(
        title: 'Support healthy posture',
        body:
            'Keep knees soft, shoulders relaxed and change positions regularly to reduce back strain.',
        icon: Icons.accessibility_new_rounded,
      ),
      _DailyTip(
        title: 'Learn movement patterns',
        body:
            'Your baby’s movements usually become clearer. Notice when they are normally active.',
        icon: Icons.child_care_rounded,
      ),
      _DailyTip(
        title: 'Modify exercise',
        body:
            'Avoid long periods flat on your back. Use side-lying, seated or standing options instead.',
        icon: Icons.self_improvement_rounded,
      ),
    ],
  ),
  _TrimesterPlan(
    label: '3rd Trimester',
    focus: 'Prioritize comfort, birth preparation and your baby’s pattern.',
    tasks: [
      (
        title: 'Take prescribed prenatal vitamins',
        subtitle: 'Continue only the supplements advised for you.',
        icon: Icons.medication_rounded,
      ),
      (
        title: 'Keep water within reach',
        subtitle: 'Drink regularly even when you are less active.',
        icon: Icons.water_drop_outlined,
      ),
      (
        title: 'Count or notice baby movements',
        subtitle: 'Pay attention to your baby’s usual daily pattern.',
        icon: Icons.child_care_rounded,
      ),
      (
        title: 'Practice birth-ball movement',
        subtitle: 'Use a stable ball with support nearby.',
        icon: Icons.sports_gymnastics_rounded,
      ),
      (
        title: 'Practice calm breathing',
        subtitle: 'Slow breathing can help you relax during labor.',
        icon: Icons.air_rounded,
      ),
      (
        title: 'Rest with your feet supported',
        subtitle: 'Take pressure off your back and swollen feet.',
        icon: Icons.chair_alt_outlined,
      ),
    ],
    exercises: [
      _DailyExercise(
        name: 'Birth Ball Rocking',
        image: 'assets/images/exercise_birth_ball.png',
        duration: '10–15 min',
        benefit: 'Encourages comfortable hip movement and upright posture.',
        steps: [
          'Sit tall with both feet wide and firmly on the floor.',
          'Keep a wall or chair nearby for support.',
          'Rock side to side, then make slow circles with your hips.',
        ],
      ),
      _DailyExercise(
        name: 'Butterfly Stretch',
        image: 'assets/images/exercise_butterfly.png',
        duration: '5 min',
        benefit: 'Gently opens the hips and inner thighs.',
        steps: [
          'Sit supported with the soles of your feet together.',
          'Let your knees relax outward without bouncing.',
          'Breathe slowly and hold for 30–60 seconds.',
        ],
      ),
    ],
    tips: [
      _DailyTip(
        title: 'Know your baby’s pattern',
        body:
            'Movements should continue until birth. Contact maternity care promptly if movement is reduced or changed.',
        icon: Icons.monitor_heart_outlined,
      ),
      _DailyTip(
        title: 'Prepare without pressure',
        body:
            'Pack essentials, review your birth preferences and save important contact numbers in small steps.',
        icon: Icons.work_outline_rounded,
      ),
      _DailyTip(
        title: 'Ease swelling',
        body:
            'Rest with feet raised, change position often and stay hydrated. Report sudden swelling or severe headache.',
        icon: Icons.chair_alt_outlined,
      ),
      _DailyTip(
        title: 'Practice labor breathing',
        body:
            'Breathe in gently through your nose and release a longer, relaxed breath through your mouth.',
        icon: Icons.air_rounded,
      ),
    ],
  ),
];

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
  late final List<_PlanTask> _tasks;

  int get _trimesterIndex {
    if (widget.weeksPregnant <= 13) return 0;
    if (widget.weeksPregnant <= 27) return 1;
    return 2;
  }

  _TrimesterPlan get _plan => _trimesterPlans[_trimesterIndex];

  int get _done => _tasks.where((t) => t.done).length;

  @override
  void initState() {
    super.initState();
    _tasks = [
      for (final task in _plan.tasks)
        _PlanTask(title: task.title, subtitle: task.subtitle, icon: task.icon),
    ];
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${weekdays[date.weekday - 1]}, ${date.day} '
        '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(_done),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),
        title: const Text(
          "Today's Plan",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: _PlanHeader(
                week: widget.weeksPregnant,
                label: _plan.label,
                focus: _plan.focus,
                date: _formatDate(DateTime.now()),
                progress: _done / _tasks.length,
                progressLabel: '$_done of ${_tasks.length} tasks complete',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _PlanTabs(
                tabs: _tabs,
                selected: _tab,
                onChanged: (index) => setState(() => _tab = index),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: ListView(
                  key: ValueKey(_tab),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  children: [
                    if (_tab == 0)
                      _TasksTab(
                        tasks: _tasks,
                        onToggle: (index) => setState(
                          () => _tasks[index].done = !_tasks[index].done,
                        ),
                      )
                    else if (_tab == 1)
                      _DietTab(weeksPregnant: widget.weeksPregnant)
                    else if (_tab == 2)
                      _ExerciseTab(
                        exercises: _plan.exercises,
                        trimesterIndex: _trimesterIndex,
                      )
                    else
                      _TipsTab(tips: _plan.tips),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanHeader extends StatelessWidget {
  const _PlanHeader({
    required this.week,
    required this.label,
    required this.focus,
    required this.date,
    required this.progress,
    required this.progressLabel,
  });

  final int week;
  final String label;
  final String focus;
  final String date;
  final double progress;
  final String progressLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.magenta, AppColors.burgundyDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Week $week',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.favorite_rounded,
                color: AppColors.white,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            focus,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              height: 1.35,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.mistPink,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: const TextStyle(
                  color: AppColors.mistPink,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              color: AppColors.white,
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            progressLabel,
            style: const TextStyle(
              color: AppColors.mistPink,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanTabs extends StatelessWidget {
  const _PlanTabs({
    required this.tabs,
    required this.selected,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const icons = [
      Icons.check_circle_outline_rounded,
      Icons.restaurant_outlined,
      Icons.self_improvement_rounded,
      Icons.tips_and_updates_outlined,
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: InkWell(
                onTap: () => onChanged(i),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: selected == i
                        ? AppColors.magenta
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        icons[i],
                        size: 18,
                        color: selected == i
                            ? AppColors.white
                            : AppColors.burgundy,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tabs[i],
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: selected == i
                              ? AppColors.white
                              : AppColors.burgundy,
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

class _TasksTab extends StatelessWidget {
  const _TasksTab({required this.tasks, required this.onToggle});

  final List<_PlanTask> tasks;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          title: 'Your plan for today',
          subtitle: 'Small, comfortable steps are enough.',
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < tasks.length; i++) ...[
          Material(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () => onToggle(i),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: tasks[i].done
                        ? AppColors.ringPink
                        : AppColors.mistPink,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: tasks[i].done
                            ? AppColors.blush
                            : AppColors.softPink,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        tasks[i].icon,
                        color: AppColors.magenta,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasks[i].title,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                              decoration: tasks[i].done
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            tasks[i].subtitle,
                            style: const TextStyle(
                              fontSize: 11.5,
                              height: 1.35,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tasks[i].done
                            ? AppColors.magenta
                            : Colors.transparent,
                        border: Border.all(
                          color: tasks[i].done
                              ? AppColors.magenta
                              : AppColors.ringPink,
                          width: 2,
                        ),
                      ),
                      child: tasks[i].done
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: AppColors.white,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 9),
        ],
        const _EncouragementCard(),
      ],
    );
  }
}

class _DietTab extends StatelessWidget {
  const _DietTab({required this.weeksPregnant});

  final int weeksPregnant;

  @override
  Widget build(BuildContext context) {
    final plan = PregnantTrimesterDiet.forWeek(weeksPregnant);
    const mealIcons = [
      Icons.free_breakfast_outlined,
      Icons.lunch_dining_outlined,
      Icons.dinner_dining_outlined,
      Icons.apple_rounded,
      Icons.local_drink_outlined,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeading(
          title: '${plan.label} meals',
          subtitle: plan.focusTitle,
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < plan.meals.length; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.mistPink),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.blush,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    mealIcons[i % mealIcons.length],
                    color: AppColors.magenta,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.meals[i].$2,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.burgundy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan.meals[i].$3,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    PregnantDietScreen(weeksPregnant: weeksPregnant),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.magenta,
              side: const BorderSide(color: AppColors.ringPink),
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.restaurant_menu_rounded, size: 18),
            label: const Text(
              'Open full trimester diet guide',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExerciseTab extends StatelessWidget {
  const _ExerciseTab({required this.exercises, required this.trimesterIndex});

  final List<_DailyExercise> exercises;
  final int trimesterIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          title: 'Movement for today',
          subtitle: 'Follow each pose slowly and stay within comfort.',
        ),
        const SizedBox(height: 12),
        for (final exercise in exercises) ...[
          _TodayExerciseCard(exercise: exercise),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PregnantExerciseGuideScreen(
                  initialTrimester: trimesterIndex,
                ),
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.magenta,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.fitness_center_rounded, size: 18),
            label: const Text(
              'View full trimester exercise guide',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SafetyNote(),
      ],
    );
  }
}

class _TodayExerciseCard extends StatelessWidget {
  const _TodayExerciseCard({required this.exercise});

  final _DailyExercise exercise;

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
              width: double.infinity,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
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
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blush,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        exercise.duration,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  exercise.benefit,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 11),
                for (var i = 0; i < exercise.steps.length; i++) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: AppColors.magenta,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            exercise.steps[i],
                            style: const TextStyle(
                              color: AppColors.textDark,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (i < exercise.steps.length - 1) const SizedBox(height: 7),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TipsTab extends StatelessWidget {
  const _TipsTab({required this.tips});

  final List<_DailyTip> tips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          title: 'Helpful tips for this stage',
          subtitle: 'Simple guidance matched to your current trimester.',
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < tips.length; i++) ...[
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: i.isEven ? AppColors.white : AppColors.blush,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: AppColors.mistPink),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.softPink,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(tips[i].icon, color: AppColors.magenta, size: 21),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tips[i].title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.burgundy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tips[i].body,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.45,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
        ],
        const _UrgentCareCard(),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            height: 1.35,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _EncouragementCard extends StatelessWidget {
  const _EncouragementCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: const Row(
        children: [
          Icon(Icons.favorite_rounded, color: AppColors.magenta),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Do what feels manageable today. Rest is also part of a healthy plan.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                fontWeight: FontWeight.w700,
                color: AppColors.burgundy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyNote extends StatelessWidget {
  const _SafetyNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ringPink),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: AppColors.burgundy, size: 20),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Stop exercising if you feel pain, dizziness, bleeding, fluid leakage, regular contractions or unusual shortness of breath. Ask your clinician before starting a new routine.',
              style: TextStyle(
                fontSize: 11.5,
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

class _UrgentCareCard extends StatelessWidget {
  const _UrgentCareCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.burgundy,
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.medical_services_outlined, color: AppColors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Contact your maternity team urgently for heavy bleeding, severe pain, fluid leakage, severe headache or reduced baby movement.',
              style: TextStyle(
                fontSize: 12,
                height: 1.45,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
