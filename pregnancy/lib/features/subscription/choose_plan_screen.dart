import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import '../bride/bride_plan_overview_screen.dart';
import '../miscarriage/miscarriage_plan_overview_screen.dart';
import '../new_mother/new_mother_plan_overview_screen.dart';
import '../pregnant/pregnant_plan_overview_screen.dart';
import 'review_confirm_screen.dart';
import 'subscription_plan.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key, required this.journeyId});

  final String journeyId;

  static const routeName = 'choose_plan';

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  bool _yearly = false;
  PlanTier _selected = PlanTier.premium;

  late final List<SubscriptionPlan> _plans =
      SubscriptionPlan.forJourney(widget.journeyId);

  SubscriptionPlan get _selectedPlan =>
      _plans.firstWhere((p) => p.tier == _selected);

  void _onNext() {
    final journeyId = widget.journeyId;
    final plan = _selectedPlan;
    final yearly = _yearly;

    switch (journeyId) {
      case 'bride':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BridePlanOverviewScreen(
              selectedPlan: plan,
              yearly: yearly,
            ),
          ),
        );
        return;
      case 'pregnant':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PregnantPlanOverviewScreen(
              selectedPlan: plan,
              yearly: yearly,
            ),
          ),
        );
        return;
      case 'new_mother':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NewMotherPlanOverviewScreen(
              selectedPlan: plan,
              yearly: yearly,
            ),
          ),
        );
        return;
      case 'miscarriage_support':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MiscarriagePlanOverviewScreen(
              selectedPlan: plan,
              yearly: yearly,
            ),
          ),
        );
        return;
      default:
        // Partner / mother-in-law: skip unfinished overview & go to review.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReviewConfirmScreen(
              journeyId: journeyId,
              selectedPlan: plan,
              yearly: yearly,
              userName: 'Ayesha',
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) => _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

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
                          text: 'Choose your ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                        TextSpan(
                          text: 'plan',
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
                    'Select a plan that fits your needs. You can change anytime.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: _BillingToggle(
                      yearly: _yearly,
                      onChanged: (yearly) => setState(() => _yearly = yearly),
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (final plan in _plans) ...[
                    _PlanCard(
                      plan: plan,
                      yearly: _yearly,
                      selected: plan.tier == _selected,
                      onTap: () => setState(() => _selected = plan.tier),
                    ),
                    const SizedBox(height: 14),
                  ],
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
                      onPressed: _onNext,
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
                      child: const Text('Next'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _StepDots(activeIndex: 0, count: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BillingToggle extends StatelessWidget {
  const _BillingToggle({required this.yearly, required this.onChanged});

  final bool yearly;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E4EA),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleChip(
            label: 'Monthly',
            selected: !yearly,
            onTap: () => onChanged(false),
          ),
          _ToggleChip(
            label: 'Yearly',
            selected: yearly,
            onTap: () => onChanged(true),
            badge: 'Save 20%',
          ),
        ],
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.magenta : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.white : const Color(0xFF6A5A62),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2EAA6A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.yearly,
    required this.selected,
    required this.onTap,
  });

  final SubscriptionPlan plan;
  final bool yearly;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isFree = plan.tier == PlanTier.basic;
    final price = plan.priceLabel(yearly: yearly);
    final period = plan.periodLabel(yearly: yearly);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? plan.accent : const Color(0xFFE8DDE2),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? plan.accent.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plan.badge != null) ...[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.magenta,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    plan.badge!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: plan.iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(plan.icon, color: plan.accent, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (isFree)
                        const Text(
                          'Free',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C3A55),
                          ),
                        )
                      else
                        Text(
                          '${UserPreferences.instance.region.formatMoney(price)} / $period',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? plan.accent : Colors.transparent,
                    border: Border.all(
                      color: selected
                          ? plan.accent
                          : plan.accent.withValues(alpha: 0.45),
                      width: 2,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              plan.description,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            for (final feature in plan.features) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: plan.accent,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A3A42),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
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
