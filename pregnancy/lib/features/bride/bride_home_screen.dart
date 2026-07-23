import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_articles_screen.dart';
import 'bride_diet_nutrition_screen.dart';
import 'bride_today_tasks_screen.dart';
import 'bride_plan_task.dart';
import 'bride_wellness_screen.dart';

class BrideHomeScreen extends StatefulWidget {
  const BrideHomeScreen({super.key, required this.userName});

  final String userName;

  @override
  State<BrideHomeScreen> createState() => _BrideHomeScreenState();
}

class _BrideHomeScreenState extends State<BrideHomeScreen> {
  late final List<_PlanTask> _tasks = [
    _PlanTask(
      title: 'Drink 8 glasses of water',
      subtitle: '6 / 8 completed',
      icon: Icons.local_drink_rounded,
      color: AppColors.magenta,
      progress: 0.75,
      done: false,
    ),
    _PlanTask(
      title: '15 mins Morning Yoga',
      subtitle: 'Pending',
      icon: Icons.self_improvement_rounded,
      color: const Color(0xFF8B6BA8),
      done: false,
    ),
    _PlanTask(
      title: 'Eat healthy & balanced meals',
      subtitle: 'Completed',
      icon: Icons.rice_bowl_rounded,
      color: const Color(0xFF4CAF7A),
      done: true,
    ),
    _PlanTask(
      title: 'Journal your thoughts',
      subtitle: 'Pending',
      icon: Icons.menu_book_rounded,
      color: const Color(0xFFE07A4A),
      done: false,
    ),
  ];

  late DateTime _milestoneAt;
  Timer? _timer;
  Duration _remaining = Duration.zero;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  String get _displayName {
    final name = widget.userName.trim();
    if (name.contains(' ')) return name;
    return '$name Khan';
  }

  @override
  void initState() {
    super.initState();
    _milestoneAt = DateTime.now().add(
      const Duration(days: 32, hours: 14, minutes: 48, seconds: 20),
    );
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final remaining = _milestoneAt.difference(DateTime.now());
    if (!mounted) return;
    setState(() {
      _remaining = remaining.isNegative ? Duration.zero : remaining;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _openTodayPlan() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BrideTodayTasksScreen(
          tasks: BridePlanTask.defaults,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          _Header(
            greeting: _greeting,
            name: _displayName,
          ),
          const SizedBox(height: 16),
          const _PromoBanner(),
          const SizedBox(height: 14),
          const _StatsRow(),
          const SizedBox(height: 20),
          _SectionTitle(
            title: "Today's Plan",
            action: 'View all',
            onAction: _openTodayPlan,
          ),
          const SizedBox(height: 10),
          _TodayPlanCard(
            tasks: _tasks,
            onToggle: (index) {
              setState(() {
                final task = _tasks[index];
                task.done = !task.done;
                if (task.done) {
                  task.subtitle = 'Completed';
                  task.progress = 1;
                } else if (task.title.contains('water')) {
                  task.subtitle = '6 / 8 completed';
                  task.progress = 0.75;
                } else {
                  task.subtitle = 'Pending';
                  task.progress = null;
                }
              });
            },
          ),
          const SizedBox(height: 16),
          _MilestoneTipCarousel(remaining: _remaining),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'Explore For You',
            action: 'View all',
            onAction: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BrideWellnessScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _ExploreGrid(
            onTap: (label) {
              if (label == 'Diet Plan') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BrideDietNutritionScreen(),
                  ),
                );
              } else if (label == 'Workout' || label == 'Skincare') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BrideWellnessScreen(),
                  ),
                );
              } else if (label == 'Checklist') {
                _openTodayPlan();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.magenta,
                    content: Text('$label coming soon'),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'Featured For You',
            action: 'View all',
            onAction: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BrideArticlesScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          const _FeaturedRow(),
        ],
      ),
    );
  }
}

class _PlanTask {
  _PlanTask({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.done,
    this.progress,
  });

  final String title;
  String subtitle;
  final IconData icon;
  final Color color;
  bool done;
  double? progress;
}

class _Header extends StatelessWidget {
  const _Header({required this.greeting, required this.name});

