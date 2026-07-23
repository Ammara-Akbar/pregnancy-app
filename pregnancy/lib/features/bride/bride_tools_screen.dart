import 'package:flutter/material.dart';

import 'bride_articles_screen.dart';
import 'bride_diet_nutrition_screen.dart';
import 'bride_today_tasks_screen.dart';
import 'bride_plan_task.dart';
import 'bride_wellness_screen.dart';

class BrideToolsScreen extends StatelessWidget {
  const BrideToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tools',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1C3D),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Everything you need for a healthy and happy you',
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.35,
                        color: Color(0xFF6E6E6E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF1A1C3D),
                  size: 26,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _ToolSection(
            title: 'Health & Wellness',
            items: const [
              _ToolItem(
                'Nutrition Guide',
                'assets/images/bride_tool_nutrition.png',
              ),
              _ToolItem(
                'Workout Plans',
                'assets/images/bride_tool_workout.png',
              ),
              _ToolItem(
                'Health Trackers',
                'assets/images/bride_tool_health.png',
              ),
              _ToolItem(
                'Cycle & Ovulation',
                'assets/images/bride_tool_cycle.png',
              ),
              _ToolItem(
                'Vitamins & Supplements',
                'assets/images/bride_tool_vitamins.png',
              ),
              _ToolItem(
                'Sleep Tracker',
                'assets/images/bride_tool_sleep.png',
              ),
            ],
            onTap: (label) => _openTool(context, label),
          ),
          const SizedBox(height: 22),
          _ToolSection(
            title: 'Beauty & Self Care',
            items: const [
              _ToolItem(
                'Skin Care Guide',
                'assets/images/bride_tool_skincare.png',
              ),
              _ToolItem(
                'Hair Care Tips',
                'assets/images/bride_tool_hair.png',
              ),
              _ToolItem(
                'Glow Tracker',
                'assets/images/bride_tool_glow.png',
              ),
            ],
            onTap: (label) => _openTool(context, label),
          ),
          const SizedBox(height: 22),
          _ToolSection(
            title: 'Planning & Checklists',
            items: const [
              _ToolItem(
                'Wedding Checklist',
                'assets/images/bride_tool_checklist.png',
              ),
              _ToolItem(
                'Diet Planner',
                'assets/images/bride_tool_diet.png',
              ),
              _ToolItem(
                'Budget Planner',
                'assets/images/bride_tool_budget.png',
              ),
            ],
            onTap: (label) => _openTool(context, label),
          ),
          const SizedBox(height: 20),
          const _DailyTipBanner(),
        ],
      ),
    );
  }

  void _openTool(BuildContext context, String label) {
    Widget? page;
    switch (label) {
      case 'Nutrition Guide':
      case 'Diet Planner':
        page = const BrideDietNutritionScreen();
      case 'Workout Plans':
      case 'Skin Care Guide':
      case 'Hair Care Tips':
      case 'Glow Tracker':
      case 'Health Trackers':
      case 'Sleep Tracker':
      case 'Vitamins & Supplements':
      case 'Cycle & Ovulation':
        page = const BrideWellnessScreen();
      case 'Wedding Checklist':
        page = BrideTodayTasksScreen(tasks: BridePlanTask.defaults);
      case 'Budget Planner':
        page = const BrideArticlesScreen();
      default:
        page = const BrideArticlesScreen();
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page!));
  }
}

class _ToolItem {
  const _ToolItem(this.label, this.image);

  final String label;
  final String image;
}

class _ToolSection extends StatelessWidget {
  const _ToolSection({
    required this.title,
    required this.items,
    required this.onTap,
  });

  final String title;
  final List<_ToolItem> items;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1C3D),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.88,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return _ToolCard(
              label: item.label,
              image: item.image,
              onTap: () => onTap(item.label),
            );
          },
        ),
      ],
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.label,
    required this.image,
    required this.onTap,
  });

  final String label;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1C3D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyTipBanner extends StatelessWidget {
  const _DailyTipBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF0F5), Color(0xFFFDE2E8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -4,
            top: 0,
            bottom: 0,
            width: 120,
            child: Image.asset(
              'assets/images/bride_tool_daily_tip.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 14, 118, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFE91E63),
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Daily Tip',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1C3D),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    'Drink plenty of water and eat balanced meals to keep your skin glowing!',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5A5660),
                    ),
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
