import 'package:flutter/material.dart';

import '../../core/content/regional_content.dart';
import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import 'bride_article_detail_screen.dart';
import 'bride_articles_screen.dart';
import 'bride_diet_nutrition_screen.dart';
import 'bride_wellness_screen.dart';

class BrideHomeScreen extends StatefulWidget {
  const BrideHomeScreen({super.key, required this.userName});

  final String userName;

  @override
  State<BrideHomeScreen> createState() => _BrideHomeScreenState();
}

class _BrideHomeScreenState extends State<BrideHomeScreen> {
  late final List<_TaskItem> _tasks = [
    _TaskItem('Take Folic Acid', Icons.medication_rounded, const Color(0xFF4CAF7A), true),
    _TaskItem('Drink 8 glasses of water', Icons.local_drink_rounded, const Color(0xFF5BA8D9), true),
    _TaskItem('30 min walk', Icons.directions_walk_rounded, AppColors.magenta, false),
    _TaskItem('Eat iron rich breakfast', Icons.rice_bowl_rounded, const Color(0xFFE07A4A), false),
    _TaskItem('10 min meditation', Icons.self_improvement_rounded, AppColors.magenta, false),
  ];

  int get _completedCount => _tasks.where((t) => t.done).length;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(),
                  const SizedBox(height: 18),
                  Text(
                    '$_greeting, ${widget.userName} 🌸',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _PlanProgressCard(),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Text(
                        "Today's Tasks",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$_completedCount / ${_tasks.length} completed',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _TasksCard(
                    tasks: _tasks,
                    onToggle: (i) {
                      setState(() => _tasks[i].done = !_tasks[i].done);
                    },
                  ),
                  const SizedBox(height: 16),
                  const _DailyTipCard(),
                  const SizedBox(height: 12),
                  const _WellnessHubCard(),
                  const SizedBox(height: 22),
                  _SectionHeader(
                    title: 'Diet & Nutrition',
                    action: 'See all',
                    onAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BrideDietNutritionScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  const _DietPlanCard(),
                  const SizedBox(height: 22),
                  const _SectionHeader(
                    title: 'Your Progress',
                    action: 'This Week',
                    actionMuted: true,
                  ),
                  const SizedBox(height: 12),
                  const _WeeklyProgressRow(),
                  const SizedBox(height: 22),
                  _SectionHeader(
                    title: 'Articles for You',
                    action: 'See all',
                    onAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BrideArticlesScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  const _ArticleCard(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFE89AB8), AppColors.magenta],
            ),
          ),
          child: const Icon(Icons.favorite, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 8),
        const Text(
          'Sehat Maa',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.magenta,
          ),
        ),
        const Spacer(),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF2C3A55),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlanProgressCard extends StatelessWidget {
  const _PlanProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.magenta.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Pre-Marriage Plan',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "You're doing great! Keep going and build a healthy future.",
                      style: TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  const Text(
                    'Day 12 of 90',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.magenta,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: 0.13,
                          strokeWidth: 7,
                          backgroundColor: AppColors.white.withValues(alpha: 0.7),
                          color: AppColors.magenta,
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '13%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            Text(
                              'Complete',
                              style: TextStyle(
                                fontSize: 9,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.13,
              minHeight: 6,
              backgroundColor: Color(0xFFF0C8D8),
              color: AppColors.magenta,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem {
  _TaskItem(this.title, this.icon, this.iconColor, this.done);

  final String title;
  final IconData icon;
  final Color iconColor;
  bool done;
}

class _TasksCard extends StatelessWidget {
  const _TasksCard({required this.tasks, required this.onToggle});

  final List<_TaskItem> tasks;
  final ValueChanged<int> onToggle;

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
          for (var i = 0; i < tasks.length; i++) ...[
            InkWell(
              onTap: () => onToggle(i),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: tasks[i].iconColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        tasks[i].icon,
                        color: tasks[i].iconColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tasks[i].title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C3A55),
                          decoration: tasks[i].done
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: AppColors.textMuted,
                        ),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
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
            if (i < tasks.length - 1)
              const Divider(height: 1, indent: 62, color: Color(0xFFF3E8ED)),
          ],
        ],
      ),
    );
  }
}

class _DailyTipCard extends StatelessWidget {
  const _DailyTipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
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
                  'Daily Tip',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Start your day with warm water and soaked almonds for glowing skin and better health.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/tip_almonds.png',
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 72,
                height: 72,
                color: AppColors.blush,
                child: const Icon(Icons.eco, color: AppColors.magenta),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.action,
    this.actionMuted = false,
    this.onAction,
  });

  final String title;
  final String action;
  final bool actionMuted;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onAction,
          child: Text(
            action,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: actionMuted ? AppColors.textMuted : AppColors.magenta,
            ),
          ),
        ),
      ],
    );
  }
}

class _DietPlanCard extends StatelessWidget {
  const _DietPlanCard();

  static const _colors = [
    Color(0xFFFFB74D),
    Color(0xFF81C784),
    Color(0xFFFF8A65),
    Color(0xFF64B5F6),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        final meals = RegionalContent.brideHomeMeals();
        return Container(
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
            children: [
              for (var i = 0; i < meals.length; i++) ...[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meals[i].$1,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            meals[i].$2,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _colors[i].withValues(alpha: 0.2),
                      ),
                      child: Icon(
                        Icons.restaurant_rounded,
                        color: _colors[i],
                        size: 22,
                      ),
                    ),
                  ],
                ),
                if (i < meals.length - 1) const SizedBox(height: 14),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _WeeklyProgressRow extends StatelessWidget {
  const _WeeklyProgressRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ProgressMiniCard(
            label: 'Water',
            value: '6 / 8 glasses',
            icon: Icons.local_drink_rounded,
            color: Color(0xFF5BA8D9),
            progress: 6 / 8,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ProgressMiniCard(
            label: 'Walk',
            value: '4 / 7 days',
            icon: Icons.directions_walk_rounded,
            color: Color(0xFF66BB6A),
            progress: 4 / 7,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ProgressMiniCard(
            label: 'Folic Acid',
            value: '7 / 7 days',
            icon: Icons.medication_rounded,
            color: AppColors.magenta,
            progress: 1,
          ),
        ),
      ],
    );
  }
}

class _ProgressMiniCard extends StatelessWidget {
  const _ProgressMiniCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.progress,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: color.withValues(alpha: 0.15),
                  color: color,
                ),
                Icon(icon, color: color, size: 22),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _WellnessHubCard extends StatelessWidget {
  const _WellnessHubCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const BrideWellnessScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF0E4EA)),
          ),
          child: const Row(
            children: [
              Icon(Icons.spa_outlined, color: AppColors.magenta, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bride Wellness Hub',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Fitness, glow care, stress tips & more',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.skipGrey),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard();

  @override
  Widget build(BuildContext context) {
    final article = brideArticles.first;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BrideArticleDetailScreen(article: article),
            ),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.readTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  article.imageAsset,
                  width: 72,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
