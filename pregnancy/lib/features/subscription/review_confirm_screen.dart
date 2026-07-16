import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import '../bride/bride_home_shell.dart';
import '../miscarriage/miscarriage_home_shell.dart';
import '../new_mother/new_mother_home_shell.dart';
import '../pregnant/pregnant_home_shell.dart';
import 'choose_plan_screen.dart';
import 'subscription_plan.dart';

class ReviewConfirmScreen extends StatelessWidget {
  const ReviewConfirmScreen({
    super.key,
    required this.journeyId,
    required this.selectedPlan,
    required this.yearly,
    required this.userName,
    this.weeksPregnant,
    this.daysPostpartum,
  });

  final String journeyId;
  final SubscriptionPlan selectedPlan;
  final bool yearly;
  final String userName;
  final int? weeksPregnant;
  final int? daysPostpartum;

  static const _benefitIcons = [
    Icons.card_giftcard_rounded,
    Icons.auto_awesome_rounded,
    Icons.description_outlined,
    Icons.medical_services_outlined,
    Icons.restaurant_rounded,
    Icons.groups_rounded,
  ];

  void _continueToApp(BuildContext context) {
    final name = userName;

    switch (journeyId) {
      case 'bride':
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => BrideHomeShell(userName: name)),
          (route) => false,
        );
        return;
      case 'pregnant':
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => PregnantHomeShell(
              userName: name,
              weeksPregnant: weeksPregnant ?? 12,
            ),
          ),
          (route) => false,
        );
        return;
      case 'new_mother':
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => NewMotherHomeShell(
              userName: name,
              daysPostpartum: daysPostpartum ?? 14,
            ),
          ),
          (route) => false,
        );
        return;
      case 'miscarriage_support':
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => MiscarriageHomeShell(userName: name),
          ),
          (route) => false,
        );
        return;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This journey home is coming soon.'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        final bottom = MediaQuery.paddingOf(context).bottom;
        final isFree = selectedPlan.tier == PlanTier.basic;
        final price = selectedPlan.priceLabel(yearly: yearly);
        final period = selectedPlan.periodLabel(yearly: yearly);
        final money = UserPreferences.instance.region.formatMoney(price);
        final totalLabel = isFree ? 'Free' : '$money / $period';
        final journey = JourneySubscriptionInfo.forId(journeyId);

        return Scaffold(
          backgroundColor: const Color(0xFFFFF8FA),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Review & ',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            TextSpan(
                              text: 'confirm',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColors.magenta,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You are almost done! Review your selections and continue.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _SummaryRow(
                              iconBg: const Color(0xFFF0E8F8),
                              iconColor: const Color(0xFF9B7BB8),
                              icon: journey.roleIcon,
                              label: 'I am a',
                              value: journey.roleLabel,
                              onEdit: () {
                                Navigator.of(context).popUntil(
                                  (route) =>
                                      route.isFirst ||
                                      route.settings.name ==
                                          'journey_selection',
                                );
                              },
                            ),
                            const Divider(height: 1, color: Color(0xFFF0E4EA)),
                            _SummaryRow(
                              iconBg: selectedPlan.iconBg,
                              iconColor: selectedPlan.accent,
                              icon: selectedPlan.icon,
                              label: 'Plan',
                              value: selectedPlan.title,
                              onEdit: () {
                                Navigator.of(context).popUntil(
                                  (route) =>
                                      route.settings.name ==
                                          ChoosePlanScreen.routeName ||
                                      route.isFirst,
                                );
                              },
                            ),
                            const Divider(height: 1, color: Color(0xFFF0E4EA)),
                            _SummaryRow(
                              iconBg: const Color(0xFFE4F5EE),
                              iconColor: const Color(0xFF5BA88A),
                              icon: Icons.public_rounded,
                              label: 'Content style',
                              value: UserPreferences.instance.region.shortLabel,
                              onEdit: () {
                                Navigator.of(context).popUntil(
                                  (route) =>
                                      route.isFirst ||
                                      route.settings.name ==
                                          'journey_selection',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'With ${selectedPlan.title} you get:',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            const SizedBox(height: 14),
                            for (var i = 0;
                                i < selectedPlan.features.length;
                                i++) ...[
                              _BenefitRow(
                                text: selectedPlan.features[i],
                                trailingIcon:
                                    _benefitIcons[i % _benefitIcons.length],
                              ),
                              if (i < selectedPlan.features.length - 1)
                                const SizedBox(height: 12),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCE8EF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.verified_user_rounded,
                              color: AppColors.magenta,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your data is safe with us',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2C3A55),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'We use industry-standard security to protect your personal information.',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppColors.textMuted,
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                          Text(
                            totalLabel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.magenta,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFFFF8FA),
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 12 + bottom),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => _continueToApp(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.magenta,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text('Continue to App'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Cancel anytime',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _StepDots(activeIndex: 3, count: 4),
                    ],
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.value,
    required this.onEdit,
  });

  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.magenta,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Edit',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.text, required this.trailingIcon});

  final String text;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_rounded,
          size: 18,
          color: AppColors.magenta,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A3A42),
              height: 1.3,
            ),
          ),
        ),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFFCE8EF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(trailingIcon, size: 18, color: AppColors.magenta),
        ),
      ],
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 9 : 7,
          height: active ? 9 : 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.magenta : AppColors.ringPink,
          ),
        );
      }),
    );
  }
}
