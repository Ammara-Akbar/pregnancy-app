import 'package:flutter/material.dart';

import '../preferences/user_preferences.dart';
import '../theme/app_colors.dart';

/// Shared Desi / International selector used across onboarding & settings.
class ContentRegionPicker extends StatelessWidget {
  const ContentRegionPicker({
    super.key,
    this.title = 'Content style',
    this.subtitle =
        'Choose guidance that fits your culture and lifestyle. You can change this anytime.',
    this.compact = false,
  });

  final String title;
  final String subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        final selected = UserPreferences.instance.region;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: compact ? 14 : 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C3A55),
                fontFamily: compact ? null : 'sans-serif',
              ),
            ),
            if (!compact) ...[
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                  height: 1.35,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 12),
            ] else
              const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _RegionCard(
                    region: ContentRegion.desi,
                    selected: selected == ContentRegion.desi,
                    icon: Icons.restaurant_rounded,
                    onTap: () => UserPreferences.instance
                        .setRegion(ContentRegion.desi),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _RegionCard(
                    region: ContentRegion.international,
                    selected: selected == ContentRegion.international,
                    icon: Icons.public_rounded,
                    onTap: () => UserPreferences.instance
                        .setRegion(ContentRegion.international),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _RegionCard extends StatelessWidget {
  const _RegionCard({
    required this.region,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  final ContentRegion region;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFFCE8EF) : AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.magenta : const Color(0xFFE8DDE2),
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? AppColors.magenta : const Color(0xFF6A5A62),
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                region.shortLabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.magenta : const Color(0xFF2C3A55),
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                region == ContentRegion.desi
                    ? 'South Asian meals & tips'
                    : 'Global meals & tips',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  height: 1.25,
                  fontFamily: 'sans-serif',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
