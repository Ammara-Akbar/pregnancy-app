import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_baby_size.dart';

class PregnantBabySizeScreen extends StatelessWidget {
  const PregnantBabySizeScreen({
    super.key,
    required this.weeksPregnant,
    required this.fruitName,
    required this.sizeLabel,
    required this.imageAsset,
  });

  final int weeksPregnant;
  final String fruitName;
  final String sizeLabel;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final detail = PregnantBabySize.forWeek(weeksPregnant);

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
          'Baby size',
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imageAsset,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Week $weeksPregnant',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.magenta,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'About the size of a $fruitName',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  sizeLabel,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  detail.blurb,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF4A3A42),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'This week',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 10),
          const _InfoCard(
            title: 'Growth',
            body:
                'Baby continues developing organs, senses, and strength. Measurements vary — your scan is the best guide.',
          ),
          const _InfoCard(
            title: 'What you may feel',
            body:
                'Energy changes, mild aches, or stronger kicks depending on your trimester. Track anything unusual with your doctor.',
          ),
          const _InfoCard(
            title: 'Gentle tip',
            body:
                'Talk, play soft music, and keep up hydration + prenatal vitamins as advised by your clinician.',
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.magenta,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF4A3A42),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
