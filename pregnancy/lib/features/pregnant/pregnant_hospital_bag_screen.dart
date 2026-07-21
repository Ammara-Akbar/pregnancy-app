import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _BagSection {
  _BagSection({required this.title, required this.icon, required this.items});

  final String title;
  final IconData icon;
  final Map<String, bool> items;
}

class PregnantHospitalBagScreen extends StatefulWidget {
  const PregnantHospitalBagScreen({super.key});

  @override
  State<PregnantHospitalBagScreen> createState() =>
      _PregnantHospitalBagScreenState();
}

class _PregnantHospitalBagScreenState extends State<PregnantHospitalBagScreen> {
  final List<_BagSection> _sections = [
    _BagSection(
      title: 'For Mom',
      icon: Icons.pregnant_woman_rounded,
      items: {
        'Comfortable nightgowns': true,
        'Nursing bras & pads': true,
        'Toiletries & lip balm': false,
        'Slippers & warm socks': false,
        'Going-home outfit': false,
        'Maternity pads': false,
      },
    ),
    _BagSection(
      title: 'For Baby',
      icon: Icons.child_care_rounded,
      items: {
        'Onesies & sleepsuits': true,
        'Swaddle blankets': false,
        'Newborn diapers': true,
        'Baby hat & mittens': false,
        'Going-home outfit': false,
        'Car seat installed': false,
      },
    ),
    _BagSection(
      title: 'Documents & Extras',
      icon: Icons.description_outlined,
      items: {
        'ID & insurance card': true,
        'Hospital file / records': false,
        'Birth plan copies': false,
        'Phone charger': false,
        'Snacks & water bottle': false,
      },
    ),
  ];

  int get _packed => _sections
      .expand((section) => section.items.values)
      .where((isPacked) => isPacked)
      .length;

  int get _total => _sections.expand((section) => section.items.values).length;

  @override
  Widget build(BuildContext context) {
    final progress = _packed / _total;
    final allPacked = _packed == _total;

    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Hospital Bag',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Pack everything you need for the big day',
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
                    'assets/images/hospital_bag_hero.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Packing Progress',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '$_packed',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.burgundy,
                            ),
                            children: [
                              TextSpan(
                                text: ' of $_total items',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 9,
                            backgroundColor: AppColors.ringPink,
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.magenta,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          allPacked
                              ? 'All packed - you are ready!'
                              : '${(progress * 100).round()}% packed',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: allPacked
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: allPacked
                                ? AppColors.magenta
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            for (final section in _sections) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.mistPink),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: AppColors.blush,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              section.icon,
                              size: 19,
                              color: AppColors.magenta,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            section.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${section.items.values.where((v) => v).length}'
                            '/${section.items.length}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.magenta,
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (final item in section.items.keys)
                      CheckboxListTile(
                        value: section.items[item],
                        onChanged: (checked) {
                          setState(
                            () => section.items[item] = checked ?? false,
                          );
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: AppColors.magenta,
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        title: Text(
                          item,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: section.items[item]!
                                ? AppColors.skipGrey
                                : AppColors.textDark,
                            decoration: section.items[item]!
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: AppColors.skipGrey,
                          ),
                        ),
                      ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ],
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
                      'Tip\nHave your bag ready by week 36. Keep it near the '
                      'door and tell your partner where it is.',
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
