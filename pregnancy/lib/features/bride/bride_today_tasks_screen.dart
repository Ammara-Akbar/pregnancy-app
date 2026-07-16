import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_plan_task.dart';
import 'bride_task_detail_screen.dart';

class BrideTodayTasksScreen extends StatefulWidget {
  const BrideTodayTasksScreen({super.key, required this.tasks});

  final List<BridePlanTask> tasks;

  @override
  State<BrideTodayTasksScreen> createState() => _BrideTodayTasksScreenState();
}

class _BrideTodayTasksScreenState extends State<BrideTodayTasksScreen> {
  late final List<BridePlanTask> _tasks = List.of(widget.tasks);

  int get _doneCount => _tasks.where((t) => t.done).length;

  Future<void> _openDetail(BridePlanTask task) async {
    final result = await Navigator.of(context).push<BridePlanTask>(
      MaterialPageRoute(builder: (_) => BrideTaskDetailScreen(task: task)),
    );
    if (result != null && mounted) {
      setState(() {
        final i = _tasks.indexWhere((t) => t.id == result.id);
        if (i != -1) _tasks[i] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(_tasks),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'Today you will',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
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
                        'Your day at a glance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$_doneCount of ${_tasks.length} tasks completed. Tap any task for steps and tips.',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 54,
                  height: 54,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: _tasks.isEmpty
                            ? 0
                            : _doneCount / _tasks.length,
                        strokeWidth: 5,
                        backgroundColor: AppColors.white.withValues(alpha: 0.7),
                        color: AppColors.magenta,
                      ),
                      Text(
                        '${((_tasks.isEmpty ? 0 : _doneCount / _tasks.length) * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final task in _tasks) ...[
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () => _openDetail(task),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: task.color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(task.icon, color: task.color, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2C3A55),
                                decoration: task.done
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              task.subtitle,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              task.duration,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: task.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            final i =
                                _tasks.indexWhere((t) => t.id == task.id);
                            if (i != -1) {
                              _tasks[i] =
                                  _tasks[i].copyWith(done: !task.done);
                            }
                          });
                        },
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: task.done
                                ? AppColors.magenta
                                : Colors.transparent,
                            border: Border.all(
                              color: task.done
                                  ? AppColors.magenta
                                  : AppColors.ringPink,
                              width: 2,
                            ),
                          ),
                          child: task.done
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.skipGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
