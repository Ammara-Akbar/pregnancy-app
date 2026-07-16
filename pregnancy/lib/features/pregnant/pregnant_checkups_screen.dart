import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantCheckupsScreen extends StatefulWidget {
  const PregnantCheckupsScreen({super.key, required this.weeksPregnant});

  final int weeksPregnant;

  @override
  State<PregnantCheckupsScreen> createState() => _PregnantCheckupsScreenState();
}

class _PregnantCheckupsScreenState extends State<PregnantCheckupsScreen> {
  late final List<_Checkup> _items = [
    _Checkup('First antenatal visit', 'Completed', true, 'Booking & baseline tests'),
    _Checkup('NT / early scan', widget.weeksPregnant >= 12 ? 'Due soon' : 'Upcoming', false, 'Usually around 11–14 weeks'),
    _Checkup('Anomaly scan', 'Upcoming', false, 'Usually around 18–22 weeks'),
    _Checkup('Glucose screening', 'Upcoming', false, 'Often in 2nd trimester'),
    _Checkup('Growth scan', 'Upcoming', false, 'Later pregnancy monitoring'),
  ];

  @override
  Widget build(BuildContext context) {
    final done = _items.where((e) => e.done).length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'Checkups',
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
            child: Text(
              'Week ${widget.weeksPregnant} · $done / ${_items.length} checkup milestones tracked',
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3A55),
              ),
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < _items.length; i++) ...[
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _items[i] = _Checkup(
                      _items[i].title,
                      _items[i].done ? 'Upcoming' : 'Completed',
                      !_items[i].done,
                      _items[i].note,
                    );
                  });
                },
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _items[i].done
                              ? AppColors.magenta
                              : Colors.transparent,
                          border: Border.all(
                            color: _items[i].done
                                ? AppColors.magenta
                                : AppColors.ringPink,
                            width: 2,
                          ),
                        ),
                        child: _items[i].done
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _items[i].title,
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2C3A55),
                                decoration: _items[i].done
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _items[i].note,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _items[i].status,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: _items[i].done
                              ? const Color(0xFF4CAF7A)
                              : AppColors.magenta,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          const Text(
            'Tip: Always follow your doctor’s schedule — this list is a helpful checklist, not medical advice.',
            style: TextStyle(
              fontSize: 12.5,
              color: AppColors.textMuted,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _Checkup {
  const _Checkup(this.title, this.status, this.done, this.note);

  final String title;
  final String status;
  final bool done;
  final String note;
}
