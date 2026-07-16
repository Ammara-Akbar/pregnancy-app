import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_article_detail_screen.dart';

class BrideArticle {
  const BrideArticle({
    required this.title,
    required this.subtitle,
    required this.readTime,
    required this.category,
    required this.imageAsset,
    required this.body,
  });

  final String title;
  final String subtitle;
  final String readTime;
  final String category;
  final String imageAsset;
  final String body;
}

const brideArticles = [
  BrideArticle(
    title: '10 Tips for a Healthy Pre-Marriage Lifestyle',
    subtitle: 'Simple daily habits for energy, glow, and confidence.',
    readTime: '5 min read',
    category: 'Lifestyle',
    imageAsset: 'assets/images/journey_bride.png',
    body:
        'Preparing for marriage is the perfect time to invest in your health. '
        'Start with consistent sleep, balanced meals, light exercise, and '
        'regular hydration. Add folic acid after consulting your doctor, '
        'limit junk food, and make time for rest so you feel your best on '
        'your wedding day and beyond.',
  ),
  BrideArticle(
    title: 'Pre-Marriage Health Tests Every Bride Should Know',
    subtitle: 'A clear checklist before you meet your doctor.',
    readTime: '6 min read',
    category: 'Health',
    imageAsset: 'assets/images/bride_plan_hero.png',
    body:
        'Important screenings often include hemoglobin, blood group, '
        'thalassemia screening, blood sugar, thyroid (TSH), vitamin D, '
        'and rubella immunity. Talk to your doctor about which tests are '
        'right for you, keep copies of reports, and schedule follow-ups '
        'early so there is no last-minute stress.',
  ),
  BrideArticle(
    title: 'Foods That Help You Glow Before Your Wedding',
    subtitle: 'Nourish your skin from the inside out.',
    readTime: '4 min read',
    category: 'Nutrition',
    imageAsset: 'assets/images/tip_salad.png',
    body:
        'Include colorful fruits, leafy greens, nuts, yogurt, and plenty of '
        'water. Vitamin C foods support collagen, while omega-3 sources like '
        'walnuts and fish help skin stay calm and hydrated. Cut excess sugar '
        'and fried snacks a few weeks before the wedding for clearer skin.',
  ),
  BrideArticle(
    title: 'Gentle Yoga Moves for Busy Brides',
    subtitle: 'Stay flexible and calm with a 15-minute routine.',
    readTime: '5 min read',
    category: 'Fitness',
    imageAsset: 'assets/images/floral_encouragement.png',
    body:
        'Try cat-cow, gentle twists, forward folds, and deep breathing when '
        'you feel overwhelmed by wedding planning. Even 15 minutes a day can '
        'ease back tension, improve posture for bridal photos, and help you '
        'sleep better. Stop if anything feels painful and modify as needed.',
  ),
  BrideArticle(
    title: 'Managing Stress During Wedding Prep',
    subtitle: 'Protect your mental wellbeing while planning.',
    readTime: '4 min read',
    category: 'Wellness',
    imageAsset: 'assets/images/tip_almonds.png',
    body:
        'Break big tasks into small daily goals, share responsibilities with '
        'family, and keep one non-negotiable self-care habit—like a short '
        'walk or evening tea without your phone. Talk openly with someone you '
        'trust if anxiety rises, and remember rest is productive too.',
  ),
];

class BrideArticlesScreen extends StatelessWidget {
  const BrideArticlesScreen({super.key});

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
          'Articles for You',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        itemCount: brideArticles.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final article = brideArticles[index];
          return _ArticleListCard(
            article: article,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BrideArticleDetailScreen(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ArticleListCard extends StatelessWidget {
  const _ArticleListCard({required this.article, required this.onTap});

  final BrideArticle article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE8EF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        article.category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.magenta,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.readTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  article.imageAsset,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 72,
                    height: 72,
                    color: AppColors.blush,
                    child: const Icon(
                      Icons.article_outlined,
                      color: AppColors.magenta,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
