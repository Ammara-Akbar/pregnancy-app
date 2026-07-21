import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _MedicineReminder {
  _MedicineReminder({
    required this.name,
    required this.dose,
    required this.time,
    this.taken = false,
  });

  final String name;
  final String dose;
  final TimeOfDay time;
  bool taken;
}

class PregnantMedicineReminderScreen extends StatefulWidget {
  const PregnantMedicineReminderScreen({super.key});

  @override
  State<PregnantMedicineReminderScreen> createState() =>
      _PregnantMedicineReminderScreenState();
}

class _PregnantMedicineReminderScreenState
    extends State<PregnantMedicineReminderScreen> {
  final List<_MedicineReminder> _reminders = [
    _MedicineReminder(
      name: 'Prenatal Vitamin',
      dose: '1 tablet',
      time: const TimeOfDay(hour: 8, minute: 0),
      taken: true,
    ),
    _MedicineReminder(
      name: 'Iron Supplement',
      dose: '1 tablet with juice',
      time: const TimeOfDay(hour: 13, minute: 0),
    ),
    _MedicineReminder(
      name: 'Calcium',
      dose: '1 tablet after meal',
      time: const TimeOfDay(hour: 18, minute: 30),
    ),
    _MedicineReminder(
      name: 'Folic Acid',
      dose: '1 tablet',
      time: const TimeOfDay(hour: 21, minute: 0),
    ),
  ];

  Future<void> _addReminder() async {
    final reminder = await showDialog<_MedicineReminder>(
      context: context,
      builder: (context) => const _AddReminderDialog(),
    );
    if (reminder != null && mounted) {
      setState(() {
        _reminders.add(reminder);
        _reminders.sort((a, b) {
          final aMinutes = a.time.hour * 60 + a.time.minute;
          final bMinutes = b.time.hour * 60 + b.time.minute;
          return aMinutes.compareTo(bMinutes);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taken = _reminders.where((reminder) => reminder.taken).length;
    final total = _reminders.length;
    final progress = total == 0 ? 0.0 : taken / total;
    final allTaken = total > 0 && taken == total;

    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Medicine Reminder',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Never miss your daily vitamins & medicines',
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
                    'assets/images/medicine_reminder_hero.png',
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
                          'Today',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '$taken',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.burgundy,
                            ),
                            children: [
                              TextSpan(
                                text: ' of $total taken',
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
                          allTaken
                              ? 'All done for today!'
                              : 'Tap a medicine to mark it taken',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: allTaken
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: allTaken
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
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today's Schedule",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final reminder in _reminders)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() => reminder.taken = !reminder.taken);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: reminder.taken
                                ? AppColors.blush
                                : AppColors.softPink,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: reminder.taken
                                  ? AppColors.magenta
                                  : AppColors.mistPink,
                              width: reminder.taken ? 1.3 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.medication_rounded,
                                  size: 22,
                                  color: AppColors.iconMedicine,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reminder.name,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textDark,
                                        decoration: reminder.taken
                                            ? TextDecoration.lineThrough
                                            : null,
                                        decorationColor: AppColors.skipGrey,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${reminder.dose}  -  '
                                      '${reminder.time.format(context)}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                reminder.taken
                                    ? Icons.check_circle_rounded
                                    : Icons.radio_button_unchecked_rounded,
                                size: 24,
                                color: reminder.taken
                                    ? AppColors.magenta
                                    : AppColors.skipGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 14),
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
                      'Tip\nTake iron with vitamin C (like juice) for better '
                      'absorption, and avoid taking it with milk or tea.',
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
                onPressed: _addReminder,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.add_alarm_rounded),
                label: const Text(
                  'Add Reminder',
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

class _AddReminderDialog extends StatefulWidget {
  const _AddReminderDialog();

  @override
  State<_AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<_AddReminderDialog> {
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null && mounted) {
      setState(() => _time = picked);
    }
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final dose = _doseController.text.trim();
    Navigator.pop(
      context,
      _MedicineReminder(
        name: name,
        dose: dose.isEmpty ? '1 tablet' : dose,
        time: _time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add reminder'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Medicine name'),
            ),
            TextField(
              controller: _doseController,
              decoration: const InputDecoration(
                labelText: 'Dose (e.g. 1 tablet)',
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickTime,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 20,
                      color: AppColors.magenta,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Time: ${_time.format(context)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.magenta,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          style: FilledButton.styleFrom(backgroundColor: AppColors.magenta),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
