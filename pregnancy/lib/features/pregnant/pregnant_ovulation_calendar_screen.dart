import 'package:flutter/material.dart';

class PregnantOvulationCalendarScreen extends StatefulWidget {
  const PregnantOvulationCalendarScreen({super.key});

  @override
  State<PregnantOvulationCalendarScreen> createState() =>
      _PregnantOvulationCalendarScreenState();
}

class _PregnantOvulationCalendarScreenState
    extends State<PregnantOvulationCalendarScreen> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime? _selectedDay;

  static const _months = [
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

  void _changeMonth(int offset) {
    setState(() {
      _month = DateTime(_month.year, _month.month + offset);
      _selectedDay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ovulationDay = DateTime(_month.year, _month.month, 20);
    final fertileStart = ovulationDay.subtract(const Duration(days: 6));
    final fertileEnd = ovulationDay.subtract(const Duration(days: 4));
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'Ovulation Calendar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Plan your pregnancy by tracking your ovulation.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _changeMonth(-1),
                        icon: const Icon(Icons.chevron_left_rounded),
                      ),
                      Expanded(
                        child: Text(
                          '${_months[_month.month - 1]} ${_month.year}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF251064),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _changeMonth(1),
                        icon: const Icon(Icons.chevron_right_rounded),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      for (final day in [
                        'Sun',
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat',
                      ])
                        Expanded(
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF625A79),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _CalendarGrid(
                    month: _month,
                    selectedDay: _selectedDay,
                    ovulationDay: ovulationDay,
                    fertileStart: fertileStart,
                    fertileEnd: fertileEnd,
                    onSelected: (day) => setState(() => _selectedDay = day),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Legend(color: Color(0xFFFFA6C3), label: 'Period'),
                      _Legend(
                        color: Color(0xFFDCCDF8),
                        label: 'Fertile Window',
                      ),
                      _Legend(color: Color(0xFF8053D4), label: 'Ovulation'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _NextOvulationCard(date: ovulationDay),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3EDFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4D9F5)),
              ),
              child: Text(
                'Tip\nYour fertile window is ${_months[fertileStart.month - 1]} '
                '${fertileStart.day} - ${fertileEnd.day}.',
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.6,
                  color: Color(0xFF4E416A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.month,
    required this.selectedDay,
    required this.ovulationDay,
    required this.fertileStart,
    required this.fertileEnd,
    required this.onSelected,
  });

  final DateTime month;
  final DateTime? selectedDay;
  final DateTime ovulationDay;
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final ValueChanged<DateTime> onSelected;

  bool _sameDay(DateTime? a, DateTime b) =>
      a != null && a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading = firstDay.weekday % 7;
    final cells = ((leading + daysInMonth + 6) ~/ 7) * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cells,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (context, index) {
        final dayNumber = index - leading + 1;
        if (dayNumber < 1 || dayNumber > daysInMonth) {
          return const SizedBox.shrink();
        }
        final day = DateTime(month.year, month.month, dayNumber);
        final isOvulation = _sameDay(day, ovulationDay);
        final isFertile =
            !day.isBefore(fertileStart) && !day.isAfter(fertileEnd);
        final isPeriod = dayNumber >= 14 && dayNumber <= 16;
        final isSelected = _sameDay(selectedDay, day);
        final color = isOvulation
            ? const Color(0xFF8053D4)
            : isPeriod
            ? const Color(0xFFFFA6C3)
            : isFertile
            ? const Color(0xFFDCCDF8)
            : isSelected
            ? const Color(0xFFF0EAF8)
            : Colors.transparent;

        return InkWell(
          onTap: () => onSelected(day),
          customBorder: const CircleBorder(),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              '$dayNumber',
              style: TextStyle(
                fontSize: 11,
                fontWeight: isOvulation ? FontWeight.w700 : FontWeight.w500,
                color: isOvulation ? Colors.white : const Color(0xFF282333),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 9, color: Color(0xFF625A79)),
        ),
      ],
    );
  }
}

class _NextOvulationCard extends StatelessWidget {
  const _NextOvulationCard({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
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
    final now = DateTime.now();
    final days = date.difference(DateTime(now.year, now.month, now.day)).inDays;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0E5EB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Next Ovulation',
                  style: TextStyle(fontSize: 11, color: Color(0xFF625A79)),
                ),
                const SizedBox(height: 6),
                Text(
                  '${months[date.month - 1]} ${date.day}, ${date.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF171426),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  days >= 0 ? '$days days left' : 'Date has passed',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF625A79),
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFF1EBFA),
            child: Icon(Icons.chevron_right_rounded, color: Color(0xFF8053D4)),
          ),
        ],
      ),
    );
  }
}
