import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../bride/bride_plan_overview_screen.dart';

class JourneyOption {
  const JourneyOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.imageAsset,
  });  

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String imageAsset;
}

class JourneySelectionScreen extends StatefulWidget {
  const JourneySelectionScreen({super.key});

  @override
  State<JourneySelectionScreen> createState() => _JourneySelectionScreenState();
}

class _JourneySelectionScreenState extends State<JourneySelectionScreen> {
  String? _selectedId;

  static const _options = [
    JourneyOption(
      id: 'bride',
      title: 'Bride-to-Be',
      description: 'Preparing for marriage and a healthy future.',
      icon: Icons.diamond,
      imageAsset: 'assets/images/journey_bride.png',
    ),
    JourneyOption(
      id: 'pregnant',
      title: "I'm Pregnant",
      description: 'Get week-by-week guidance for you and your baby.',
      icon: Icons.pregnant_woman_rounded,
      imageAsset: 'assets/images/journey_pregnant.png',
    ),
    JourneyOption(
      id: 'new_mother',
      title: 'New Mother',
      description: 'Care for your newborn and take care of yourself.',
      icon: Icons.child_care_rounded,
      imageAsset: 'assets/images/journey_new_mother.png',
    ),
    JourneyOption(
      id: 'partner',
      title: 'Husband / Partner',
      description: 'Support your partner and be part of the journey.',
      icon: Icons.favorite_rounded,
      imageAsset: 'assets/images/journey_partner.png',
    ),
    JourneyOption(
      id: 'mother_in_law',
      title: 'Mother / Mother-in-law',
      description: 'Guide and support your loved ones with care.',
      icon: Icons.groups_rounded,
      imageAsset: 'assets/images/journey_mother_in_law.png',
    ),
    JourneyOption(
      id: 'womens_health',
      title: "Women's Health",
      description: 'Take charge of your health and well-being.',
      icon: Icons.add_box_outlined,
      imageAsset: 'assets/images/journey_womens_health.png',
    ),
  ];

  void _onSelect(JourneyOption option) {
    setState(() => _selectedId = option.id);
  }

  void _onNext() {
    if (_selectedId == 'bride') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const BridePlanOverviewScreen()),
      );
      return;
    }

    final selected = _options.firstWhere((o) => o.id == _selectedId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Continuing as ${selected.title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = _selectedId != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FA),
      body: Stack(
        children: [
          const _BackgroundLeaves(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Column(
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Where are you on your\n',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3A55),
                              height: 1.25,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(
                                text: 'motherhood journey?',
                                style: TextStyle(color: AppColors.magenta),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Everyone's journey is unique. We'll personalize your experience just for you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.textMuted,
                            height: 1.45,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                        const SizedBox(height: 22),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final spacing = 12.0;
                            final cardWidth =
                                (constraints.maxWidth - spacing) / 2;
                            return Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              children: [
                                for (final option in _options)
                                  SizedBox(
                                    width: cardWidth,
                                    child: _JourneyCard(
                                      option: option,
                                      selected: _selectedId == option.id,
                                      onTap: () => _onSelect(option),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              axisAlignment: -1,
                              child: child,
                            ),
                          );
                        },
                        child: hasSelection
                            ? Padding(
                                key: const ValueKey('next-button'),
                                padding: const EdgeInsets.only(bottom: 12),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: ElevatedButton(
                                    onPressed: _onNext,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.burgundyDeep,
                                      foregroundColor: AppColors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                        fontFamily: 'sans-serif',
                                      ),
                                    ),
                                    child: const Text('Next'),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('next-hidden'),
                              ),
                      ),
                      _PrivacyBanner(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Privacy details coming soon'),
                            ),
                          );
                        },
                      ),
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

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final JourneyOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: selected ? 3 : 1.5,
      shadowColor: AppColors.magenta.withValues(alpha: 0.18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.magenta : const Color(0xFFF0E4EA),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blush.withValues(alpha: 0.7),
                ),
                child: Icon(option.icon, size: 16, color: AppColors.magenta),
              ),
              const SizedBox(height: 6),
              Center(
                child: SizedBox(
                  height: 88,
                  child: Image.asset(
                    option.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                option.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                  height: 1.2,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                option.description,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                  height: 1.35,
                  fontFamily: 'sans-serif',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacyBanner extends StatelessWidget {
  const _PrivacyBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFCE8EF),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.magenta,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.health_and_safety_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your privacy is our priority',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'We keep your data safe and secure, always.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textMuted,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.skipGrey,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundLeaves extends StatelessWidget {
  const _BackgroundLeaves();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _LeafPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class _LeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF3D0DC).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    // Soft leaf-like blobs in corners
    canvas.drawOval(
      Rect.fromLTWH(-30, -20, 120, 100),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.width - 90, -10, 110, 90),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(-40, size.height - 140, 130, 110),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.width - 100, size.height - 160, 120, 100),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
