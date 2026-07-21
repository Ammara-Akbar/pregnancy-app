import 'package:flutter/material.dart';

class PregnantDueDateScreen extends StatefulWidget {
  const PregnantDueDateScreen({super.key});

  @override
  State<PregnantDueDateScreen> createState() => _PregnantDueDateScreenState();
}

class _PregnantDueDateScreenState extends State<PregnantDueDateScreen> {
  int _tab = 0;
  DateTime _lmpDate = DateTime.now().subtract(const Duration(days: 136));
  DateTime _ultrasoundDate = DateTime.now().subtract(const Duration(days: 30));
  int _gaWeeksAtScan = 15;

  static const _months = [
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
  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  DateTime get _conceptionAnchor => _tab == 0
      ? _lmpDate
      : _ultrasoundDate.subtract(Duration(days: _gaWeeksAtScan * 7));

  DateTime get _dueDate => _conceptionAnchor.add(const Duration(days: 280));

  Future<void> _pickDate({required bool lmp}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: lmp ? _lmpDate : _ultrasoundDate,
      firstDate: now.subtract(const Duration(days: 300)),
      lastDate: now,
    );
    if (picked != null && mounted) {
      setState(() {
        if (lmp) {
          _lmpDate = picked;
        } else {
          _ultrasoundDate = picked;
        }
      });
    }
  }

  String _format(DateTime date) =>
      '${_months[date.month - 1]} ${date.day}, ${date.year}';

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final daysPregnant = today.difference(_conceptionAnchor).inDays;
    final weeks = daysPregnant ~/ 7;
    final days = daysPregnant % 7;
    final remaining = _dueDate
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'Due Date Calculator',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Calculate your estimated due date',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 18),
            _SegmentedTabs(
              tabs: const ['By LMP', 'By Ultrasound'],
              selected: _tab,
              onChanged: (index) => setState(() => _tab = index),
            ),
            const SizedBox(height: 16),
            if (_tab == 0)
              _DateFieldCard(
                title: 'Last Menstrual Period',
                fieldLabel: 'Start Date',
                value: _format(_lmpDate),
                onTap: () => _pickDate(lmp: true),
              )
            else ...[
              _DateFieldCard(
                title: 'Ultrasound Date',
                fieldLabel: 'Scan Date',
                value: _format(_ultrasoundDate),
                onTap: () => _pickDate(lmp: false),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF0E5EB)),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Gestational age at scan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF625A79),
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _gaWeeksAtScan,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF251064),
                        ),
                        items: [
                          for (var week = 4; week <= 40; week++)
                            DropdownMenuItem(
                              value: week,
                              child: Text('$week weeks'),
                            ),
                        ],
                        onChanged: (week) {
                          if (week != null) {
                            setState(() => _gaWeeksAtScan = week);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Your Due Date',
                    style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _format(_dueDate),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFF73573),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _weekdays[_dueDate.weekday - 1],
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF625A79),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1, color: Color(0xFFF0E5EB)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _ResultStat(
                          value: '$weeks Weeks $days Days',
                          label: 'Pregnant',
                          prefix: 'You are',
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                        child: VerticalDivider(color: Color(0xFFF0E5EB)),
                      ),
                      Expanded(
                        child: _ResultStat(
                          value: '$remaining Days',
                          label: 'Remaining',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.tabs,
    required this.selected,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0E5EB)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected == i
                        ? const Color(0xFFFBD9E6)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: selected == i
                          ? const Color(0xFFDD3D74)
                          : const Color(0xFF625A79),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DateFieldCard extends StatelessWidget {
  const _DateFieldCard({
    required this.title,
    required this.fieldLabel,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String fieldLabel;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0E5EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF251064),
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8FB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fieldLabel,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF625A79),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF171426),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xFFDD3D74),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  const _ResultStat({required this.value, required this.label, this.prefix});

  final String value;
  final String label;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prefix ?? '',
          style: const TextStyle(fontSize: 10, color: Color(0xFF625A79)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF171426),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF625A79)),
        ),
      ],
    );
  }
}
