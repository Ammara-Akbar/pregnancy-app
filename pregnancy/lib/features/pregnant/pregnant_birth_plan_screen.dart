import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantBirthPlanScreen extends StatefulWidget {
  const PregnantBirthPlanScreen({super.key});

  @override
  State<PregnantBirthPlanScreen> createState() =>
      _PregnantBirthPlanScreenState();
}

class _PregnantBirthPlanScreenState extends State<PregnantBirthPlanScreen> {
  String _delivery = 'Vaginal Delivery';
  String _painRelief = 'Epidural';

  final Map<String, String> _labor = {
    'I would like updates about my labor progress.': 'Yes',
    'I want to move around during labor.': 'Yes',
    'I prefer dim lights and a quiet environment.': 'Yes',
    'I want my partner / support person with me.': 'Yes',
  };

  final Map<String, String> _deliveryPrefs = {
    'I would like immediate skin-to-skin contact.': 'Yes',
    'I want delayed cord clamping (if possible).': 'Yes',
    'Who do you want in the delivery room?': 'Partner',
  };

  final Map<String, String> _after = {
    'I plan to breastfeed.': 'Yes',
    'I want my baby to stay with me.': 'Yes',
  };

  static const _yesNo = ['Yes', 'No', 'Undecided'];
  static const _roomPeople = ['Partner', 'Family', 'Doula', 'Just me'];

  Future<void> _pickValue({
    required String title,
    required String current,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.burgundy,
                  ),
                ),
                const SizedBox(height: 10),
                for (final option in options)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      option,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: option == current
                            ? AppColors.magenta
                            : AppColors.textDark,
                      ),
                    ),
                    trailing: option == current
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.magenta,
                          )
                        : null,
                    onTap: () => Navigator.pop(context, option),
                  ),
              ],
            ),
          ),
        );
      },
    );
    if (selected != null) onSelected(selected);
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.magenta,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Birth plan saved! You can share it with your care team.',
        ),
      ),
    );
  }

  void _share() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.burgundy,
        behavior: SnackBarBehavior.floating,
        content: Text('Share sheet ready — connect sharing when needed.'),
      ),
    );
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
        title: const Column(
          children: [
            Text(
              'Birth Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 2),
            Text(
              'Plan your preferences and share with your doctor.',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _save,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.magenta,
              side: const BorderSide(color: AppColors.ringPink),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              visualDensity: VisualDensity.compact,
            ),
            child: const Text(
              'Save Plan',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
          children: [
            const _HeroCard(),
            const SizedBox(height: 14),
            _SectionCard(
              number: 1,
              title: 'Type of Delivery',
              icon: Icons.child_care_rounded,
              child: Row(
                children: [
                  for (final option in const [
                    'Vaginal Delivery',
                    'C-Section',
                    'Open to Both',
                  ]) ...[
                    if (option != 'Vaginal Delivery') const SizedBox(width: 8),
                    Expanded(
                      child: _DeliveryChip(
                        label: option,
                        selected: _delivery == option,
                        onTap: () => setState(() => _delivery = option),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              number: 2,
              title: 'Pain Relief Preferences',
              icon: Icons.self_improvement_rounded,
              child: Row(
                children: [
                  for (final item in const [
                    (Icons.sentiment_satisfied_alt_rounded, 'No Pain Relief'),
                    (Icons.air_rounded, 'Breathing / Relaxation'),
                    (Icons.medical_services_outlined, 'Epidural'),
                    (Icons.edit_outlined, 'Other'),
                  ]) ...[
                    if (item.$2 != 'No Pain Relief') const SizedBox(width: 8),
                    Expanded(
                      child: _PainTile(
                        icon: item.$1,
                        label: item.$2,
                        selected: _painRelief == item.$2,
                        onTap: () => setState(() => _painRelief = item.$2),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              number: 3,
              title: 'During Labor',
              icon: Icons.work_outline_rounded,
              child: Column(
                children: [
                  for (final entry in _labor.entries) ...[
                    _PreferenceRow(
                      label: entry.key,
                      value: entry.value,
                      onTap: () => _pickValue(
                        title: entry.key,
                        current: entry.value,
                        options: _yesNo,
                        onSelected: (value) =>
                            setState(() => _labor[entry.key] = value),
                      ),
                    ),
                    if (entry.key != _labor.keys.last)
                      const Divider(height: 1, color: Color(0xFFF3E8ED)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              number: 4,
              title: 'During Delivery',
              icon: Icons.favorite_outline_rounded,
              child: Column(
                children: [
                  for (final entry in _deliveryPrefs.entries) ...[
                    _PreferenceRow(
                      label: entry.key,
                      value: entry.value,
                      onTap: () => _pickValue(
                        title: entry.key,
                        current: entry.value,
                        options: entry.key.contains('Who do you want')
                            ? _roomPeople
                            : _yesNo,
                        onSelected: (value) =>
                            setState(() => _deliveryPrefs[entry.key] = value),
                      ),
                    ),
                    if (entry.key != _deliveryPrefs.keys.last)
                      const Divider(height: 1, color: Color(0xFFF3E8ED)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              number: 5,
              title: 'After Delivery',
              icon: Icons.family_restroom_rounded,
              child: Column(
                children: [
                  for (final entry in _after.entries) ...[
                    _PreferenceRow(
                      label: entry.key,
                      value: entry.value,
                      onTap: () => _pickValue(
                        title: entry.key,
                        current: entry.value,
                        options: _yesNo,
                        onSelected: (value) =>
                            setState(() => _after[entry.key] = value),
                      ),
                    ),
                    if (entry.key != _after.keys.last)
                      const Divider(height: 1, color: Color(0xFFF3E8ED)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),
            _ShareBanner(onShare: _share),
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
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your birth, your way.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.burgundy,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Planning ahead helps you feel empowered and prepared.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: 10),
                Icon(
                  Icons.favorite_rounded,
                  color: AppColors.magenta,
                  size: 18,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/birth_plan_hero.png',
              width: 96,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stackTrace) => Image.asset(
                'assets/images/journey_pregnant.png',
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.number,
    required this.title,
    required this.icon,
    required this.child,
  });

  final int number;
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.magenta, size: 20),
              const SizedBox(width: 8),
              Text(
                '$number. $title',
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.burgundy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _DeliveryChip extends StatelessWidget {
  const _DeliveryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.softPink : AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.magenta : AppColors.mistPink,
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.magenta : Colors.transparent,
                  border: Border.all(
                    color: selected ? AppColors.magenta : AppColors.skipGrey,
                    width: selected ? 0 : 1.4,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 13,
                        color: AppColors.white,
                      )
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  color: selected ? AppColors.magenta : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PainTile extends StatelessWidget {
  const _PainTile({
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
    return Material(
      color: selected ? AppColors.softPink : AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 96,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.magenta : AppColors.mistPink,
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 22,
                      color: selected ? AppColors.magenta : AppColors.textMuted,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        color: selected
                            ? AppColors.magenta
                            : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                const Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: AppColors.magenta,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.magenta,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.skipGrey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareBanner extends StatelessWidget {
  const _ShareBanner({required this.onShare});

  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.softPink,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.magenta.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety_rounded,
              color: AppColors.magenta,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Share this plan with your doctor and care team so they can '
              'support your wishes.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: onShare,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.magenta,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.ios_share_rounded, size: 16),
            label: const Text(
              'Share Plan',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