  final String greeting;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.magenta,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Bride-to-Be',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.burgundy,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Let's plan your beautiful beginning",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.burgundy,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: const Text(
                  '3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.blush,
          backgroundImage: const AssetImage('assets/images/journey_bride.png'),
          onBackgroundImageError: (exception, stackTrace) {},
        ),
      ],
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      decoration: BoxDecoration(
        color: const Color(0xFFFDE2E8),
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 0,
            bottom: 0,
            width: 168,
            child: Image.asset(
              'assets/images/bride_home_banner.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/journey_bride.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFFDE2E8),
                    const Color(0xFFFDE2E8).withValues(alpha: 0.92),
                    const Color(0xFFFDE2E8).withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.42, 0.62, 0.82],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 22, 140, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A beautiful journey begins with self-love 💗',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D2A32),
                    height: 1.28,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Take care of yourself today for a happier tomorrow.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF8A8490),
                    fontWeight: FontWeight.w500,
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

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatCell(
                icon: Icons.calendar_month_rounded,
                value: '240',
                caption: 'Days to go',
                label: 'To Wedding',
                color: Color(0xFFE91E63),
              ),
            ),
            _StatDivider(),
            Expanded(
              child: _StatCell(
                icon: Icons.assignment_outlined,
                value: '5 / 12',
                caption: 'Tasks Done',
                label: 'This Week',
                color: Color(0xFF9C27B0),
              ),
            ),
            _StatDivider(),
            Expanded(
              child: _StatCell(
                icon: Icons.favorite_border_rounded,
                value: '82%',
                caption: 'Wellness Score',
                label: 'Great!',
                color: Color(0xFFFF9800),
              ),
            ),
            _StatDivider(),
            Expanded(
              child: _StatCell(
                icon: Icons.event_available_rounded,
                value: '3',
                caption: 'Appointments',
                label: 'Upcoming',
                color: Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: const Color(0xFFECE8ED),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.value,
    required this.caption,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String caption;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D2A32),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9A94A0),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.action,
    required this.onAction,
  });

  final String title;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.magenta,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            action,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _TodayPlanCard extends StatelessWidget {
  const _TodayPlanCard({required this.tasks, required this.onToggle});

  final List<_PlanTask> tasks;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        children: [
          for (var i = 0; i < tasks.length; i++) ...[
            InkWell(
              onTap: () => onToggle(i),
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: tasks[i].color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(tasks[i].icon, color: tasks[i].color),
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
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                              decoration: tasks[i].done
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            tasks[i].subtitle,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: tasks[i].color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (tasks[i].progress != null)
                      SizedBox(
                        width: 42,
                        height: 42,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: tasks[i].progress,
                              strokeWidth: 4,
                              backgroundColor: AppColors.ringPink,
                              color: AppColors.magenta,
                            ),
                            Text(
                              '${((tasks[i].progress ?? 0) * 100).round()}%',
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.magenta,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: tasks[i].done
                              ? tasks[i].color
                              : Colors.transparent,
                          border: Border.all(
                            color: tasks[i].done
                                ? tasks[i].color
                                : AppColors.skipGrey,
                            width: tasks[i].done ? 0 : 1.6,
                          ),
                        ),
                        child: tasks[i].done
                            ? const Icon(
                                Icons.check_rounded,
                                size: 14,
                                color: AppColors.white,
                              )
                            : null,
                      ),
                  ],
                ),
              ),
            ),
            if (i < tasks.length - 1)
              const Divider(height: 1, indent: 66, color: Color(0xFFF3E8ED)),
          ],
        ],
      ),
    );
  }
}

class _MilestoneTipCarousel extends StatelessWidget {
  const _MilestoneTipCarousel({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width * 0.72;

    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            width: cardWidth,
            child: _MilestoneCard(remaining: remaining),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: cardWidth,
            child: const _DailyTipCard(),
          ),
        ],
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final mins = remaining.inMinutes % 60;
    final secs = remaining.inSeconds % 60;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8EE),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Next Milestone',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3A2F36),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mehndi Function',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2D2A32),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _TimeBlock(value: '$days', label: 'Days'),
                      const SizedBox(width: 14),
                      _TimeBlock(value: '$hours', label: 'Hours'),
                      const SizedBox(width: 14),
                      _TimeBlock(value: '$mins', label: 'Mins'),
                      const SizedBox(width: 14),
                      _TimeBlock(value: '$secs', label: 'Secs'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6, bottom: 4, top: 8),
            child: Image.asset(
              'assets/images/bride_mehndi_milestone.png',
              width: 108,
              height: 128,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeBlock extends StatelessWidget {
  const _TimeBlock({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFFE91E63),
            height: 1,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF9A8A92),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DailyTipCard extends StatelessWidget {
  const _DailyTipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8EE),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 8, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💡 Daily Tip',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2D2A32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Expanded(
                    child: Text(
                      'Take time for yourself today. A little self-care goes a long way.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: Color(0xFF2D2A32),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BrideArticlesScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE91E63),
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFFE91E63),
                        width: 1.2,
                      ),
                      minimumSize: const Size(0, 30),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4, bottom: 2, top: 6),
            child: Image.asset(
              'assets/images/bride_daily_tip.png',
              width: 108,
              height: 128,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreGrid extends StatelessWidget {
  const _ExploreGrid({required this.onTap});

  final ValueChanged<String> onTap;

  static const _items = [
    (
      'Checklist',
      'assets/images/bride_explore_checklist.png',
      Color(0xFFFCE4EC),
    ),
    (
      'Diet Plan',
      'assets/images/bride_explore_diet.png',
      Color(0xFFE8F5E9),
    ),
    (
      'Workout',
      'assets/images/bride_explore_workout.png',
      Color(0xFFF3E5F5),
    ),
    (
      'Skincare',
      'assets/images/bride_explore_skincare.png',
      Color(0xFFFCE4EC),
    ),
    (
      'Venues',
      'assets/images/bride_explore_venues.png',
      Color(0xFFFFF3E0),
    ),
    (
      'Budget Planner',
      'assets/images/bride_explore_budget.png',
      Color(0xFFF3E5F5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = _items[index];
          return InkWell(
            onTap: () => onTap(item.$1),
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 72,
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: item.$3,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      item.$2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.$1,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3A2F36),
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedRow extends StatelessWidget {
  const _FeaturedRow();

  static const _cards = [
    (
      'Bridal Skincare Guide',
      'Get that natural glow',
      'assets/images/bride_featured_skincare.png',
    ),
    (
      'Stress Management',
      'Stay calm & enjoy the journey',
      'assets/images/bride_featured_stress.png',
    ),
    (
      'Wedding Checklist',
      "Don't miss anything important",
      'assets/images/bride_featured_checklist.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width * 0.72;

    return SizedBox(
      height: 118,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _cards.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final card = _cards[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BrideArticlesScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: cardWidth,
              decoration: BoxDecoration(
                color: const Color(0xFFFDE8EE),
                borderRadius: BorderRadius.circular(18),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.$1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2D2A32),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            card.$2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8A8490),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                    child: Image.asset(
                      card.$3,
                      width: 112,
                      height: 106,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
