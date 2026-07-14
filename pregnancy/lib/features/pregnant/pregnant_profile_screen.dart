import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantProfileScreen extends StatelessWidget {
  const PregnantProfileScreen({
    super.key,
    this.userName = 'Ayesha Khan',
    this.weeksPregnant = 12,
  });

  final String userName;
  final int weeksPregnant;

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
                        'Profile',
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
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 3),
                        ),
                        child: const CircleAvatar(
                          radius: 52,
                          backgroundColor: AppColors.blush,
                          backgroundImage: AssetImage(
                            'assets/images/journey_pregnant.png',
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
                    child: Text(
                      '$weeksPregnant Weeks Pregnant',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.magenta,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Growing a tiny miracle with love and care 💖🌸',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
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
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Profile Completion',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '80%',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.magenta,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.8,
                        minHeight: 7,
                        backgroundColor: Color(0xFFF0C8D8),
                        color: AppColors.magenta,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Complete your profile to get better recommendations.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Text(
                    'My Information',
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
                    _InfoRow(icon: Icons.cake_outlined, label: 'Age', value: '24 years'),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _InfoRow(icon: Icons.height_rounded, label: 'Height', value: '5 ft 3 in (160 cm)'),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _InfoRow(icon: Icons.monitor_weight_outlined, label: 'Pre-pregnancy Weight', value: '60 kg'),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _InfoRow(icon: Icons.monitor_weight_outlined, label: 'Current Weight', value: '63 kg'),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _InfoRow(icon: Icons.bloodtype_outlined, label: 'Blood Group', value: 'B+'),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _InfoRow(icon: Icons.event_outlined, label: 'Due Date', value: '25 Dec 2024'),
                    Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
                    _InfoRow(icon: Icons.location_on_outlined, label: 'Location', value: 'Lahore, Pakistan'),
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
                    for (final item in const [
                      (Icons.notifications_active_outlined, 'My Reminders'),
                      (Icons.sticky_note_2_outlined, 'My Notes'),
                      (Icons.bookmark_border_rounded, 'Saved Articles'),
                      (Icons.event_available_outlined, 'My Appointments'),
                    ]) ...[
                      ListTile(
                        leading: Icon(item.$1, color: AppColors.magenta),
                        title: Text(
                          item.$2,
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
                      if (item.$2 != 'My Appointments')
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                    ],
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3A55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
