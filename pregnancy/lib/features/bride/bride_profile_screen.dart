import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BrideProfileScreen extends StatelessWidget {
  const BrideProfileScreen({super.key, this.userName = 'Ayesha Khan'});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF8D7E4), Color(0xFFFFF5F7)],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 24),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: AppColors.blush,
                          backgroundImage: const AssetImage(
                            'assets/images/journey_bride.png',
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.magenta,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.diamond, size: 14, color: AppColors.magenta),
                        SizedBox(width: 6),
                        Text(
                          'Bride-to-Be',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.magenta,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A healthy today for a beautiful tomorrow.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'My Journey',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.magenta,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    _JourneyRow(
                      icon: Icons.favorite_outline,
                      label: 'Wedding Date',
                      value: '12 Dec 2024',
                    ),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _JourneyRow(
                      icon: Icons.cake_outlined,
                      label: 'Age',
                      value: '24 years',
                    ),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _JourneyRow(
                      icon: Icons.height_rounded,
                      label: 'Height',
                      value: '5 ft 3 in',
                    ),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _JourneyRow(
                      icon: Icons.monitor_weight_outlined,
                      label: 'Current Weight',
                      value: '68 kg',
                    ),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _JourneyRow(
                      icon: Icons.flag_outlined,
                      label: 'Goal Weight',
                      value: '56 kg',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _MenuGroup(
                items: const [
                  (Icons.notifications_active_outlined, 'My Reminders'),
                  (Icons.sticky_note_2_outlined, 'My Notes'),
                  (Icons.bookmark_border_rounded, 'My Bookmarks'),
                  (Icons.calendar_month_outlined, 'My Calendar'),
                ],
              ),
              const SizedBox(height: 12),
              _MenuGroup(
                items: const [
                  (Icons.settings_outlined, 'App Settings'),
                  (Icons.help_outline_rounded, 'Help & Support'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _JourneyRow extends StatelessWidget {
  const _JourneyRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.blush,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.magenta, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuGroup extends StatelessWidget {
  const _MenuGroup({required this.items});

  final List<(IconData, String)> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
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
          for (var i = 0; i < items.length; i++) ...[
            ListTile(
              leading: Icon(items[i].$1, color: AppColors.magenta),
              title: Text(
                items[i].$2,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3A55),
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.skipGrey,
              ),
              onTap: () {},
            ),
            if (i < items.length - 1)
              const Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
          ],
        ],
      ),
    );
  }
}
