import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantPainAssessmentScreen extends StatefulWidget {
  const PregnantPainAssessmentScreen({super.key});

  @override
  State<PregnantPainAssessmentScreen> createState() =>
      _PregnantPainAssessmentScreenState();
}

class _PregnantPainAssessmentScreenState
    extends State<PregnantPainAssessmentScreen> {
  static const _locations = [
    'Lower Abdomen',
    'Lower Back',
    'Pelvic Area',
    'Others',
  ];
  static const _types = ['Dull Ache', 'Sharp Pain', 'Cramping', 'Pressuring'];

  String _location = 'Lower Abdomen';
  String _type = 'Cramping';

  void _showGuidance() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Guidance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.burgundy,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$_type in the ${_location.toLowerCase()} is common during '
              'pregnancy, often caused by your body stretching and adjusting.',
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Rest, hydrate, and change positions slowly. If the pain is '
              'severe, persistent, or comes with bleeding, fever, or reduced '
              'baby movement, contact your doctor right away.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Pain Assessment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Describe your pain to get guidance',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where do you feel the pain?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _BodyFigure(location: _location),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          children: [
                            for (final location in _locations)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: _SelectCard(
                                  label: location,
                                  selected: _location == location,
                                  onTap: () =>
                                      setState(() => _location = location),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How would you describe the pain?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _SelectCard(
                          label: _types[0],
                          selected: _type == _types[0],
                          onTap: () => setState(() => _type = _types[0]),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SelectCard(
                          label: _types[1],
                          selected: _type == _types[1],
                          onTap: () => setState(() => _type = _types[1]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _SelectCard(
                          label: _types[2],
                          selected: _type == _types[2],
                          onTap: () => setState(() => _type = _types[2]),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SelectCard(
                          label: _types[3],
                          selected: _type == _types[3],
                          onTap: () => setState(() => _type = _types[3]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: _showGuidance,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Next',
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

class _SelectCard extends StatelessWidget {
  const _SelectCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.softPink : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.magenta : AppColors.mistPink,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.magenta : AppColors.skipGrey,
                  width: selected ? 4 : 1.5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.magenta : AppColors.textDark,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_rounded,
                size: 15,
                color: AppColors.magenta,
              ),
          ],
        ),
      ),
    );
  }
}

class _BodyFigure extends StatelessWidget {
  const _BodyFigure({required this.location});

  final String location;

  // Vertical alignment of the pain marker within the body illustration,
  // expressed as Alignment y values (-1 top, 1 bottom).
  static const _dotAlignment = <String, Alignment>{
    'Lower Abdomen': Alignment(0, -0.06),
    'Lower Back': Alignment(0, -0.16),
    'Pelvic Area': Alignment(0, 0.06),
    'Others': Alignment(0, -0.42),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122,
      height: 209,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/pain_body_silhouette.png',
            fit: BoxFit.cover,
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            alignment: _dotAlignment[location] ?? Alignment.center,
            child: const _PainDot(),
          ),
        ],
      ),
    );
  }
}

class _PainDot extends StatelessWidget {
  const _PainDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.magenta.withValues(alpha: 0.18),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.magenta.withValues(alpha: 0.35),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.magenta,
          ),
        ),
      ),
    );
  }
}
