import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NewMotherHomeScreen extends StatefulWidget {
  const NewMotherHomeScreen({
    super.key,
    required this.userName,
    required this.daysPostpartum,
  });

  final String userName;
  final int daysPostpartum;

  @override
  State<NewMotherHomeScreen> createState() => _NewMotherHomeScreenState();
}

class _NewMotherHomeScreenState extends State<NewMotherHomeScreen> {
  late final List<_TaskItem> _tasks = [
    _TaskItem('Take your iron tablet', Icons.medication_rounded, true),
    _TaskItem('Drink 8 glasses of water', Icons.local_drink_rounded, true),
    _TaskItem('Log breastfeeding session', Icons.baby_changing_station, true),
    _TaskItem('Eat protein rich food', Icons.restaurant_rounded, true),
    _TaskItem('Do 10 min light walk', Icons.directions_walk_rounded, false),
    _TaskItem('Mood check-in', Icons.sentiment_satisfied_alt_rounded, false),
  ];

  int get _done => _tasks.where((t) => t.done).length;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu_rounded, color: Color(0xFF2C3A55)),
              ),
              const Spacer(),
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFE89AB8), AppColors.magenta],
                  ),
                ),
                child: const Icon(Icons.favorite, color: Colors.white, size: 13),
              ),
              const SizedBox(width: 8),
              const Text(
                'Sehat Maa',
                style: TextStyle(
                  fontSize: 17,
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
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '2',
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
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$_greeting, ${widget.userName} 🌸',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Text(
                'You & Baby Today',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.magenta,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: _ScoreCard(
                  title: 'You\nRecovery Score',
                  value: '78%',
                  label: 'Good',
                  progress: 0.78,
                  color: Color(0xFF4CAF7A),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ScoreCard(
                  title: 'Baby\nHealth Score',
                  value: '92%',
                  label: 'Great',
                  progress: 0.92,
                  color: Color(0xFF4CAF7A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'You are doing an amazing job! 💜 Small steps every day make a big difference.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3A55),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const Spacer(),
              Text(
                '$_done / ${_tasks.length} completed',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
                    onTap: () => setState(() => _tasks[i].done = !_tasks[i].done),
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
                              color: AppColors.blush,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _tasks[i].icon,
                              color: AppColors.magenta,
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
                                  ? AppColors.magenta
                                  : Colors.transparent,
                              border: Border.all(
                                color: _tasks[i].done
                                    ? AppColors.magenta
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
        ],
      ),
    );
  }
}

class _TaskItem {
  _TaskItem(this.title, this.icon, this.done);

  final String title;
  final IconData icon;
  bool done;
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({
    required this.title,
    required this.value,
    required this.label,
    required this.progress,
    required this.color,
  });

  final String title;
  final String value;
  final String label;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3A55),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 78,
            height: 78,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 7,
                  backgroundColor: color.withValues(alpha: 0.15),
                  color: color,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
