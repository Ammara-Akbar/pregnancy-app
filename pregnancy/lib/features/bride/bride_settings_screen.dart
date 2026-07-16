import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/content_region_picker.dart';

class BrideSettingsScreen extends StatefulWidget {
  const BrideSettingsScreen({super.key});

  @override
  State<BrideSettingsScreen> createState() => _BrideSettingsScreenState();
}

class _BrideSettingsScreenState extends State<BrideSettingsScreen> {
  bool _push = true;
  bool _email = false;
  bool _habitReminders = true;
  bool _communityAlerts = true;
  bool _privateProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'App Settings',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const ContentRegionPicker(
            title: 'Content style',
            subtitle: 'Desi or International guidance across the app.',
          ),
          const SizedBox(height: 16),
          _SettingsCard(
            children: [
              _ToggleRow(
                title: 'Push notifications',
                value: _push,
                onChanged: (v) => setState(() => _push = v),
              ),
              _ToggleRow(
                title: 'Email updates',
                value: _email,
                onChanged: (v) => setState(() => _email = v),
              ),
              _ToggleRow(
                title: 'Habit reminders',
                value: _habitReminders,
                onChanged: (v) => setState(() => _habitReminders = v),
              ),
              _ToggleRow(
                title: 'Community alerts',
                value: _communityAlerts,
                onChanged: (v) => setState(() => _communityAlerts = v),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SettingsCard(
            children: [
              _ToggleRow(
                title: 'Private profile',
                value: _privateProfile,
                onChanged: (v) => setState(() => _privateProfile = v),
              ),
              ListTile(
                title: const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                trailing: Text(
                  UserPreferences.instance.isDesi ? 'English + Urdu tips' : 'English',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BrideHelpSupportScreen extends StatelessWidget {
  const BrideHelpSupportScreen({super.key});

  static const _faqs = [
    (
      'How do I change Desi / International content?',
      'Open Profile or Settings and switch Content style anytime.'
    ),
    (
      'Where do I upload lab reports?',
      'Go to the Reports tab and tap Add report.'
    ),
    (
      'Can I edit my wedding date?',
      'Yes — Profile → My Journey → Edit.'
    ),
    (
      'Is my data private?',
      'You can keep your profile private in App Settings.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need help?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Browse FAQs or contact our support team. We usually reply within 24 hours.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'FAQs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 10),
          for (final faq in _faqs) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq.$1,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    faq.$2,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Support request sent to help@sehatmaa.app'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.magenta,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Contact support',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2C3A55),
        ),
      ),
      value: value,
      activeThumbColor: AppColors.magenta,
      onChanged: onChanged,
    );
  }
}
