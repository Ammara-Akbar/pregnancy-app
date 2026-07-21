import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_kick_counter_screen.dart';

class PregnantKickAwarenessScreen extends StatelessWidget {
  const PregnantKickAwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        title: const Text(
          'Kick Awareness',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const _HeroCard(),
            const SizedBox(height: 16),
            const _SectionTitle('Why kicks matter'),
            const SizedBox(height: 10),
            const _InfoCard(
              icon: Icons.favorite_rounded,
              iconColor: AppColors.magenta,
              text:
                  "Your baby's movements are a sign of their wellbeing. "
                  'Getting to know their daily pattern helps you notice '
                  'quickly if something changes.',
            ),
            const SizedBox(height: 16),
            const _SectionTitle('How to count kicks'),
            const SizedBox(height: 10),
            const _StepCard(
              number: 1,
              title: 'Pick a quiet time',
              description:
                  'Babies are often most active after meals or in the '
                  'evening. Try to count around the same time each day.',
            ),
            const SizedBox(height: 8),
            const _StepCard(
              number: 2,
              title: 'Get comfortable',
              description:
                  'Lie on your left side or sit with your feet up. This '
                  'position makes it easier to feel movements.',
            ),
            const SizedBox(height: 8),
            const _StepCard(
              number: 3,
              title: 'Count to 10',
              description:
                  'Note how long it takes to feel 10 movements — kicks, '
                  'rolls, flutters and jabs all count. Most babies take '
                  'less than 2 hours.',
            ),
            const SizedBox(height: 16),
            const _SectionTitle('Good to know'),
            const SizedBox(height: 10),
            const _InfoCard(
              icon: Icons.schedule_rounded,
              iconColor: AppColors.iconHealth,
              text:
                  'Most women start feeling movements between weeks 16 and '
                  '24. Movements grow stronger and more regular from '
                  'week 28.',
            ),
            const SizedBox(height: 8),
            const _InfoCard(
              icon: Icons.nights_stay_outlined,
              iconColor: AppColors.iconBaby,
              text:
                  'Babies have sleep cycles of 20–40 minutes, so short '
                  'quiet spells are normal. It is the overall daily pattern '
                  'that matters.',
            ),
            const SizedBox(height: 16),
            const _WarningCard(),
            const SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PregnantKickCounterScreen(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.tag_faces_outlined),
                label: const Text(
                  'Start Counting Kicks',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/kick_awareness_hero.png',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Notice your baby, every day',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.burgundy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'A few relaxed minutes a day is all it takes to learn your '
            "baby's unique movement pattern.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  final IconData icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.magenta,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: AppColors.textMuted,
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

class _WarningCard extends StatelessWidget {
  const _WarningCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ringPink),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.burgundy,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Call your doctor or midwife if',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.burgundy,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _WarningRow('Your baby is moving much less than usual'),
          SizedBox(height: 6),
          _WarningRow('You feel no movements by week 24'),
          SizedBox(height: 6),
          _WarningRow("Movements suddenly stop or the pattern changes"),
        ],
      ),
    );
  }
}

class _WarningRow extends StatelessWidget {
  const _WarningRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.circle, size: 6, color: AppColors.magenta),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              fontWeight: FontWeight.w600,
              color: AppColors.burgundy,
            ),
          ),
        ),
      ],
    );
  }
}
