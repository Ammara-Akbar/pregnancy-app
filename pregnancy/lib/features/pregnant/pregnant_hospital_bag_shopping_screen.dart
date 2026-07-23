import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _ShopItem {
  _ShopItem(this.label);

  final String label;
  bool bought = false;
  bool added = false;
}

class PregnantHospitalBagShoppingScreen extends StatefulWidget {
  const PregnantHospitalBagShoppingScreen({super.key, this.forBaby = false});

  final bool forBaby;

  @override
  State<PregnantHospitalBagShoppingScreen> createState() =>
      _PregnantHospitalBagShoppingScreenState();
}

class _PregnantHospitalBagShoppingScreenState
    extends State<PregnantHospitalBagShoppingScreen> {
  final _controller = TextEditingController();

  late final List<_ShopItem> _suggestions = widget.forBaby
      ? [
          _ShopItem('Newborn diapers (size N)'),
          _ShopItem('Baby wipes'),
          _ShopItem('Onesies (0–3 months)'),
          _ShopItem('Swaddle blankets'),
          _ShopItem('Baby hat & mittens'),
          _ShopItem('Going-home outfit'),
          _ShopItem('Diaper cream'),
          _ShopItem('Soft receiving blankets'),
        ]
      : [
          _ShopItem('Maternity pads'),
          _ShopItem('Nursing bras'),
          _ShopItem('Comfortable nightgowns'),
          _ShopItem('Slippers'),
          _ShopItem('Lip balm'),
          _ShopItem('Phone charger / power bank'),
          _ShopItem('Snacks for labor'),
          _ShopItem('Large water bottle'),
        ];

  final List<_ShopItem> _custom = [];

  List<_ShopItem> get _allItems => [..._suggestions, ..._custom];

  int get _boughtCount => _allItems.where((item) => item.bought).length;
  int get _toBuyCount => _allItems.where((item) => !item.bought).length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addCustom() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _custom.add(_ShopItem(text));
      _controller.clear();
    });
  }

  void _finish() {
    final addedLabels = _allItems
        .where((item) => item.added || item.bought)
        .map((item) => item.label)
        .toList();
    Navigator.of(context).pop(addedLabels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5F8),
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: Text(
          widget.forBaby ? 'Baby Shopping List' : 'Mom Shopping List',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        actions: [
          TextButton(
            onPressed: _finish,
            child: const Text(
              'Done',
              style: TextStyle(
                color: AppColors.magenta,
                fontWeight: FontWeight.w800,
              ),
            ),
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
                  _ShoppingHero(
                    forBaby: widget.forBaby,
                    toBuy: _toBuyCount,
                    bought: _boughtCount,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.mistPink),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _addCustom(),
                            decoration: InputDecoration(
                              hintText: 'Add your own item...',
                              filled: true,
                              fillColor: AppColors.softPink,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Material(
                          color: AppColors.magenta,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: _addCustom,
                            borderRadius: BorderRadius.circular(12),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.add_rounded,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Suggested to buy',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.burgundy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tap an item to mark it bought, or add it to your bag list.',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 10),
                  for (final item in _allItems) ...[
                    _ShoppingItemCard(
                      item: item,
                      onToggleBought: () =>
                          setState(() => item.bought = !item.bought),
                      onToggleAdded: () =>
                          setState(() => item.added = !item.added),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.mistPink)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.burgundy,
                        side: const BorderSide(color: AppColors.ringPink),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: _finish,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.magenta,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.playlist_add_check_rounded),
                      label: const Text(
                        'Add to Checklist',
                        style: TextStyle(fontWeight: FontWeight.w800),
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

class _ShoppingHero extends StatelessWidget {
  const _ShoppingHero({
    required this.forBaby,
    required this.toBuy,
    required this.bought,
  });

  final bool forBaby;
  final int toBuy;
  final int bought;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.magenta, AppColors.burgundyDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              forBaby ? Icons.child_care_rounded : Icons.shopping_bag_outlined,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forBaby
                      ? 'Shop for baby essentials'
                      : 'Shop for mom essentials',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$toBuy to buy · $bought bought',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.mistPink,
                    fontWeight: FontWeight.w600,
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

class _ShoppingItemCard extends StatelessWidget {
  const _ShoppingItemCard({
    required this.item,
    required this.onToggleBought,
    required this.onToggleAdded,
  });

  final _ShopItem item;
  final VoidCallback onToggleBought;
  final VoidCallback onToggleAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.bought ? AppColors.ringPink : AppColors.mistPink,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onToggleBought,
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.bought ? AppColors.magenta : Colors.transparent,
                border: Border.all(
                  color: item.bought ? AppColors.magenta : AppColors.skipGrey,
                  width: item.bought ? 0 : 1.6,
                ),
              ),
              child: item.bought
                  ? const Icon(
                      Icons.check_rounded,
                      size: 15,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
                decoration: item.bought ? TextDecoration.lineThrough : null,
                decorationColor: AppColors.textMuted,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onToggleAdded,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: item.added ? AppColors.blush : AppColors.softPink,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: item.added ? AppColors.magenta : AppColors.mistPink,
                ),
              ),
              child: Text(
                item.added ? 'Added' : 'Add',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: item.added ? AppColors.magenta : AppColors.burgundy,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
