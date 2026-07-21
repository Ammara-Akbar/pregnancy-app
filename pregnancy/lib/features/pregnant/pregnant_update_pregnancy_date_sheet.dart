import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';

enum _EditMode { week, dueDate, lastPeriod }

Future<void> showUpdatePregnancyDateSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const _UpdatePregnancyDateSheet(),
  );
}

class _UpdatePregnancyDateSheet extends StatefulWidget {
  const _UpdatePregnancyDateSheet();

  @override
  State<_UpdatePregnancyDateSheet> createState() =>
      _UpdatePregnancyDateSheetState();
}

class _UpdatePregnancyDateSheetState extends State<_UpdatePregnancyDateSheet> {
  late _EditMode _mode = _EditMode.dueDate;
  late int _weeks = UserPreferences.instance.weeksPregnant;
  late DateTime _dueDate = UserPreferences.instance.dueDate;
  late DateTime _lastPeriod =
      UserPreferences.instance.lastPeriodDate ??
      UserPreferences.instance.dueDate.subtract(const Duration(days: 280));

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<DateTime?> _pickDate({
    required DateTime initial,
    required DateTime first,
    required DateTime last,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initial.isBefore(first)
          ? first
          : (initial.isAfter(last) ? last : initial),
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.magenta,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<void> _pickDueDate() async {
    final picked = await _pickDate(
      initial: _dueDate,
      first: DateTime.now(),
      last: DateTime.now().add(const Duration(days: 300)),
    );
    if (picked == null) return;
    setState(() {
      _dueDate = picked;
      final daysLeft = picked
          .difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
          )
          .inDays;
      final weeksLeft = (daysLeft / 7).round().clamp(0, 40);
      _weeks = (40 - weeksLeft).clamp(1, 42);
      _lastPeriod = picked.subtract(const Duration(days: 280));
    });
  }

  Future<void> _pickLastPeriod() async {
    final picked = await _pickDate(
      initial: _lastPeriod,
      first: DateTime.now().subtract(const Duration(days: 310)),
      last: DateTime.now(),
    );
    if (picked == null) return;
    setState(() {
      _lastPeriod = picked;
      _dueDate = picked.add(const Duration(days: 280));
      final days = DateTime.now().difference(picked).inDays;
      _weeks = (days / 7).floor().clamp(1, 42);
    });
  }

  void _save() {
    final prefs = UserPreferences.instance;
    switch (_mode) {
      case _EditMode.week:
        prefs.setWeeksPregnant(_weeks);
      case _EditMode.dueDate:
        prefs.setDueDate(_dueDate);
      case _EditMode.lastPeriod:
        prefs.setLastPeriodDate(_lastPeriod);
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pregnancy updated · Week ${UserPreferences.instance.weeksPregnant}',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.ringPink,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Update pregnancy date',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.burgundy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Change your week, due date, or last period date anytime. '
            'Your home and plan will update automatically.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ModeChip(
                  label: 'Week',
                  selected: _mode == _EditMode.week,
                  onTap: () => setState(() => _mode = _EditMode.week),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ModeChip(
                  label: 'Due date',
                  selected: _mode == _EditMode.dueDate,
                  onTap: () => setState(() => _mode = _EditMode.dueDate),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ModeChip(
                  label: 'Last period',
                  selected: _mode == _EditMode.lastPeriod,
                  onTap: () => setState(() => _mode = _EditMode.lastPeriod),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (_mode == _EditMode.week) ...[
            Text(
              '$_weeks weeks pregnant',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.magenta,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Estimated due date: ${_formatDate(_dueDate)}',
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textMuted,
              ),
            ),
            Slider(
              value: _weeks.toDouble(),
              min: 1,
              max: 42,
              divisions: 41,
              activeColor: AppColors.magenta,
              inactiveColor: AppColors.mistPink,
              label: '$_weeks weeks',
              onChanged: (value) {
                final weeks = value.round();
                setState(() {
                  _weeks = weeks;
                  _dueDate = DateTime.now().add(
                    Duration(days: (40 - weeks).clamp(0, 40) * 7),
                  );
                  _lastPeriod = _dueDate.subtract(const Duration(days: 280));
                });
              },
            ),
          ] else if (_mode == _EditMode.dueDate) ...[
            _DateSelectCard(
              title: 'Your due date',
              value: _formatDate(_dueDate),
              subtitle: 'You are about $_weeks weeks pregnant',
              onTap: _pickDueDate,
            ),
          ] else ...[
            _DateSelectCard(
              title: 'First day of last period',
              value: _formatDate(_lastPeriod),
              subtitle:
                  'Due date ${_formatDate(_dueDate)} · about $_weeks weeks',
              onTap: _pickLastPeriod,
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.magenta,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Save changes',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.magenta : AppColors.blush,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: selected ? AppColors.white : AppColors.burgundy,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateSelectCard extends StatelessWidget {
  const _DateSelectCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String value;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.softPink,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.magenta,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.burgundy,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.edit_calendar_outlined,
                color: AppColors.magenta,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
