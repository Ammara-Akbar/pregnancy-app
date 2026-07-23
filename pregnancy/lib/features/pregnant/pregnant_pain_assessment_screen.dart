import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _PainLocation {
  const _PainLocation({
    required this.label,
    required this.color,
    required this.dotX,
    required this.dotY,
  });

  final String label;
  final Color color;

  /// Fractional x/y inside the body image (0 = left/top, 1 = right/bottom).
  final double dotX;
  final double dotY;
}

class _PainLevel {
  const _PainLevel({
    required this.label,
    required this.emoji,
    required this.color,
  });

  final String label;
  final String emoji;
  final Color color;
}

const _locations = [
  // Front silhouette is on the left half of the image.
  _PainLocation(
    label: 'Lower Abdomen',
    color: Color(0xFFE53935),
    dotX: 0.28,
    dotY: 0.48,
  ),
  // Back silhouette is on the right half of the image.
  _PainLocation(
    label: 'Lower Back',
    color: Color(0xFF5BA8D9),
    dotX: 0.72,
    dotY: 0.46,
  ),
  _PainLocation(
    label: 'Pelvic Area',
    color: Color(0xFF8B6BA8),
    dotX: 0.28,
    dotY: 0.56,
  ),
  _PainLocation(
    label: 'Upper Abdomen',
    color: Color(0xFFE07A4A),
    dotX: 0.28,
    dotY: 0.38,
  ),
  _PainLocation(
    label: 'Others',
    color: Color(0xFF66BB6A),
    dotX: 0.28,
    dotY: 0.28,
  ),
];

const _levels = [
  _PainLevel(label: 'No Pain', emoji: '😀', color: Color(0xFF4CAF50)),
  _PainLevel(label: 'Mild', emoji: '🙂', color: Color(0xFF8BC34A)),
  _PainLevel(label: 'Moderate', emoji: '😐', color: Color(0xFFFFC107)),
  _PainLevel(label: 'Severe', emoji: '😟', color: Color(0xFFFF9800)),
  _PainLevel(label: 'Very Severe', emoji: '😢', color: Color(0xFFE53935)),
];

class PregnantPainAssessmentScreen extends StatefulWidget {
  const PregnantPainAssessmentScreen({super.key});

  @override
  State<PregnantPainAssessmentScreen> createState() =>
      _PregnantPainAssessmentScreenState();
}

class _PregnantPainAssessmentScreenState
    extends State<PregnantPainAssessmentScreen> {
  int _locationIndex = 0;
  int _levelIndex = 2;

  _PainLocation get _location => _locations[_locationIndex];
  _PainLevel get _level => _levels[_levelIndex];

  String get _badgeLabel => switch (_levelIndex) {
    0 || 1 => 'Mild',
    2 => 'Monitor',
    _ => 'Urgent',
  };

  Color get _badgeColor => switch (_levelIndex) {
    0 || 1 => const Color(0xFF66BB6A),
    2 => const Color(0xFFFFC107),
    _ => const Color(0xFFE53935),
  };

  String get _assessmentText => switch (_levelIndex) {
    0 =>
      'You reported no pain in the ${_location.label.toLowerCase()}. '
          'Keep listening to your body and note any new changes.',
    1 =>
      'Your pain seems mild in the ${_location.label.toLowerCase()}. '
          'Rest, stay hydrated and continue gentle movement as comfortable.',
    2 =>
      'Your pain seems to be in the moderate range. Rest, stay hydrated '
          'and monitor your symptoms.',
    3 =>
      'Your pain seems severe in the ${_location.label.toLowerCase()}. '
          'Rest now and contact your maternity team if it does not ease.',
    _ =>
      'Your pain seems very severe. Please contact your doctor or '
          'maternity unit promptly for assessment.',
  };

  void _showInfo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'About Pain Assessment',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.burgundy,
          ),
        ),
        content: const Text(
          'This tool helps you describe where and how strong your pain feels. '
          'It gives general guidance only and is not a medical diagnosis.',
          style: TextStyle(height: 1.4, color: AppColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: AppColors.magenta,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecommendations() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.ringPink,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.burgundy,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${_location.label} · ${_level.label}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 14),
              const _RecommendationRow(
                icon: Icons.hotel_rounded,
                text: 'Rest on your side with pillows supporting your bump.',
              ),
              const SizedBox(height: 10),
              const _RecommendationRow(
                icon: Icons.water_drop_outlined,
                text: 'Drink water regularly and take slow deep breaths.',
              ),
              const SizedBox(height: 10),
              const _RecommendationRow(
                icon: Icons.self_improvement_rounded,
                text:
                    'Try a short gentle stretch or warm (not hot) compress if comfortable.',
              ),
              const SizedBox(height: 10),
              const _RecommendationRow(
                icon: Icons.medical_services_outlined,
                text:
                    'Call your doctor for severe pain, bleeding, fever, fluid leak, or reduced baby movement.',
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.magenta,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Pain Assessment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: _showInfo,
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Describe your pain to get guidance on what to do next.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            _LocationCard(
              locationIndex: _locationIndex,
              onChanged: (index) => setState(() => _locationIndex = index),
            ),
            const SizedBox(height: 18),
            _RatingSection(
              levelIndex: _levelIndex,
              onChanged: (index) => setState(() => _levelIndex = index),
            ),
            const SizedBox(height: 18),
            _AssessmentCard(
              badgeLabel: _badgeLabel,
              badgeColor: _badgeColor,
              assessmentText: _assessmentText,
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _showRecommendations,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'View Recommendations',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.locationIndex, required this.onChanged});

  final int locationIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E4EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Where do you feel the pain?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BodyFigure(
                  locationIndex: locationIndex,
                  onSelectNearest: onChanged,
                ),
                const SizedBox(width: 10),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Color(0xFFEDE8EF),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      for (var i = 0; i < _locations.length; i++) ...[
                        _LocationOption(
                          location: _locations[i],
                          selected: locationIndex == i,
                          onTap: () => onChanged(i),
                        ),
                        if (i < _locations.length - 1)
                          const SizedBox(height: 8),
                      ],
                    ],
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

