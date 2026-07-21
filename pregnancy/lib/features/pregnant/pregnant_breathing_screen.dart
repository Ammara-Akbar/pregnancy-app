import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum _Phase { inhale, hold, exhale }

class _Technique {
  const _Technique({
    required this.name,
    required this.description,
    required this.inhale,
    required this.hold,
    required this.exhale,
  });

  final String name;
  final String description;
  final int inhale;
  final int hold;
  final int exhale;
}

const _techniques = [
  _Technique(
    name: 'Calm Breathing',
    description: 'Relax between contractions and ease anxiety.',
    inhale: 4,
    hold: 2,
    exhale: 6,
  ),
  _Technique(
    name: 'Slow Breathing',
    description: 'Steady rhythm to use during early labor contractions.',
    inhale: 4,
    hold: 0,
    exhale: 4,
  ),
  _Technique(
    name: 'Light Breathing',
    description: 'Short, light breaths for stronger contractions.',
    inhale: 2,
    hold: 0,
    exhale: 2,
  ),
];

class PregnantBreathingScreen extends StatefulWidget {
  const PregnantBreathingScreen({super.key});

  @override
  State<PregnantBreathingScreen> createState() =>
      _PregnantBreathingScreenState();
}

class _PregnantBreathingScreenState extends State<PregnantBreathingScreen> {
  int _selectedTechnique = 0;
  bool _running = false;
  _Phase _phase = _Phase.inhale;
  int _secondsLeft = 0;
  int _cycles = 0;
  Timer? _timer;

  _Technique get _technique => _techniques[_selectedTechnique];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    setState(() {
      _running = true;
      _cycles = 0;
      _phase = _Phase.inhale;
      _secondsLeft = _technique.inhale;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _stop() {
    _timer?.cancel();
    setState(() => _running = false);
  }

  void _tick() {
    if (_secondsLeft > 1) {
      setState(() => _secondsLeft--);
      return;
    }
    setState(() {
      switch (_phase) {
        case _Phase.inhale:
          if (_technique.hold > 0) {
            _phase = _Phase.hold;
            _secondsLeft = _technique.hold;
          } else {
            _phase = _Phase.exhale;
            _secondsLeft = _technique.exhale;
          }
        case _Phase.hold:
          _phase = _Phase.exhale;
          _secondsLeft = _technique.exhale;
        case _Phase.exhale:
          _cycles++;
          _phase = _Phase.inhale;
          _secondsLeft = _technique.inhale;
      }
    });
  }

  void _selectTechnique(int index) {
    if (_running) _stop();
    setState(() => _selectedTechnique = index);
  }

  String get _phaseLabel => switch (_phase) {
    _Phase.inhale => 'Breathe In',
    _Phase.hold => 'Hold',
    _Phase.exhale => 'Breathe Out',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        title: const Text(
          'Breathing Exercises',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const _HeroCard(),
            const SizedBox(height: 16),
            const Text(
              'Choose a technique',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < _techniques.length; i++) ...[
              _TechniqueCard(
                technique: _techniques[i],
                selected: i == _selectedTechnique,
                onTap: () => _selectTechnique(i),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 8),
            _BreathingCircle(
              running: _running,
              phase: _phase,
              phaseLabel: _phaseLabel,
              secondsLeft: _secondsLeft,
              cycles: _cycles,
              phaseDuration: switch (_phase) {
                _Phase.inhale => _technique.inhale,
                _Phase.hold => _technique.hold,
                _Phase.exhale => _technique.exhale,
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _running ? _stop : _start,
                style: FilledButton.styleFrom(
                  backgroundColor: _running
                      ? AppColors.burgundy
                      : AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: Icon(
                  _running ? Icons.stop_rounded : Icons.play_arrow_rounded,
                ),
                label: Text(
                  _running ? 'Stop Exercise' : 'Start Exercise',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const _TipCard(),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/breathing_hero.png',
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Breathe & Relax',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.burgundy,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Follow the circle as it grows and shrinks. '
                  'Breathing exercises help you stay calm during labor.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechniqueCard extends StatelessWidget {
  const _TechniqueCard({
    required this.technique,
    required this.selected,
    required this.onTap,
  });

  final _Technique technique;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pattern = technique.hold > 0
        ? 'In ${technique.inhale}s · Hold ${technique.hold}s · Out ${technique.exhale}s'
        : 'In ${technique.inhale}s · Out ${technique.exhale}s';
    return Material(
      color: selected ? AppColors.blush : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.magenta : AppColors.mistPink,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: selected ? AppColors.magenta : AppColors.skipGrey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      technique.name,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      technique.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: selected ? AppColors.magenta : AppColors.blush,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  pattern,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: selected ? AppColors.white : AppColors.burgundy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreathingCircle extends StatelessWidget {
  const _BreathingCircle({
    required this.running,
    required this.phase,
    required this.phaseLabel,
    required this.secondsLeft,
    required this.cycles,
    required this.phaseDuration,
  });

  final bool running;
  final _Phase phase;
  final String phaseLabel;
  final int secondsLeft;
  final int cycles;
  final int phaseDuration;

  @override
  Widget build(BuildContext context) {
    final double size = !running
        ? 150
        : switch (phase) {
            _Phase.inhale => 200,
            _Phase.hold => 200,
            _Phase.exhale => 130,
          };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: Center(
              child: AnimatedContainer(
                duration: running
                    ? Duration(seconds: phaseDuration)
                    : const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [AppColors.blush, AppColors.ringPink],
                  ),
                  border: Border.all(color: AppColors.magenta, width: 3),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        running ? phaseLabel : 'Ready?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.burgundy,
                        ),
                      ),
                      if (running) ...[
                        const SizedBox(height: 4),
                        Text(
                          '$secondsLeft',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.magenta,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            running
                ? 'Cycles completed: $cycles'
                : 'Press start and follow the circle',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.tips_and_updates_outlined,
            color: AppColors.magenta,
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Tip: Breathe in slowly through your nose and out through your '
              'mouth. Practice daily so the rhythm feels natural when labor '
              'begins.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: AppColors.burgundy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
