import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import 'pregnant_symptom_guide.dart';

class PregnantSymptomsScreen extends StatefulWidget {
  const PregnantSymptomsScreen({super.key, required this.weeksPregnant});

  final int weeksPregnant;

  @override
  State<PregnantSymptomsScreen> createState() => _PregnantSymptomsScreenState();
}

class _PregnantSymptomsScreenState extends State<PregnantSymptomsScreen> {
  late int _trimesterIndex =
      PregnantTrimesterSymptoms.trimesterIndexForWeek(widget.weeksPregnant);
  String _filter = 'All';

  Color _levelColor(PainLevel level) {
    switch (level) {
      case PainLevel.mild:
        return const Color(0xFF4CAF7A);
      case PainLevel.mildModerate:
      case PainLevel.variable:
        return const Color(0xFFE0A84A);
      case PainLevel.moderate:
        return const Color(0xFFE07A4A);
      case PainLevel.moderateHigh:
        return const Color(0xFFC24D7F);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        final plans = PregnantTrimesterSymptoms.all();
        final plan = plans[_trimesterIndex.clamp(0, plans.length - 1)];
        final currentIndex = PregnantTrimesterSymptoms.trimesterIndexForWeek(
          widget.weeksPregnant,
        );
        final filters = const ['All', 'Sickness', 'Pain', 'Illness'];
        final symptoms = plan.symptoms.where((s) {
          if (_filter == 'All') return true;
          if (_filter == 'Sickness') return s.kind == SymptomKind.sickness;
          if (_filter == 'Pain') return s.kind == SymptomKind.pain;
          return s.kind == SymptomKind.illness;
        }).toList();

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
              'Symptoms & Pain',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How you may feel this trimester',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Week ${widget.weeksPregnant} · ${plans[currentIndex].label}. '
                      'Typical sickness, illness risks, and pain levels — not a diagnosis.',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4A3A42),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (var i = 0; i < plans.length; i++) ...[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _trimesterIndex = i;
                          _filter = 'All';
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _trimesterIndex == i
                                ? AppColors.magenta
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _trimesterIndex == i
                                  ? AppColors.magenta
                                  : const Color(0xFFF0D6E0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                plans[i].label.replaceAll(' Trimester', ''),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _trimesterIndex == i
                                      ? AppColors.white
                                      : const Color(0xFF2C3A55),
                                ),
                              ),
                              Text(
                                plans[i]
                                    .weekRange
                                    .replaceAll('Weeks ', 'W ')
                                    .replaceAll('–', '-'),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _trimesterIndex == i
                                      ? AppColors.white.withValues(alpha: 0.9)
                                      : AppColors.textMuted,
                                ),
                              ),
                              if (i == currentIndex) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Yours',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: _trimesterIndex == i
                                        ? AppColors.white
                                        : AppColors.magenta,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (i < plans.length - 1) const SizedBox(width: 8),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Text(
                plan.focusTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                plan.focusBody,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textMuted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan.comfortNote,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF2C4A6E),
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pain level guide',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final level in [
                    PainLevel.mild,
                    PainLevel.mildModerate,
                    PainLevel.moderate,
                    PainLevel.moderateHigh,
                  ])
                    _LegendChip(
                      label: level.label,
                      color: _levelColor(level),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final f in filters) ...[
                      GestureDetector(
                        onTap: () => setState(() => _filter = f),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _filter == f
                                ? const Color(0xFF8B6BA8)
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _filter == f
                                  ? const Color(0xFF8B6BA8)
                                  : const Color(0xFFF0D6E0),
                            ),
                          ),
                          child: Text(
                            f,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: _filter == f
                                  ? AppColors.white
                                  : const Color(0xFF2C3A55),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),
              for (final s in symptoms) ...[
                _SymptomCard(
                  symptom: s,
                  levelColor: _levelColor(s.painLevel),
                ),
              ],
              if (symptoms.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No items in this filter.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              const Text(
                'Seek care urgently if',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F0),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFF5D0CB)),
                ),
                child: Column(
                  children: [
                    for (final flag in plan.redFlags) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            size: 18,
                            color: Color(0xFFC45C4A),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              flag,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF5A3A36),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (flag != plan.redFlags.last) const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Guidance only — contact your doctor or midwife for personal advice. In an emergency, go to hospital.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textMuted.withValues(alpha: 0.9),
                  height: 1.35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SymptomCard extends StatelessWidget {
  const _SymptomCard({
    required this.symptom,
    required this.levelColor,
  });

  final PregnantSymptom symptom;
  final Color levelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE8EF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(symptom.kindIcon, color: AppColors.magenta, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symptom.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${symptom.kindLabel} · ${symptom.howCommon}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Pain level',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted.withValues(alpha: 0.95),
                ),
              ),
              const Spacer(),
              Text(
                symptom.painLevel.label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: levelColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              for (var i = 1; i <= 4; i++) ...[
                Expanded(
                  child: Container(
                    height: 6,
                    margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
                    decoration: BoxDecoration(
                      color: i <= symptom.painLevel.score
                          ? levelColor
                          : const Color(0xFFF0E4EA),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          _MiniBlock(title: 'What it feels like', body: symptom.whatItFeelsLike),
          _MiniBlock(title: 'What may help', body: symptom.whatHelps),
          _MiniBlock(
            title: 'Call your doctor if',
            body: symptom.seekCareIf,
            accent: true,
          ),
        ],
      ),
    );
  }
}

class _MiniBlock extends StatelessWidget {
  const _MiniBlock({
    required this.title,
    required this.body,
    this.accent = false,
  });

  final String title;
  final String body;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: accent ? const Color(0xFFC45C4A) : AppColors.magenta,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF4A3A42),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
