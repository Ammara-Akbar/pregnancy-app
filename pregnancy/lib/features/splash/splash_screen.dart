import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 2800), _goToOnboarding);
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeIn,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Soft floral / blush background
            DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF8FA),
                    AppColors.softPink,
                    AppColors.blush,
                    Color(0xFFE8C4D2),
                  ],
                  stops: [0.0, 0.35, 0.65, 1.0],
                ),
              ),
            ),
            // Soft light bloom behind illustration
            Positioned(
              top: size.height * 0.28,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: size.width * 0.85,
                  height: size.width * 0.85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.95),
                        Colors.white.withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Decorative floating petals / bokeh
            ..._buildBokeh(size),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.06),
                  _buildBrandHeader(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: Image.asset(
                        'assets/images/pregnant_woman.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.18),
                ],
              ),
            ),
            // Burgundy wave footer
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.22,
                child: CustomPaint(
                  painter: _WavePainter(),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 28),
                        const Text(
                          'صحت مند ماں، صحت مند نسل',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Icon(
                          Icons.favorite,
                          color: AppColors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE89AB8), AppColors.magenta], 
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x33C24D7F),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CustomPaint(painter: _PregnantSilhouettePainter()),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Sehat Maa',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppColors.burgundy,
            height: 1.1,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 180,
          child: Row(
            children: [
              Expanded(
                child: Container(height: 1, color: AppColors.magenta),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.favorite,
                  size: 14,
                  color: AppColors.magenta,
                ),
              ),
              Expanded(
                child: Container(height: 1, color: AppColors.magenta),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Your Pregnancy & Motherhood Companion',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.burgundyDeep,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBokeh(Size size) {
    final specs = <(double, double, double, double)>[
      (0.08, 0.18, 28, 0.25),
      (0.78, 0.14, 36, 0.22),
      (0.12, 0.42, 18, 0.3),
      (0.85, 0.38, 22, 0.28),
      (0.05, 0.55, 14, 0.2),
      (0.9, 0.52, 16, 0.22),
    ];
    return [
      for (final (x, y, d, a) in specs)
        Positioned(
          left: size.width * x,
          top: size.height * y,
          child: Container(
            width: d,
            height: d,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: a),
            ),
          ),
        ),
    ];
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.burgundy;

    final path = Path()
      ..moveTo(0, size.height * 0.28)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.02,
        size.width * 0.5,
        size.height * 0.22,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.42,
        size.width,
        size.height * 0.18,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Soft upper rim for layered wave feel
    final rimPaint = Paint()..color = const Color(0xFF8B3A62);
    final rim = Path()
      ..moveTo(0, size.height * 0.22)
      ..quadraticBezierTo(
        size.width * 0.22,
        size.height * -0.02,
        size.width * 0.48,
        size.height * 0.18,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.38,
        size.width,
        size.height * 0.12,
      )
      ..lineTo(size.width, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.42,
        size.width * 0.5,
        size.height * 0.28,
      )
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.02,
        0,
        size.height * 0.28,
      )
      ..close();

    canvas.drawPath(rim, rimPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PregnantSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Head
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width * 0.52, size.height * 0.22),
        radius: size.width * 0.14,
      ),
    );
    // Body / belly silhouette
    path.moveTo(size.width * 0.38, size.height * 0.36);
    path.quadraticBezierTo(
      size.width * 0.22,
      size.height * 0.55,
      size.width * 0.32,
      size.height * 0.88,
    );
    path.lineTo(size.width * 0.72, size.height * 0.88);
    path.quadraticBezierTo(
      size.width * 0.92,
      size.height * 0.58,
      size.width * 0.68,
      size.height * 0.36,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