class _LocationOption extends StatelessWidget {
  const _LocationOption({
    required this.location,
    required this.selected,
    required this.onTap,
  });

  final _PainLocation location;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFFFF0F5) : AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFFF0C8D8)
                  : const Color(0xFFEDE8EF),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.transparent
                      : location.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFE53935) : location.color,
                    shape: BoxShape.circle,
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: selected
                        ? const Color(0xFFE53935)
                        : AppColors.textDark,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Color(0xFFE53935),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BodyFigure extends StatelessWidget {
  const _BodyFigure({
    required this.locationIndex,
    required this.onSelectNearest,
  });

  final int locationIndex;
  final ValueChanged<int> onSelectNearest;

  static const _dotSize = 36.0;

  void _handleTap(Offset local, Size size) {
    final fx = (local.dx / size.width).clamp(0.0, 1.0);
    final fy = (local.dy / size.height).clamp(0.0, 1.0);

    var bestIndex = 0;
    var bestDistance = double.infinity;
    for (var i = 0; i < _locations.length; i++) {
      final loc = _locations[i];
      final dx = loc.dotX - fx;
      final dy = loc.dotY - fy;
      final distance = dx * dx + dy * dy;
      if (distance < bestDistance) {
        bestDistance = distance;
        bestIndex = i;
      }
    }
    onSelectNearest(bestIndex);
  }

  @override
  Widget build(BuildContext context) {
    final location = _locations[locationIndex];
    return SizedBox(
      width: 128,
      height: 236,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final left = (location.dotX * w) - (_dotSize / 2);
          final top = (location.dotY * h) - (_dotSize / 2);

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) =>
                _handleTap(details.localPosition, Size(w, h)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/pain_body_front_back.png',
                    fit: BoxFit.contain,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  left: left,
                  top: top,
                  width: _dotSize,
                  height: _dotSize,
                  child: const _PainDot(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PainDot extends StatelessWidget {
  const _PainDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE53935).withValues(alpha: 0.16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withValues(alpha: 0.22),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE53935).withValues(alpha: 0.35),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE53935),
          ),
        ),
      ),
    );
  }
}

class _RatingSection extends StatelessWidget {
  const _RatingSection({required this.levelIndex, required this.onChanged});

  final int levelIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How would you rate your pain?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (var i = 0; i < _levels.length; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: _FaceOption(
                  level: _levels[i],
                  index: i + 1,
                  selected: levelIndex == i,
                  onTap: () => onChanged(i),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _FaceOption extends StatelessWidget {
  const _FaceOption({
    required this.level,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final _PainLevel level;
  final int index;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          color: selected ? AppColors.softPink : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.magenta : Colors.transparent,
            width: 1.6,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: level.color.withValues(alpha: 0.14),
                border: selected
                    ? Border.all(color: AppColors.magenta, width: 2)
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(level.emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 6),
            Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: selected ? AppColors.magenta : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              level.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9.5,
                height: 1.15,
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.magenta : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssessmentCard extends StatelessWidget {
  const _AssessmentCard({
    required this.badgeLabel,
    required this.badgeColor,
    required this.assessmentText,
  });

  final String badgeLabel;
  final Color badgeColor;
  final String assessmentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softPink,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.magenta.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.health_and_safety_rounded,
                  color: AppColors.magenta,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Our Assessment',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.burgundy,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: badgeColor),
                    const SizedBox(width: 3),
                    Text(
                      badgeLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: badgeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            assessmentText,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.magenta,
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'If pain worsens or you notice any other concerning symptoms, '
                  'please contact your doctor.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.burgundy,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecommendationRow extends StatelessWidget {
  const _RecommendationRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.blush,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.magenta, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AppColors.textDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
