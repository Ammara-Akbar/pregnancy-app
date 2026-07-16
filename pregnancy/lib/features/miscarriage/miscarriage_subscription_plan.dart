import 'package:flutter/material.dart';

enum MiscarriagePlanTier { premium, standard, basic }

class MiscarriageSubscriptionPlan {
  const MiscarriageSubscriptionPlan({
    required this.tier,
    required this.title,
    required this.monthlyPriceLabel,
    required this.yearlyPriceLabel,
    required this.description,
    required this.features,
    required this.icon,
    required this.accent,
    required this.iconBg,
    this.badge,
  });

  final MiscarriagePlanTier tier;
  final String title;
  final String monthlyPriceLabel;
  final String yearlyPriceLabel;
  final String description;
  final List<String> features;
  final IconData icon;
  final Color accent;
  final Color iconBg;
  final String? badge;

  String priceLabel({required bool yearly}) =>
      yearly ? yearlyPriceLabel : monthlyPriceLabel;

  String periodLabel({required bool yearly}) => yearly ? 'year' : 'month';

  static const List<MiscarriageSubscriptionPlan> all = [
    MiscarriageSubscriptionPlan(
      tier: MiscarriagePlanTier.premium,
      title: 'Premium Plan',
      monthlyPriceLabel: '999',
      yearlyPriceLabel: '9590',
      description:
          'Everything you need for comprehensive emotional and physical recovery support.',
      features: [
        'All premium features',
        'AI Health Assistant',
        'Report Scanner (Unlimited)',
        'Doctor Consultations (3 / month)',
        'Personalized Healing Nutrition',
        'Family & Partner Access',
      ],
      icon: Icons.workspace_premium_rounded,
      accent: Color(0xFFC24D7F),
      iconBg: Color(0xFFFCE4EC),
      badge: 'MOST POPULAR',
    ),
    MiscarriageSubscriptionPlan(
      tier: MiscarriagePlanTier.standard,
      title: 'Standard Plan',
      monthlyPriceLabel: '499',
      yearlyPriceLabel: '4790',
      description: 'Essential features for your recovery and healing journey.',
      features: [
        'Healing & recovery milestones',
        'Diet & self-care plans',
        'Reminders & Trackers',
        'Basic Reports Scanner',
        'Community Support',
      ],
      icon: Icons.star_rounded,
      accent: Color(0xFF9B7BB8),
      iconBg: Color(0xFFF0E8F8),
    ),
    MiscarriageSubscriptionPlan(
      tier: MiscarriagePlanTier.basic,
      title: 'Basic Plan',
      monthlyPriceLabel: '0',
      yearlyPriceLabel: '0',
      description: 'Start your healing journey with basic support.',
      features: [
        'Weekly tips & articles',
        'Reminders',
        'Emergency guidance',
        'Community access',
      ],
      icon: Icons.favorite_rounded,
      accent: Color(0xFF5BA88A),
      iconBg: Color(0xFFE4F5EE),
    ),
  ];
}
