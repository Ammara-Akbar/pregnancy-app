import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_hospital_bag_shopping_screen.dart';

class _BagItem {
  _BagItem(this.label, {this.packed = false});

  final String label;
  bool packed;
}

class _BagCategory {
  _BagCategory({
    required this.title,
    required this.icon,
    required this.items,
    this.expanded = true,
  });

  final String title;
  final IconData icon;
  final List<_BagItem> items;
  bool expanded;

  int get packedCount => items.where((item) => item.packed).length;
  int get totalCount => items.length;
}

class PregnantHospitalBagScreen extends StatefulWidget {
  const PregnantHospitalBagScreen({super.key});

  @override
  State<PregnantHospitalBagScreen> createState() =>
      _PregnantHospitalBagScreenState();
}

class _PregnantHospitalBagScreenState extends State<PregnantHospitalBagScreen> {
  int _tab = 0;

  final List<_BagCategory> _momCategories = [
    _BagCategory(
      title: 'Documents & Essentials',
      icon: Icons.description_outlined,
      items: [
        _BagItem('ID Card / Passport', packed: true),
        _BagItem('Health Insurance Card', packed: true),
        _BagItem('Prenatal Records / Reports', packed: true),
        _BagItem('Birth Plan Copies', packed: true),
        _BagItem('Hospital Registration Papers'),
        _BagItem('Emergency Contact List'),
      ],
    ),
    _BagCategory(
      title: 'Clothing & Comfort',
      icon: Icons.checkroom_outlined,
      items: [
        _BagItem('Night Gowns / Loose Dresses', packed: true),
        _BagItem('Robe or Shawl', packed: true),
        _BagItem('Socks & Slippers', packed: true),
        _BagItem('Nursing Bras & Pads'),
        _BagItem('Going-home Outfit'),
      ],
    ),
    _BagCategory(
      title: 'Toiletries & Personal Care',
      icon: Icons.spa_outlined,
      items: [
        _BagItem('Toothbrush & Toothpaste', packed: true),
        _BagItem('Lip Balm', packed: true),
        _BagItem('Hairbrush / Hair Ties', packed: true),
        _BagItem('Face Wash & Moisturizer', packed: true),
        _BagItem('Maternity Pads'),
        _BagItem('Towels'),
        _BagItem('Deodorant'),
      ],
    ),
    _BagCategory(
      title: 'Extras for Mom',
      icon: Icons.favorite_outline_rounded,
      expanded: false,
      items: [
        _BagItem('Phone Charger'),
        _BagItem('Snacks & Water Bottle'),
        _BagItem('Eyeglasses / Contacts'),
        _BagItem('Comfort Pillow'),
      ],
    ),
  ];

  final List<_BagCategory> _babyCategories = [
    _BagCategory(
      title: 'Clothing for Baby',
      icon: Icons.checkroom_outlined,
      items: [
        _BagItem('Onesies / Bodysuits', packed: true),
        _BagItem('Sleepsuits', packed: true),
        _BagItem('Baby Hat & Mittens'),
        _BagItem('Socks / Booties'),
        _BagItem('Going-home Outfit'),
      ],
    ),
    _BagCategory(
      title: 'Diapering & Care',
      icon: Icons.baby_changing_station_rounded,
      items: [
        _BagItem('Newborn Diapers', packed: true),
        _BagItem('Baby Wipes', packed: true),
        _BagItem('Diaper Cream'),
        _BagItem('Swaddle Blankets'),
        _BagItem('Burp Cloths'),
      ],
    ),
    _BagCategory(
      title: 'Feeding & Safety',
      icon: Icons.child_care_rounded,
      expanded: false,
      items: [
        _BagItem('Bottles (if needed)'),
        _BagItem('Nursing Cover'),
        _BagItem('Car Seat Installed'),
        _BagItem('Baby Blanket'),
      ],
    ),
  ];

  List<_BagCategory> get _categories =>
      _tab == 0 ? _momCategories : _babyCategories;

  int get _packed => _categories
      .expand((category) => category.items)
      .where((item) => item.packed)
      .length;

  int get _total => _categories.expand((category) => category.items).length;

  double get _progress => _total == 0 ? 0 : _packed / _total;

