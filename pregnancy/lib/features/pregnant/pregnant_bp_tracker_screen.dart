import 'package:flutter/material.dart';

class _BpReading {
  const _BpReading({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.takenAt,
  });

  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime takenAt;
}

enum _BpCategory { low, normal, elevated, high }

_BpCategory _categorize(int systolic, int diastolic) {
  if (systolic < 90 || diastolic < 60) return _BpCategory.low;
  if (systolic >= 140 || diastolic >= 90) return _BpCategory.high;
  if (systolic >= 120 || diastolic >= 80) return _BpCategory.elevated;
  return _BpCategory.normal;
}

extension on _BpCategory {
  String get label => switch (this) {
    _BpCategory.low => 'Low',
    _BpCategory.normal => 'Normal',
    _BpCategory.elevated => 'Elevated',
    _BpCategory.high => 'High',
  };

  String get range => switch (this) {
    _BpCategory.low => 'Below 90/60',
    _BpCategory.normal => '90/60 - 119/79',
    _BpCategory.elevated => '120/80 - 139/89',
    _BpCategory.high => '140/90 or higher',
  };

  Color get color => switch (this) {
    _BpCategory.low => const Color(0xFF5BA8D9),
    _BpCategory.normal => const Color(0xFF12934F),
    _BpCategory.elevated => const Color(0xFFE8913A),
    _BpCategory.high => const Color(0xFFE0475B),
  };

  String get advice => switch (this) {
    _BpCategory.low =>
      'Slightly low. Rest, drink fluids, and rise slowly from sitting.',
    _BpCategory.normal => 'Your blood pressure is in a healthy range.',
    _BpCategory.elevated =>
      'A little high. Rest and re-check; mention it at your next visit.',
    _BpCategory.high =>
      'High reading. Contact your doctor or midwife promptly.',
  };
}

class PregnantBpTrackerScreen extends StatefulWidget {
  const PregnantBpTrackerScreen({super.key});

  @override
  State<PregnantBpTrackerScreen> createState() =>
      _PregnantBpTrackerScreenState();
}

class _PregnantBpTrackerScreenState extends State<PregnantBpTrackerScreen> {
  final List<_BpReading> _readings = [
    _BpReading(
      systolic: 112,
      diastolic: 74,
      pulse: 78,
      takenAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    _BpReading(
      systolic: 118,
      diastolic: 79,
      pulse: 82,
      takenAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    _BpReading(
      systolic: 109,
      diastolic: 71,
      pulse: 75,
      takenAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  Future<void> _addReading() async {
    final result = await showDialog<_BpReading>(
      context: context,
      builder: (context) => const _AddReadingDialog(),
    );

    if (result != null && mounted) {
      setState(() => _readings.insert(0, result));
    }
  }

  static String _timeLabel(DateTime takenAt) {
    final now = DateTime.now();
    final difference = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(takenAt.year, takenAt.month, takenAt.day)).inDays;
    final time =
        '${takenAt.hour.toString().padLeft(2, '0')}:'
        '${takenAt.minute.toString().padLeft(2, '0')}';
    return switch (difference) {
      0 => 'Today, $time',
      1 => 'Yesterday, $time',
      _ => '$difference days ago, $time',
    };
  }

  @override
  Widget build(BuildContext context) {
    final latest = _readings.first;
    final category = _categorize(latest.systolic, latest.diastolic);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'BP Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Keep an eye on your blood pressure',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/bp_tracker_hero.png',
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
                          'Latest Reading',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF625A79),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '${latest.systolic}/${latest.diastolic}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF251064),
                            ),
                            children: const [
                              TextSpan(
                                text: ' mmHg',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite_rounded,
                              size: 13,
                              color: Color(0xFFE0475B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Pulse ${latest.pulse} bpm',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF625A79),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: category.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: category.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: category.color.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: category.color,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      category.advice,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: category.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What readings mean',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF251064),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final item in _BpCategory.values) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: item.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 70,
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: item == category
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: item == category
                                    ? item.color
                                    : const Color(0xFF4E416A),
                              ),
                            ),
                          ),
                          Text(
                            item.range,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF625A79),
                            ),
                          ),
                          if (item == category) ...[
                            const Spacer(),
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: item.color,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF251064),
                        ),
                      ),
                    ),
                  ),
                  for (var i = 0; i < _readings.length; i++) ...[
                    Builder(
                      builder: (context) {
                        final reading = _readings[i];
                        final readingCategory = _categorize(
                          reading.systolic,
                          reading.diastolic,
                        );
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: readingCategory.color.withValues(
                              alpha: 0.14,
                            ),
                            child: Icon(
                              Icons.monitor_heart_outlined,
                              size: 20,
                              color: readingCategory.color,
                            ),
                          ),
                          title: Text(
                            '${reading.systolic}/${reading.diastolic} mmHg',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF251064),
                            ),
                          ),
                          subtitle: Text(
                            '${_timeLabel(reading.takenAt)}  -  '
                            'Pulse ${reading.pulse}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF625A79),
                            ),
                          ),
                          trailing: Text(
                            readingCategory.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: readingCategory.color,
                            ),
                          ),
                        );
                      },
                    ),
                    if (i < _readings.length - 1)
                      const Divider(
                        height: 1,
                        indent: 70,
                        color: Color(0xFFF0E5EB),
                      ),
                  ],
                  const SizedBox(height: 6),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: FilledButton.icon(
                onPressed: _addReading,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFF73573),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text(
                  'Add Reading',
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

class _AddReadingDialog extends StatefulWidget {
  const _AddReadingDialog();

  @override
  State<_AddReadingDialog> createState() => _AddReadingDialogState();
}

class _AddReadingDialogState extends State<_AddReadingDialog> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _save() {
    final systolic = int.tryParse(_systolicController.text);
    final diastolic = int.tryParse(_diastolicController.text);
    final pulse = int.tryParse(_pulseController.text) ?? 0;
    if (systolic == null ||
        diastolic == null ||
        systolic <= 0 ||
        diastolic <= 0) {
      return;
    }
    Navigator.pop(
      context,
      _BpReading(
        systolic: systolic,
        diastolic: diastolic,
        pulse: pulse,
        takenAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add reading'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _systolicController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Systolic (upper)',
                suffixText: 'mmHg',
              ),
            ),
            TextField(
              controller: _diastolicController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Diastolic (lower)',
                suffixText: 'mmHg',
              ),
            ),
            TextField(
              controller: _pulseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Pulse',
                suffixText: 'bpm',
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
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
