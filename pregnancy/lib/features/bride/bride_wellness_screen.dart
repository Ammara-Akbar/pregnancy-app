import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_articles_screen.dart';
import 'bride_diet_nutrition_screen.dart';

class BrideWellnessScreen extends StatelessWidget {
  const BrideWellnessScreen({super.key});

  static const _guides = [
    (
      Icons.self_improvement_rounded,
      'Exercise & Yoga',
      'Easy 15–20 min routines for energy and posture.',
      Color(0xFF66BB6A),
    ),
    (
      Icons.spa_outlined,
      'Skin & Glow Care',
      'Simple routines and habits for bridal radiance.',
      Color(0xFFE07A4A),
    ),
    (
      Icons.water_drop_outlined,
      'Period & Hormonal Health',
      'Track your cycle and support hormonal balance.',
      Color(0xFF5BA8D9),
    ),
    (
      Icons.psychology_alt_outlined,
      'Stress & Sleep',
      'Calm your mind during wedding preparations.',
      Color(0xFF9B7BB8),
    ),
    (
      Icons.science_outlined,
      'Health Checkups',
      'Know which pre-marriage tests matter most.',
      Color(0xFF4CAF7A),
    ),
    (
      Icons.favorite_outline,
      'Partner Wellness Tips',
      'Build healthy habits together before marriage.',
      Color(0xFFC24D7F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          'Bride Wellness Hub',
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Useful for every bride',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Quick access to nutrition, articles, fitness, and health guidance for your pre-marriage journey.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _QuickLink(
                  icon: Icons.restaurant_rounded,
                  label: 'Diet Plans',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BrideDietNutritionScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _QuickLink(
                  icon: Icons.menu_book_rounded,
                  label: 'Articles',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BrideArticlesScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Explore Guides',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          for (final guide in _guides) ...[
            _GuideTile(
              icon: guide.$1,
              title: guide.$2,
              subtitle: guide.$3,
              color: guide.$4,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${guide.$2} coming soon')),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF0E4EA)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.magenta, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideTile extends StatelessWidget {
  const _GuideTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.skipGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
