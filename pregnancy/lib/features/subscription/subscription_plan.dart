import 'package:flutter/material.dart';

enum PlanTier { premium, standard, basic }

class SubscriptionPlan {
  const SubscriptionPlan({
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

  final PlanTier tier;
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

  static List<SubscriptionPlan> forJourney(String journeyId) {
    final copy = _JourneyPlanCopy.forId(journeyId);
    return [
      SubscriptionPlan(
        tier: PlanTier.premium,
        title: 'Premium Plan',
        monthlyPriceLabel: '999',
        yearlyPriceLabel: '9590',
        description: copy.premiumDescription,
        features: copy.premiumFeatures,
        icon: Icons.workspace_premium_rounded,
        accent: const Color(0xFFC24D7F),
        iconBg: const Color(0xFFFCE4EC),
        badge: 'MOST POPULAR',
      ),
      SubscriptionPlan(
        tier: PlanTier.standard,
        title: 'Standard Plan',
        monthlyPriceLabel: '499',
        yearlyPriceLabel: '4790',
        description: copy.standardDescription,
        features: copy.standardFeatures,
        icon: Icons.star_rounded,
        accent: const Color(0xFF9B7BB8),
        iconBg: const Color(0xFFF0E8F8),
      ),
      SubscriptionPlan(
        tier: PlanTier.basic,
        title: 'Basic Plan',
        monthlyPriceLabel: '0',
        yearlyPriceLabel: '0',
        description: copy.basicDescription,
        features: copy.basicFeatures,
        icon: Icons.favorite_rounded,
        accent: const Color(0xFF5BA88A),
        iconBg: const Color(0xFFE4F5EE),
      ),
    ];
  }
}

class JourneySubscriptionInfo {
  const JourneySubscriptionInfo({
    required this.id,
    required this.roleLabel,
    required this.roleIcon,
  });

  final String id;
  final String roleLabel;
  final IconData roleIcon;

  static JourneySubscriptionInfo forId(String id) {
    switch (id) {
      case 'bride':
        return const JourneySubscriptionInfo(
          id: 'bride',
          roleLabel: 'Bride-to-Be',
          roleIcon: Icons.diamond_outlined,
        );
      case 'pregnant':
        return const JourneySubscriptionInfo(
          id: 'pregnant',
          roleLabel: 'Pregnant woman',
          roleIcon: Icons.pregnant_woman_rounded,
        );
      case 'new_mother':
        return const JourneySubscriptionInfo(
          id: 'new_mother',
          roleLabel: 'New Mother',
          roleIcon: Icons.child_care_rounded,
        );
      case 'partner':
        return const JourneySubscriptionInfo(
          id: 'partner',
          roleLabel: 'Husband / Partner',
          roleIcon: Icons.favorite_rounded,
        );
      case 'mother_in_law':
        return const JourneySubscriptionInfo(
          id: 'mother_in_law',
          roleLabel: 'Mother / Mother-in-law',
          roleIcon: Icons.groups_rounded,
        );
      case 'miscarriage_support':
        return const JourneySubscriptionInfo(
          id: 'miscarriage_support',
          roleLabel: 'Seeking Miscarriage Support',
          roleIcon: Icons.favorite_border_rounded,
        );
      default:
        return JourneySubscriptionInfo(
          id: id,
          roleLabel: 'Sehat Maa member',
          roleIcon: Icons.person_rounded,
        );
    }
  }
}

class _JourneyPlanCopy {
  const _JourneyPlanCopy({
    required this.premiumDescription,
    required this.standardDescription,
    required this.basicDescription,
    required this.premiumFeatures,
    required this.standardFeatures,
    required this.basicFeatures,
  });

  final String premiumDescription;
  final String standardDescription;
  final String basicDescription;
  final List<String> premiumFeatures;
  final List<String> standardFeatures;
  final List<String> basicFeatures;

  static _JourneyPlanCopy forId(String journeyId) {
    switch (journeyId) {
      case 'bride':
        return const _JourneyPlanCopy(
          premiumDescription:
              'Everything you need to prepare for marriage and a healthy future.',
          standardDescription:
              'Essential features for your bridal wellness journey.',
          basicDescription: 'Start preparing with basic support.',
          premiumFeatures: [
            'All premium features',
            'AI Health Assistant',
            'Report Scanner (Unlimited)',
            'Doctor Consultations (3 / month)',
            'Personalized Diet & Exercise',
            'Family & Partner Access',
          ],
          standardFeatures: [
            'Pre-wedding wellness tips',
            'Diet & Exercise plans',
            'Reminders & Trackers',
            'Basic Reports Scanner',
            'Community Support',
          ],
          basicFeatures: [
            'Weekly tips & articles',
            'Reminders',
            'Emergency guidance',
            'Community access',
          ],
        );
      case 'new_mother':
        return const _JourneyPlanCopy(
          premiumDescription:
              'Everything you need for you and your baby in the first months.',
          standardDescription:
              'Essential features for postpartum care and recovery.',
          basicDescription: 'Start your motherhood journey with basic support.',
          premiumFeatures: [
            'All premium features',
            'AI Health Assistant',
            'Report Scanner (Unlimited)',
            'Doctor Consultations (3 / month)',
            'Personalized Diet & Exercise',
            'Family & Partner Access',
          ],
          standardFeatures: [
            'Postpartum recovery guidance',
            'Diet & Exercise plans',
            'Reminders & Trackers',
            'Basic Reports Scanner',
            'Community Support',
          ],
          basicFeatures: [
            'Weekly tips & articles',
            'Reminders',
            'Emergency guidance',
            'Community access',
          ],
        );
      case 'miscarriage_support':
        return const _JourneyPlanCopy(
          premiumDescription:
              'Everything you need for comprehensive emotional and physical recovery support.',
          standardDescription:
              'Essential features for your recovery and healing journey.',
          basicDescription: 'Start your healing journey with basic support.',
          premiumFeatures: [
            'All premium features',
            'AI Health Assistant',
            'Report Scanner (Unlimited)',
            'Doctor Consultations (3 / month)',
            'Personalized Healing Nutrition',
            'Family & Partner Access',
          ],
          standardFeatures: [
            'Healing & recovery milestones',
            'Diet & self-care plans',
            'Reminders & Trackers',
            'Basic Reports Scanner',
            'Community Support',
          ],
          basicFeatures: [
            'Weekly tips & articles',
            'Reminders',
            'Emergency guidance',
            'Community access',
          ],
        );
      case 'partner':
        return const _JourneyPlanCopy(
          premiumDescription:
              'Everything you need to support your partner through every stage.',
          standardDescription:
              'Essential features to stay involved and supportive.',
          basicDescription: 'Start supporting with basic guidance.',
          premiumFeatures: [
            'All premium features',
            'AI Health Assistant',
            'Report Scanner (Unlimited)',
            'Doctor Consultations (3 / month)',
            'Partner guidance & tips',
            'Family Access',
          ],
          standardFeatures: [
            'Partner support guidance',
            'Shared reminders',
            'Trackers',
            'Basic Reports Scanner',
            'Community Support',
          ],
          basicFeatures: [
            'Weekly tips & articles',
            'Reminders',
            'Emergency guidance',
            'Community access',
          ],
        );
      case 'mother_in_law':
        return const _JourneyPlanCopy(
          premiumDescription:
              'Everything you need to guide and care for your loved ones.',
          standardDescription:
              'Essential features to support family with confidence.',
          basicDescription: 'Start guiding with basic support tools.',
          premiumFeatures: [
            'All premium features',
            'AI Health Assistant',
            'Report Scanner (Unlimited)',
            'Doctor Consultations (3 / month)',
            'Family care guidance',
            'Family Access',
          ],
          standardFeatures: [
            'Family support tips',
            'Care reminders',
            'Trackers',
            'Basic Reports Scanner',
            'Community Support',
          ],
          basicFeatures: [
            'Weekly tips & articles',
            'Reminders',
            'Emergency guidance',
            'Community access',
          ],
        );
      case 'pregnant':
      default:
        return const _JourneyPlanCopy(
          premiumDescription:
              'Everything you need for a healthy pregnancy and beyond.',
          standardDescription:
              'Essential features for your pregnancy journey.',
          basicDescription: 'Start your journey with basic support.',
          premiumFeatures: [
            'All premium features',
            'AI Health Assistant',
            'Report Scanner (Unlimited)',
            'Doctor Consultations (3 / month)',
            'Personalized Diet & Exercise',
            'Family & Partner Access',
          ],
          standardFeatures: [
            'Week-by-week guidance',
            'Diet & Exercise plans',
            'Reminders & Trackers',
            'Basic Reports Scanner',
            'Community Support',
          ],
          basicFeatures: [
            'Weekly tips & articles',
            'Reminders',
            'Emergency guidance',
            'Community access',
          ],
        );
    }
  }
}
