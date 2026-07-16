import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingPageData(
      titleTop: "We're with you,",
      titleBottom: 'every step of the way',
      subtitle: 'From preparing for pregnancy to parenting your little one.',
      showOrbit: true,
    ),
    _OnboardingPageData(
      titleTop: 'Track every moment,',
      titleBottom: 'celebrate every milestone',
      subtitle: 'Log symptoms, appointments, and baby kicks in one calm place.',
      showOrbit: false,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  void _goToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.softPink,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.skipGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  return _OnboardingPage(data: _pages[index]);
                },
              ),
            ),
            _PageDots(
              count: _pages.length,
              index: _currentPage,
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
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
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13.5,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: _goToLogin,
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: AppColors.magenta,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: math.max(bottomInset, 18)),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.titleTop,
    required this.titleBottom,
    required this.subtitle,
    required this.showOrbit,
  });

  final String titleTop;
  final String titleBottom;
  final String subtitle;
  final bool showOrbit;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final _OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 4),
          Text(
            data.titleTop,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
          Text(
            data.titleBottom,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.magenta,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: data.showOrbit
                ? const _FeatureOrbit()
                : Center(
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blush,
                        border: Border.all(
                          color: AppColors.ringPink,
                          width: 3,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/pregnant_body_week.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FeatureOrbit extends StatelessWidget {
  const _FeatureOrbit();

  static const _features = [
    _OrbitItem(
      label: 'Track your journey',
      icon: Icons.calendar_month_rounded,
      color: AppColors.iconCalendar,
      angleDeg: -90,
    ),
    _OrbitItem(
      label: 'Baby growth & care',
      icon: Icons.child_care_rounded,
      color: AppColors.iconBaby,
      angleDeg: -18,
    ),
    _OrbitItem(
      label: 'Family support',
      icon: Icons.groups_rounded,
      color: AppColors.iconFamily,
      angleDeg: 54,
    ),
    _OrbitItem(
      label: 'Reminders & medications',
      icon: Icons.medication_rounded,
      color: AppColors.iconMedicine,
      angleDeg: 126,
    ),
    _OrbitItem(
      label: 'Personalized health plans',
      icon: Icons.favorite_rounded,
      color: AppColors.iconHealth,
      angleDeg: 198,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = math.min(constraints.maxWidth, constraints.maxHeight);
        final orbitSize = side * 0.92;
        final centerSize = orbitSize * 0.42;
        final iconSize = orbitSize * 0.18;
        final radius = orbitSize * 0.38;

        return Center(
          child: SizedBox(
            width: orbitSize,
            height: orbitSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Soft ring
                Container(
                  width: orbitSize * 0.78,
                  height: orbitSize * 0.78,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.ringPink.withValues(alpha: 0.65),
                      width: 1.5,
                    ),
                  ),
                ),
                // Center illustration
                Container(
                  width: centerSize,
                  height: centerSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blush,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.magenta.withValues(alpha: 0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/pregnant_body_week.png',
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.2),
                  ),
                ),
                // Orbiting feature chips
                for (final item in _features)
                  Transform.translate(
                    offset: Offset(
                      radius * math.cos(item.angleDeg * math.pi / 180),
                      radius * math.sin(item.angleDeg * math.pi / 180),
                    ),
                    child: _OrbitChip(
                      item: item,
                      size: iconSize,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrbitItem {
  const _OrbitItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.angleDeg,
  });

  final String label;
  final IconData icon;
  final Color color;
  final double angleDeg;
}

class _OrbitChip extends StatelessWidget {
  const _OrbitChip({required this.item, required this.size});

  final _OrbitItem item;
  final double size;

  @override
  Widget build(BuildContext context) {
    final labelAbove = item.angleDeg < -45 || item.angleDeg > 180;

    final icon = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(item.icon, color: item.color, size: size * 0.48),
    );

    final label = SizedBox(
      width: 96,
      child: Text(
        item.label,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(
          fontSize: 10.5,
          height: 1.2,
          color: AppColors.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: labelAbove
          ? [label, const SizedBox(height: 6), icon]
          : [icon, const SizedBox(height: 6), label],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 10 : 8,
          height: active ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.magenta : AppColors.ringPink,
          ),
        );
      }),
    );
  }
}
