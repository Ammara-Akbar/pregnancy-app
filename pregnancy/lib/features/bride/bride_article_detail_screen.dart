import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_articles_screen.dart';

class BrideArticleDetailScreen extends StatelessWidget {
  const BrideArticleDetailScreen({super.key, required this.article});

  final BrideArticle article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFFFFF5F7),
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Color(0xFF2C3A55),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                article.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.blush,
                  child: const Icon(
                    Icons.article_outlined,
                    size: 48,
                    color: AppColors.magenta,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCE8EF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      article.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.magenta,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.readTime,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.subtitle,
                    style: const TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF5A4A52),
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Divider(color: Color(0xFFF0E4EA)),
                  const SizedBox(height: 18),
                  Text(
                    article.body,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4A3A42),
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
