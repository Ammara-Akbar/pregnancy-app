import 'package:flutter/material.dart';

class PregnantWaterTrackerScreen extends StatefulWidget {
  const PregnantWaterTrackerScreen({super.key});

  @override
  State<PregnantWaterTrackerScreen> createState() =>
      _PregnantWaterTrackerScreenState();
}

class _PregnantWaterTrackerScreenState
    extends State<PregnantWaterTrackerScreen> {
  static const _blue = Color(0xFF3D9BD6);
  static const _goalMl = 2500;
  static const _glassMl = 250;

  int _intakeMl = 750;

  void _add(int amount) {
    setState(() => _intakeMl = (_intakeMl + amount).clamp(0, 6000));
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_intakeMl / _goalMl).clamp(0.0, 1.0);
    final glassesFull = _intakeMl ~/ _glassMl;
    final goalReached = _intakeMl >= _goalMl;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'Water Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Stay hydrated for you & your baby',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE3EEF6)),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/water_tracker_hero.png',
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
                          "Today's Intake",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF625A79),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '$_intakeMl',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF17456B),
                            ),
                            children: const [
                              TextSpan(
                                text: ' ml',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'of $_goalMl ml goal',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF625A79),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 9,
                            backgroundColor: const Color(0xFFE3F0F9),
                            valueColor: const AlwaysStoppedAnimation(_blue),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${(progress * 100).round()}% of daily goal',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF625A79),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            if (goalReached)
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F7EE),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFC9EBD8)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: Color(0xFF12934F),
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Goal reached! Great job staying hydrated today.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B7547),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE3EEF6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Glasses today ($glassesFull of ${_goalMl ~/ _glassMl})',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF17456B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '1 glass = 250 ml',
                    style: TextStyle(fontSize: 10, color: Color(0xFF625A79)),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var i = 0; i < _goalMl ~/ _glassMl; i++)
                        Icon(
                          i < glassesFull
                              ? Icons.local_drink_rounded
                              : Icons.local_drink_outlined,
                          size: 30,
                          color: i < glassesFull
                              ? _blue
                              : const Color(0xFFC3D9E8),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _AddButton(
                    icon: Icons.local_drink_rounded,
                    label: 'Glass',
                    amount: '+250 ml',
                    onTap: () => _add(250),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _AddButton(
                    icon: Icons.water_drop_rounded,
                    label: 'Bottle',
                    amount: '+500 ml',
                    onTap: () => _add(500),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _AddButton(
                    icon: Icons.undo_rounded,
                    label: 'Undo',
                    amount: '-250 ml',
                    outlined: true,
                    onTap: () => _add(-250),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F5FC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD2E9F6)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 20,
                    color: Color(0xFF3D9BD6),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tip\nDuring pregnancy, aim for 8-10 glasses a day. '
                      'Drink a little extra in hot weather or after activity.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.5,
                        color: Color(0xFF2E5876),
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

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.icon,
    required this.label,
    required this.amount,
    required this.onTap,
    this.outlined = false,
  });

  final IconData icon;
  final String label;
  final String amount;
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3D9BD6);
    return Material(
      color: outlined ? Colors.white : blue,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: outlined ? const Color(0xFFBBDCF0) : blue,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 22, color: outlined ? blue : Colors.white),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: outlined ? blue : Colors.white,
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 9.5,
                  color: outlined ? const Color(0xFF6D9BB9) : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
