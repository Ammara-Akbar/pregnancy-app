import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MiscarriageProfileScreen extends StatelessWidget {
  const MiscarriageProfileScreen({super.key, this.userName = 'Ayesha Khan'});

  final String userName;

  static const _info = [
    (Icons.cake_outlined, 'Age', '24 years'),
    (Icons.height_rounded, 'Height', '5 ft 3 in'),
    (Icons.monitor_weight_outlined, 'Weight', '58 kg'),
    (Icons.bloodtype_outlined, 'Blood Group', 'B+'),
    (Icons.event_outlined, 'Last Menstrual Period', '12 May 2024'),
    (Icons.favorite_border, 'Miscarriage Date', '20 June 2024'),
    (Icons.loop_rounded, 'Cycle Length', '30 days'),
    (Icons.flag_outlined, 'Goal', 'Healthy Pregnancy'),
  ];

  static const _menu = [
    (Icons.notifications_active_outlined, 'My Reminders'),
    (Icons.sticky_note_2_outlined, 'My Notes'),
    (Icons.bookmark_border_rounded, 'Saved Articles'),
    (Icons.event_available_outlined, 'My Appointments'),
    (Icons.settings_outlined, 'Settings'),
  ];

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
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.blush,
                      backgroundImage: AssetImage(
                        'assets/images/journey_bride.png',
                      ),
                    ),
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
                  const SizedBox(height: 6),
                  const Text(
                    'Healing & Growing 🌸',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.magenta,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "You're stronger than you think.",
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
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'My Insights',
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
                child: Column(
                  children: [
                    for (var i = 0; i < _info.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
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
                                _info[i].$1,
                                color: AppColors.magenta,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _info[i].$2,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                            Text(
                              _info[i].$3,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (i < _info.length - 1)
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                child: Column(
                  children: [
                    for (var i = 0; i < _menu.length; i++) ...[
                      ListTile(
                        leading: Icon(_menu[i].$1, color: AppColors.magenta),
                        title: Text(
                          _menu[i].$2,
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
                      if (i < _menu.length - 1)
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE8EF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'You are healing beautifully 💗 Take your time. You are enough.',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3A55),
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.favorite, color: AppColors.magenta, size: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
