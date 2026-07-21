import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
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
                color: Color(0xFF251064),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$_type in the ${_location.toLowerCase()} is common during '
              'pregnancy, often caused by your body stretching and adjusting.',
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF4E416A),
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
                color: Color(0xFF4E416A),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFF73573),
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
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
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
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 18),
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
                    'Where do you feel the pain?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF251064),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 220,
                        child: CustomPaint(
                          painter: _BodyPainter(location: _location),
                        ),
                      ),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How would you describe the pain?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF251064),
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
                  backgroundColor: const Color(0xFFF73573),
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
          color: selected ? const Color(0xFFFFF2F6) : const Color(0xFFFFF8FB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFFF73573) : const Color(0xFFF0E5EB),
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
                  color: selected
                      ? const Color(0xFFF73573)
                      : const Color(0xFFCBBFC7),
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
                  color: selected
                      ? const Color(0xFFDD3D74)
                      : const Color(0xFF4E416A),
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_rounded,
                size: 15,
                color: Color(0xFFF73573),
              ),
          ],
        ),
      ),
    );
  }
}

class _BodyPainter extends CustomPainter {
  const _BodyPainter({required this.location});

  final String location;

  @override
  void paint(Canvas canvas, Size size) {
    final body = Paint()..color = const Color(0xFFF6DCE8);
    final outline = Paint()
      ..color = const Color(0xFFE9BED3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final centerX = size.width / 2;
    final path = Path()
      // Head
      ..addOval(
        Rect.fromCircle(
          center: Offset(centerX, size.height * 0.09),
          radius: size.height * 0.07,
        ),
      )
      // Torso
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(centerX, size.height * 0.38),
            width: size.width * 0.52,
            height: size.height * 0.42,
          ),
          const Radius.circular(26),
        ),
      )
      // Left leg
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(centerX - size.width * 0.13, size.height * 0.78),
            width: size.width * 0.2,
            height: size.height * 0.42,
          ),
          const Radius.circular(16),
        ),
      )
      // Right leg
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(centerX + size.width * 0.13, size.height * 0.78),
            width: size.width * 0.2,
            height: size.height * 0.42,
          ),
          const Radius.circular(16),
        ),
      );

    canvas.drawPath(path, body);
    canvas.drawPath(path, outline);

    // Pain highlight
    final highlightCenter = switch (location) {
      'Lower Back' => Offset(centerX, size.height * 0.46),
      'Pelvic Area' => Offset(centerX, size.height * 0.58),
      'Others' => Offset(centerX, size.height * 0.3),
      _ => Offset(centerX, size.height * 0.52),
    };
    canvas.drawCircle(
      highlightCenter,
      size.width * 0.16,
      Paint()..color = const Color(0xFFF73573).withValues(alpha: 0.25),
    );
    canvas.drawCircle(
      highlightCenter,
      size.width * 0.07,
      Paint()..color = const Color(0xFFF73573).withValues(alpha: 0.55),
    );
  }

  @override
  bool shouldRepaint(covariant _BodyPainter oldDelegate) =>
      oldDelegate.location != location;
}
