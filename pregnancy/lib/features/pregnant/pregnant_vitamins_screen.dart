import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _Vitamin {
  const _Vitamin({
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.dailyAmount,
    required this.benefit,
    required this.sources,
  });

  final String name;
  final IconData icon;
  final Color iconColor;
  final String dailyAmount;
  final String benefit;
  final String sources;
}

const _vitamins = [
  _Vitamin(
    name: 'Folic Acid',
    icon: Icons.eco_rounded,
    iconColor: AppColors.iconHealth,
    dailyAmount: '600 mcg',
    benefit: "Prevents birth defects of baby's brain and spine.",
    sources: 'Leafy greens, lentils, fortified cereals',
  ),
  _Vitamin(
    name: 'Iron',
    icon: Icons.bolt_rounded,
    iconColor: AppColors.iconMedicine,
    dailyAmount: '27 mg',
    benefit: 'Supports extra blood supply and prevents anemia.',
    sources: 'Red meat, beans, spinach, dried fruit',
  ),
  _Vitamin(
    name: 'Calcium',
    icon: Icons.local_drink_rounded,
    iconColor: AppColors.iconBaby,
    dailyAmount: '1000 mg',
    benefit: "Builds baby's bones and protects your own.",
    sources: 'Milk, yogurt, cheese, tofu',
  ),
  _Vitamin(
    name: 'Vitamin D',
    icon: Icons.wb_sunny_rounded,
    iconColor: AppColors.iconCalendar,
    dailyAmount: '600 IU',
    benefit: 'Helps absorb calcium and supports immunity.',
    sources: 'Sunlight, fortified milk, eggs, fish',
  ),
  _Vitamin(
    name: 'Omega-3 (DHA)',
    icon: Icons.set_meal_rounded,
    iconColor: AppColors.iconFamily,
    dailyAmount: '200-300 mg',
    benefit: "Develops baby's brain and eyes.",
    sources: 'Low-mercury fish, walnuts, chia seeds',
  ),
  _Vitamin(
    name: 'Vitamin C',
    icon: Icons.brightness_low_rounded,
    iconColor: AppColors.magenta,
    dailyAmount: '85 mg',
    benefit: 'Boosts immunity and helps iron absorption.',
    sources: 'Oranges, strawberries, tomatoes, peppers',
  ),
];

class PregnantVitaminsScreen extends StatelessWidget {
  const PregnantVitaminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Vitamins',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Your daily nutrients for a healthy pregnancy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/vitamins_hero.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '6 Key Nutrients',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'These vitamins and minerals matter most during '
                          'pregnancy. Tap a card to see why.',
                          style: TextStyle(
                            fontSize: 11.5,
                            height: 1.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            for (final vitamin in _vitamins) _VitaminCard(vitamin: vitamin),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.blush,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 20,
                    color: AppColors.magenta,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tip\nA good prenatal vitamin covers most of these, but '
                      'food sources matter too. Always confirm doses with '
                      'your doctor before adding supplements.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.5,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VitaminCard extends StatefulWidget {
  const _VitaminCard({required this.vitamin});

  final _Vitamin vitamin;

  @override
  State<_VitaminCard> createState() => _VitaminCardState();
}

class _VitaminCardState extends State<_VitaminCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final vitamin = widget.vitamin;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _expanded ? AppColors.magenta : AppColors.mistPink,
          width: _expanded ? 1.3 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: vitamin.iconColor.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      vitamin.icon,
                      size: 22,
                      color: vitamin.iconColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vitamin.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${vitamin.dailyAmount} daily',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.magenta,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.skipGrey,
                  ),
                ],
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vitamin.benefit,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.softPink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Find it in: ${vitamin.sources}',
                          style: const TextStyle(
                            fontSize: 11,
                            height: 1.4,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
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
