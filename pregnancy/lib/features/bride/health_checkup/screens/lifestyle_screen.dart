import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../models/health_checkup_models.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';

class LifestyleScreen extends StatefulWidget {
  const LifestyleScreen({super.key});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen> {
  late LifestyleAnswers _answers;

  @override
  void initState() {
    super.initState();
    _answers = context.read<HealthCheckupProvider>().lifestyle;
  }

  @override
  Widget build(BuildContext context) {
    return HealthCheckupScaffold(
      title: 'Lifestyle Assessment',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: Row(
              children: [
                HealthProgressRing(
                  progress: _answers.score / 100,
                  label: '${_answers.score}',
                  subtitle: 'Score',
                  size: 96,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Answer honestly for a better readiness estimate.',
                    style: TextStyle(
                      height: 1.4,
                      color: HealthCheckupColors.muted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SwitchCard(
            title: 'Do you smoke?',
            value: _answers.smokes,
            onChanged: (v) => setState(() => _answers = _answers.copyWith(smokes: v)),
          ),
          _SwitchCard(
            title: 'Alcohol?',
            value: _answers.alcohol,
            onChanged: (v) =>
                setState(() => _answers = _answers.copyWith(alcohol: v)),
          ),
          _SwitchCard(
            title: 'Exercise regularly?',
            value: _answers.exercises,
            onChanged: (v) =>
                setState(() => _answers = _answers.copyWith(exercises: v)),
          ),
          _SliderCard(
            title: 'Sleep Hours',
            value: _answers.sleepHours.toDouble(),
            min: 4,
            max: 10,
            divisions: 6,
            label: '${_answers.sleepHours} hrs',
            onChanged: (v) => setState(
              () => _answers = _answers.copyWith(sleepHours: v.round()),
            ),
          ),
          _SliderCard(
            title: 'Water Intake (glasses)',
            value: _answers.waterGlasses.toDouble(),
            min: 1,
            max: 12,
            divisions: 11,
            label: '${_answers.waterGlasses}',
            onChanged: (v) => setState(
              () => _answers = _answers.copyWith(waterGlasses: v.round()),
            ),
          ),
          _SliderCard(
            title: 'Stress Level',
            value: _answers.stressLevel.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: '${_answers.stressLevel}/5',
            onChanged: (v) => setState(
              () => _answers = _answers.copyWith(stressLevel: v.round()),
            ),
          ),
          _SliderCard(
            title: 'BMI',
            value: _answers.bmi,
            min: 16,
            max: 35,
            divisions: 38,
            label: _answers.bmi.toStringAsFixed(1),
            onChanged: (v) =>
                setState(() => _answers = _answers.copyWith(bmi: v)),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () {
              context.read<HealthCheckupProvider>().updateLifestyle(_answers);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lifestyle score saved: ${_answers.score}'),
                ),
              );
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: HealthCheckupColors.softPink,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Generate Lifestyle Score',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchCard extends StatelessWidget {
  const _SwitchCard({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        child: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: HealthCheckupColors.navy,
            ),
          ),
          value: value,
          activeThumbColor: HealthCheckupColors.softPink,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _SliderCard extends StatelessWidget {
  const _SliderCard({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.onChanged,
  });

  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const Spacer(),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.softPink,
                  ),
                ),
              ],
            ),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              activeColor: HealthCheckupColors.softPink,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
