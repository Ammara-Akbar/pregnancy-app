import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _spinController;
  late final Animation<double> _fadeIn;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
    _navTimer = Timer(const Duration(milliseconds: 2800), _goToOnboarding);
  }

  void _goToOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const OnboardingScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _fadeController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      body: FadeTransition(
        opacity: _fadeIn,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF8FA),
                    Color(0xFFFFF0F5),
                    Color(0xFFFFFBFC),
                    Color(0xFFFCE4EC),
                  ],
                  stops: [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),
            const Positioned.fill(child: _SplashLeaves()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.32,
                child: CustomPaint(painter: _BottomWavePainter()),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(28, 24, 28, 20 + bottom * 0.2),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Image.asset(
                      'assets/images/sehat_maa_logo.png',
                      width: size.width * 0.55,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/logo.png',
                          width: size.width * 0.55,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: 168,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color(0xFFD4C0C8),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.favorite,
                              size: 13,
                              color: AppColors.magenta,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color(0xFFD4C0C8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Guidance. Support. Care.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4A3A42),
                        letterSpacing: 0.2,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'For every step of motherhood.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.magenta,
                        letterSpacing: 0.15,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(flex: 3),
                    RotationTransition(
                      turns: _spinController,
                      child: const _DotSpinner(),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Preparing your personalized experience...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFB0A0A8),
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotSpinner extends StatelessWidget {
  const _DotSpinner();

  @override
  Widget build(BuildContext context) {
    const count = 8;
    const radius = 12.0;
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(count, (i) {
          final angle = (2 * math.pi / count) * i - math.pi / 2;
          final t = i / count;
          final opacity = 0.25 + (0.75 * (1 - t));
          return Transform.translate(
            offset: Offset(
              radius * math.cos(angle),
              radius * math.sin(angle),
            ),
            child: Container(
              width: 5.5,
              height: 5.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.magenta.withValues(alpha: opacity),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.85);

    final path = Path()
      ..moveTo(0, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.18,
        size.width * 0.5,
        size.height * 0.38,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.58,
        size.width,
        size.height * 0.32,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SplashLeaves extends StatelessWidget {
  const _SplashLeaves();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _SplashLeafPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class _SplashLeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8B8C8).withValues(alpha: 0.42)
      ..style = PaintingStyle.fill;

    _drawBranch(
      canvas,
      paint,
      origin: Offset(-6, size.height * 0.06),
      angle: 0.6,
      scale: 1.15,
    );
    _drawBranch(
      canvas,
      paint,
      origin: Offset(size.width + 8, size.height * 0.72),
      angle: math.pi + 0.45,
      scale: 1.1,
    );
  }

  void _drawBranch(
    Canvas canvas,
    Paint paint, {
    required Offset origin,
    required double angle,
    required double scale,
  }) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.rotate(angle);
    canvas.scale(scale);

    final stem = Paint()
      ..color = paint.color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final stemPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(30, -8, 70, 6);
    canvas.drawPath(stemPath, stem);

    final leafOffsets = <(double, double, double)>[
      (16, -12, -0.55),
      (32, 10, 0.5),
      (46, -14, -0.4),
      (60, 8, 0.55),
      (74, -6, -0.25),
    ];

    for (final (x, y, rot) in leafOffsets) {
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);
      final leaf = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(12, -8, 26, 0)
        ..quadraticBezierTo(12, 8, 0, 0)
        ..close();
      canvas.drawPath(leaf, paint);
      canvas.restore();
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