  void _showInfo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'Hospital Bag Tips',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.burgundy,
          ),
        ),
        content: const Text(
          'Pack your bag around week 36. Keep documents on top, and leave the '
          'car seat installed in the car before labor begins.',
          style: TextStyle(height: 1.4, color: AppColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: AppColors.magenta,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSummary() {
    final unpacked = _categories
        .expand((category) => category.items)
        .where((item) => !item.packed)
        .map((item) => item.label)
        .toList();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.ringPink,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  _tab == 0 ? 'Mom Bag Summary' : 'Baby Bag Summary',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.burgundy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$_packed of $_total items packed · '
                  '${(_progress * 100).round()}% ready',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                if (unpacked.isEmpty)
                  const Text(
                    'Everything is packed. You are ready!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.burgundy,
                    ),
                  )
                else ...[
                  const Text(
                    'Still to pack',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.burgundy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (final item in unpacked.take(8))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.magenta,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.magenta,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openShoppingList() async {
    final added = await Navigator.of(context).push<List<String>>(
      MaterialPageRoute(
        builder: (_) => PregnantHospitalBagShoppingScreen(forBaby: _tab == 1),
      ),
    );
    if (added == null || added.isEmpty || !mounted) return;

    final categories = _categories;
    if (categories.isEmpty) return;

    final target = categories.firstWhere(
      (category) =>
          category.title.contains('Extras') ||
          category.title.contains('Care') ||
          category.title.contains('Safety'),
      orElse: () => categories.last,
    );

    var addedCount = 0;
    setState(() {
      target.expanded = true;
      for (final label in added) {
        final exists = target.items.any(
          (item) => item.label.toLowerCase() == label.toLowerCase(),
        );
        if (!exists) {
          target.items.add(_BagItem(label));
          addedCount++;
        }
      }
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.magenta,
        content: Text(
          addedCount == 0
              ? 'Those items are already on your checklist'
              : 'Added $addedCount item${addedCount == 1 ? '' : 's'} to your checklist',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F8),
      floatingActionButton: FloatingActionButton(
        heroTag: 'hospital_bag_shopping_fab',
        onPressed: _openShoppingList,
        backgroundColor: AppColors.magenta,
        child: const Icon(Icons.shopping_bag_outlined, color: AppColors.white),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5F8),
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'Hospital Bag Checklist',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 2),
            Text(
              'Be prepared, stay confident. You\'ve got this!',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showInfo,
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
                children: [
                  const _HeroCard(),
                  const SizedBox(height: 14),
                  _MomBabyTabs(
                    selected: _tab,
                    onChanged: (index) => setState(() => _tab = index),
                  ),
                  const SizedBox(height: 14),
                  for (var i = 0; i < _categories.length; i++) ...[
                    _CategoryCard(
                      category: _categories[i],
                      onToggleExpand: () => setState(
                        () =>
                            _categories[i].expanded = !_categories[i].expanded,
                      ),
                      onToggleItem: (itemIndex) => setState(
                        () => _categories[i].items[itemIndex].packed =
                            !_categories[i].items[itemIndex].packed,
                      ),
                    ),
                    if (i < _categories.length - 1) const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 70),
                ],
              ),
            ),
            _ProgressFooter(progress: _progress, onViewSummary: _showSummary),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/images/hospital_bag_hero.png',
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stackTrace) => Container(
                width: 88,
                height: 88,
                color: AppColors.white,
                child: const Icon(
                  Icons.work_outline_rounded,
                  color: AppColors.magenta,
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.favorite_rounded,
                  color: AppColors.magenta,
                  size: 16,
                ),
                SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    text: 'Prepare your hospital bag',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.burgundy,
                    ),
                    children: [
                      TextSpan(
                        text:
                            ' in advance for a stress-free delivery experience.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
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

class _MomBabyTabs extends StatelessWidget {
  const _MomBabyTabs({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabChip(
              icon: Icons.pregnant_woman_rounded,
              label: 'For Mom',
              selected: selected == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _TabChip(
              icon: Icons.child_care_rounded,
              label: 'For Baby',
              selected: selected == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColors.magenta : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? AppColors.white : AppColors.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: selected ? AppColors.white : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.onToggleExpand,
    required this.onToggleItem,
  });

  final _BagCategory category;
  final VoidCallback onToggleExpand;
  final ValueChanged<int> onToggleItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggleExpand,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
              child: Row(
                children: [
                  Icon(category.icon, color: AppColors.magenta, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.magenta,
                      ),
                    ),
                  ),
                  Text(
                    '${category.packedCount}/${category.totalCount}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Icon(
                    category.expanded
                        ? Icons.expand_less_rounded
                        : Icons.chevron_right_rounded,
                    color: AppColors.skipGrey,
                  ),
                ],
              ),
            ),
          ),
          if (category.expanded) ...[
            const Divider(height: 1, color: Color(0xFFF3E8ED)),
            for (var i = 0; i < category.items.length; i++)
              _ChecklistRow(
                item: category.items[i],
                onTap: () => onToggleItem(i),
                showDivider: i < category.items.length - 1,
              ),
          ],
        ],
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.item,
    required this.onTap,
    required this.showDivider,
  });

  final _BagItem item;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.packed ? AppColors.magenta : Colors.transparent,
                    border: Border.all(
                      color: item.packed
                          ? AppColors.magenta
                          : AppColors.skipGrey,
                      width: item.packed ? 0 : 1.6,
                    ),
                  ),
                  child: item.packed
                      ? const Icon(
                          Icons.check_rounded,
                          size: 15,
                          color: AppColors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      decoration: item.packed
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, indent: 50, color: Color(0xFFF3E8ED)),
      ],
    );
  }
}

class _ProgressFooter extends StatelessWidget {
  const _ProgressFooter({required this.progress, required this.onViewSummary});

  final double progress;
  final VoidCallback onViewSummary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: AppColors.softPink,
        border: Border(top: BorderSide(color: AppColors.mistPink)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/hospital_bag_hero.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stackTrace) => const Icon(
                Icons.work_outline_rounded,
                color: AppColors.magenta,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Your bag is ',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: AppColors.magenta,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const TextSpan(text: ' ready'),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: AppColors.ringPink,
                    color: AppColors.magenta,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: onViewSummary,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.magenta,
              side: const BorderSide(color: AppColors.ringPink),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'View Summary',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
