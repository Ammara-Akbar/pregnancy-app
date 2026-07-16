import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/content_region_picker.dart';
import 'bride_profile_edit_screen.dart';
import 'bride_profile_tools_screen.dart';
import 'bride_settings_screen.dart';

class BrideProfileScreen extends StatefulWidget {
  const BrideProfileScreen({super.key, this.userName = 'Ayesha Khan'});

  final String userName;

  @override
  State<BrideProfileScreen> createState() => _BrideProfileScreenState();
}

class _BrideProfileScreenState extends State<BrideProfileScreen> {
  late String _name = widget.userName;
  String _bio = 'A healthy today for a beautiful tomorrow.';
  DateTime _weddingDate = DateTime(2024, 12, 12);
  int _age = 24;
  int _heightCm = 160;
  double _weightKg = 68;
  double _goalWeightKg = 56;
  int _reminderCount = 3;
  int _notesCount = 5;
  int _bookmarksCount = 4;

  String get _heightLabel {
    final totalInches = (_heightCm / 2.54).round();
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return '$feet ft $inches in';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  int get _daysToWedding {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = DateTime(
      _weddingDate.year,
      _weddingDate.month,
      _weddingDate.day,
    );
    return end.difference(start).inDays;
  }

  Future<void> _editProfile() async {
    final result = await Navigator.of(context).push<BrideProfileData>(
      MaterialPageRoute(
        builder: (_) => BrideProfileEditScreen(
          data: BrideProfileData(
            name: _name,
            bio: _bio,
            weddingDate: _weddingDate,
            age: _age,
            heightCm: _heightCm,
            weightKg: _weightKg,
            goalWeightKg: _goalWeightKg,
          ),
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _name = result.name;
        _bio = result.bio;
        _weddingDate = result.weddingDate;
        _age = result.age;
        _heightCm = result.heightCm;
        _weightKg = result.weightKg;
        _goalWeightKg = result.goalWeightKg;
      });
    }
  }

  void _openTool(BrideProfileToolType type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BrideProfileToolsScreen(
          type: type,
          onCountChanged: (count) {
            setState(() {
              switch (type) {
                case BrideProfileToolType.reminders:
                  _reminderCount = count;
                case BrideProfileToolType.notes:
                  _notesCount = count;
                case BrideProfileToolType.bookmarks:
                  _bookmarksCount = count;
                case BrideProfileToolType.calendar:
                  break;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = _daysToWedding;

    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
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
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const BrideSettingsScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.settings_outlined,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.white,
                                width: 3,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 52,
                              backgroundColor: AppColors.blush,
                              backgroundImage: AssetImage(
                                'assets/images/journey_bride.png',
                              ),
                            ),
                          ),
                          Positioned(
                            right: 4,
                            bottom: 4,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Photo update coming soon.',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.magenta,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _name,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.diamond,
                              size: 14,
                              color: AppColors.magenta,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Bride-to-Be · ${UserPreferences.instance.region.shortLabel}',
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.magenta,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _bio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.celebration_outlined,
                              color: AppColors.magenta,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                days >= 0
                                    ? '$days days to your wedding'
                                    : 'Wedding date has passed — update it anytime',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2C3A55),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
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
                        onPressed: _editProfile,
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
                        _JourneyRow(
                          icon: Icons.favorite_outline,
                          label: 'Wedding Date',
                          value: _formatDate(_weddingDate),
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                        _JourneyRow(
                          icon: Icons.cake_outlined,
                          label: 'Age',
                          value: '$_age years',
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                        _JourneyRow(
                          icon: Icons.height_rounded,
                          label: 'Height',
                          value: _heightLabel,
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                        _JourneyRow(
                          icon: Icons.monitor_weight_outlined,
                          label: 'Current Weight',
                          value: '${_weightKg.toStringAsFixed(0)} kg',
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF3E8ED),
                        ),
                        _JourneyRow(
                          icon: Icons.flag_outlined,
                          label: 'Goal Weight',
                          value: '${_goalWeightKg.toStringAsFixed(0)} kg',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ContentRegionPicker(
                    title: 'Content style',
                    subtitle:
                        'Switch between Desi and International meals, tips, and pricing anytime.',
                  ),
                  const SizedBox(height: 16),
                  _MenuGroup(
                    items: [
                      (
                        Icons.notifications_active_outlined,
                        'My Reminders',
                        '$_reminderCount active',
                        () => _openTool(BrideProfileToolType.reminders),
                      ),
                      (
                        Icons.sticky_note_2_outlined,
                        'My Notes',
                        '$_notesCount saved',
                        () => _openTool(BrideProfileToolType.notes),
                      ),
                      (
                        Icons.bookmark_border_rounded,
                        'My Bookmarks',
                        '$_bookmarksCount items',
                        () => _openTool(BrideProfileToolType.bookmarks),
                      ),
                      (
                        Icons.calendar_month_outlined,
                        'My Calendar',
                        'Upcoming events',
                        () => _openTool(BrideProfileToolType.calendar),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _MenuGroup(
                    items: [
                      (
                        Icons.settings_outlined,
                        'App Settings',
                        'Notifications & privacy',
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const BrideSettingsScreen(),
                            ),
                          );
                        },
                      ),
                      (
                        Icons.help_outline_rounded,
                        'Help & Support',
                        'FAQs and contact',
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const BrideHelpSupportScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Sign out?'),
                            content: const Text(
                              'You can sign back in anytime to continue your bridal plan.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Signed out of this device (demo).',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign out',
                                  style: TextStyle(color: AppColors.magenta),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.magenta,
                        side: const BorderSide(color: AppColors.magenta),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign out',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
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

  final List<(IconData, String, String, VoidCallback)> items;

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
              subtitle: Text(
                items[i].$3,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.skipGrey,
              ),
              onTap: items[i].$4,
            ),
            if (i < items.length - 1)
              const Divider(height: 1, indent: 56, color: Color(0xFFF3E8ED)),
          ],
        ],
      ),
    );
  }
}
