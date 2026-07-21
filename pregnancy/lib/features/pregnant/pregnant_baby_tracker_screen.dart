import 'package:flutter/material.dart';

class _WeekInfo {
  const _WeekInfo({
    required this.lengthCm,
    required this.weightG,
    required this.sizeLabel,
    required this.highlights,
  });

  final double lengthCm;
  final int weightG;
  final String sizeLabel;
  final List<String> highlights;
}

const _weekData = <int, _WeekInfo>{
  8: _WeekInfo(
    lengthCm: 1.6,
    weightG: 1,
    sizeLabel: 'Raspberry size',
    highlights: [
      'Tiny fingers and toes are forming.',
      'The heart beats about 150 times a minute.',
      'Facial features are taking shape.',
    ],
  ),
  12: _WeekInfo(
    lengthCm: 5.4,
    weightG: 14,
    sizeLabel: 'Plum size',
    highlights: [
      'Reflexes are developing now.',
      'Baby can open and close fingers.',
      'Vocal cords are forming.',
    ],
  ),
  16: _WeekInfo(
    lengthCm: 11.6,
    weightG: 100,
    sizeLabel: 'Avocado size',
    highlights: [
      'Baby can make sucking motions.',
      'The skeleton is hardening.',
      'You may feel first flutters soon.',
    ],
  ),
  20: _WeekInfo(
    lengthCm: 25.6,
    weightG: 300,
    sizeLabel: 'Banana size',
    highlights: [
      'Baby can hear muffled sounds.',
      'Hair and nails are growing.',
      'Movements are getting stronger.',
    ],
  ),
  24: _WeekInfo(
    lengthCm: 30.1,
    weightG: 600,
    sizeLabel: 'Apricot size',
    highlights: [
      'Baby can hear your voice now.',
      'Lungs are developing.',
      'Your baby is more active now.',
    ],
  ),
  28: _WeekInfo(
    lengthCm: 37.6,
    weightG: 1000,
    sizeLabel: 'Eggplant size',
    highlights: [
      'Eyes can open and close.',
      'Baby may respond to light.',
      'Brain is growing rapidly.',
    ],
  ),
  32: _WeekInfo(
    lengthCm: 42.4,
    weightG: 1700,
    sizeLabel: 'Coconut size',
    highlights: [
      'Baby is practicing breathing.',
      'Bones fully formed but soft.',
      'Baby settles head-down soon.',
    ],
  ),
  36: _WeekInfo(
    lengthCm: 47.4,
    weightG: 2600,
    sizeLabel: 'Romaine size',
    highlights: [
      'Baby is gaining fat quickly.',
      'Most organs are ready.',
      'Baby drops lower in the pelvis.',
    ],
  ),
  40: _WeekInfo(
    lengthCm: 51.2,
    weightG: 3400,
    sizeLabel: 'Watermelon size',
    highlights: [
      'Baby is ready to meet you.',
      'Lungs are fully mature.',
      'Any day now - stay prepared!',
    ],
  ),
};

class PregnantBabyTrackerScreen extends StatefulWidget {
  const PregnantBabyTrackerScreen({super.key, this.weeksPregnant = 24});

  final int weeksPregnant;

  @override
  State<PregnantBabyTrackerScreen> createState() =>
      _PregnantBabyTrackerScreenState();
}

class _PregnantBabyTrackerScreenState extends State<PregnantBabyTrackerScreen> {
  late int _week;

  @override
  void initState() {
    super.initState();
    _week = _weekData.keys.reduce(
      (a, b) =>
          (a - widget.weeksPregnant).abs() < (b - widget.weeksPregnant).abs()
          ? a
          : b,
    );
  }

  String get _monthLabel {
    final months = (_week / 4.345).round().clamp(1, 9);
    return 'Week $_week ($months Months)';
  }

  @override
  Widget build(BuildContext context) {
    final info = _weekData[_week]!;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'Baby Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            const Text(
              "Track your baby's growth week by week",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 18),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFF0E5EB)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _week,
                    borderRadius: BorderRadius.circular(16),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF251064),
                    ),
                    items: [
                      for (final week in _weekData.keys)
                        DropdownMenuItem(
                          value: week,
                          child: Text(
                            week == _week ? _monthLabel : 'Week $week',
                          ),
                        ),
                    ],
                    onChanged: (week) {
                      if (week != null) setState(() => _week = week);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 170,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFDE3EE), Color(0xFFF6D3E4)],
                    ),
                    border: Border.all(
                      color: const Color(0xFFF3BED7),
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      _week < 16
                          ? 'assets/images/fetus_week12.png'
                          : 'assets/images/fetus_week20.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    children: [
                      _StatCard(
                        label: 'Length',
                        value: info.lengthCm.toStringAsFixed(1),
                        unit: 'cm',
                        caption: 'Crown to heel',
                      ),
                      const SizedBox(height: 12),
                      _StatCard(
                        label: 'Weight',
                        value: '${info.weightG}',
                        unit: 'g',
                        caption: info.sizeLabel,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "This Week's Highlights",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF251064),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final highlight in info.highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            size: 14,
                            color: Color(0xFFE86B9A),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              highlight,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF4E416A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFBD9E6),
                        foregroundColor: const Color(0xFFDD3D74),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'View Full Timeline',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.caption,
  });

  final String label;
  final String value;
  final String unit;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0E5EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF625A79)),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF171426),
              ),
              children: [
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            style: const TextStyle(fontSize: 10, color: Color(0xFF625A79)),
          ),
        ],
      ),
    );
  }
}
