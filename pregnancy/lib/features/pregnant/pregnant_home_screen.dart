import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import 'pregnant_baby_size.dart';
import 'pregnant_baby_size_screen.dart';
import 'pregnant_checkups_screen.dart';
import 'pregnant_diet_screen.dart';
import 'pregnant_gentle_movement_screen.dart';
import 'pregnant_kick_awareness_screen.dart';
import 'pregnant_reminders_screen.dart';
import 'pregnant_symptom_guide.dart';
import 'pregnant_symptoms_screen.dart';
import 'pregnant_todays_plan_screen.dart';

class PregnantHomeScreen extends StatefulWidget {
  const PregnantHomeScreen({
    super.key,
    required this.userName,
    required this.weeksPregnant,
  });

  final String userName;
  final int weeksPregnant;

  @override
  State<PregnantHomeScreen> createState() => _PregnantHomeScreenState();
}

class _PregnantHomeScreenState extends State<PregnantHomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _completedTasks = 3;
  static const _totalTasks = 6;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String get _trimester {
    if (widget.weeksPregnant <= 13) return '1st Trimester';
    if (widget.weeksPregnant <= 27) return '2nd Trimester';
    return '3rd Trimester';
  }

  int get _weeksToGo => (40 - widget.weeksPregnant).clamp(0, 40);

  DateTime get _dueDate {
    final remaining = _weeksToGo;
    return DateTime.now().add(Duration(days: remaining * 7));
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  PregnantBabySize get _babySize =>
      PregnantBabySize.forWeek(widget.weeksPregnant);

  String get _todayTip {
    final desi = UserPreferences.instance.isDesi;
    if (widget.weeksPregnant <= 13) {
      return desi
          ? 'Take folic acid daily and snack on dates, almonds, and citrus for early pregnancy support.'
          : 'Take folic acid daily and include leafy greens, citrus, and whole grains for early pregnancy support.';
    }
    if (widget.weeksPregnant <= 27) {
      return desi
          ? 'Eat iron-rich foods like spinach, daal and dates to boost your hemoglobin.'
          : 'Eat iron-rich foods like spinach, lentils and lean meats to support healthy energy.';
    }
    return desi
        ? 'Practice gentle walks and breathing. Keep water and light snacks like roasted chana nearby.'
        : 'Practice gentle walks and breathing. Keep water and light protein snacks nearby.';
  }

  Future<void> _openTodaysPlan({int initialTab = 0}) async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (_) => PregnantTodaysPlanScreen(
          initialTab: initialTab,
          weeksPregnant: widget.weeksPregnant,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() => _completedTasks = result);
    }
  }

  void _showNotifications() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            24 + MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8DDE2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 12),
              const _NotifRow(
                title: 'Iron tablet reminder',
                subtitle: 'Due in 20 minutes',
              ),
              const _NotifRow(
                title: 'Antenatal checkup',
                subtitle: 'Tomorrow · 11:00 AM',
              ),
              const _NotifRow(
                title: 'New week tip unlocked',
                subtitle: 'See what changes this week',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = _babySize;
    final symptoms = PregnantTrimesterSymptoms.forWeek(widget.weeksPregnant);

    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFFFF5F7),
          drawer: _PregnantHomeDrawer(
            userName: widget.userName,
            onTodaysPlan: () {
              Navigator.pop(context);
              _openTodaysPlan();
            },
            onDiet: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      PregnantDietScreen(weeksPregnant: widget.weeksPregnant),
                ),
              );
            },
            onSymptoms: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PregnantSymptomsScreen(
                    weeksPregnant: widget.weeksPregnant,
                  ),
                ),
              );
            },
            onReminders: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PregnantRemindersScreen(),
                ),
              );
            },
            onCheckups: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PregnantCheckupsScreen(
                    weeksPregnant: widget.weeksPregnant,
                  ),
                ),
              );
            },
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFE89AB8), AppColors.magenta],
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Sehat Maa',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.magenta,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: _showNotifications,
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: const Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '$_greeting, ${widget.userName}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${UserPreferences.instance.region.shortLabel} guidance · Week ${widget.weeksPregnant}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF0F5), Color(0xFFF3E0F7)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.magenta.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'You are ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF2C3A55),
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${widget.weeksPregnant} weeks pregnant',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.magenta,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF8B6BA8,
                                ).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _trimester,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8B6BA8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Due date: ${_formatDate(_dueDate)}',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_weeksToGo weeks to go!',
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: widget.weeksPregnant / 40,
                                minHeight: 7,
                                backgroundColor: const Color(0xFFF0C8D8),
                                color: AppColors.magenta,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Today’s plan: $_completedTasks / $_totalTasks done',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48),
                          color: AppColors.white.withValues(alpha: 0.7),
                          border: Border.all(
                            color: AppColors.ringPink,
                            width: 3,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          PregnantBabySize.fetusAssetForWeek(
                            widget.weeksPregnant,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QuickAction(
                      icon: Icons.checklist_rounded,
                      label: "Today's Plan",
                      color: AppColors.magenta,
                      onTap: () => _openTodaysPlan(),
                    ),
                    _QuickAction(
                      icon: Icons.restaurant_rounded,
                      label: 'Diet',
                      color: const Color(0xFF8B6BA8),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PregnantDietScreen(
                              weeksPregnant: widget.weeksPregnant,
                            ),
                          ),
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.notifications_active_outlined,
                      label: 'Reminders',
                      color: const Color(0xFF5BA8D9),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PregnantRemindersScreen(),
                          ),
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.medical_services_outlined,
                      label: 'Checkups',
                      color: const Color(0xFFE0A84A),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PregnantCheckupsScreen(
                              weeksPregnant: widget.weeksPregnant,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Material(
                  color: const Color(0xFFFCE8EF),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PregnantBabySizeScreen(
                            weeksPregnant: widget.weeksPregnant,
                            fruitName: size.fruitName,
                            sizeLabel: size.sizeLabel,
                            imageAsset: size.imageAsset,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Baby Size (Week ${widget.weeksPregnant})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3A55),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${size.fruitName} (${size.sizeLabel})',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Tap to see weekly growth details',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: AppColors.magenta,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              size.imageAsset,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.skipGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PregnantSymptomsScreen(
                            weeksPregnant: widget.weeksPregnant,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCE8EF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.healing_outlined,
                              color: AppColors.magenta,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Symptoms & Pain (${symptoms.label})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3A55),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  symptoms.focusTitle,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Typical levels · when to seek care',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: AppColors.magenta,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.skipGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's Tip",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _todayTip,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/tip_salad.png',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'This week focus',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _FocusCard(
                        icon: Icons.favorite_outline,
                        title: 'Kick awareness',
                        subtitle: 'Notice patterns daily',
                        color: AppColors.magenta,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PregnantKickAwarenessScreen(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FocusCard(
                        icon: Icons.self_improvement_rounded,
                        title: 'Gentle movement',
                        subtitle: 'Walk or stretch',
                        color: const Color(0xFF66BB6A),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PregnantGentleMovementScreen(
                              weeksPregnant: widget.weeksPregnant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotifRow extends StatelessWidget {
  const _NotifRow({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: AppColors.magenta,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
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

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3A55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PregnantHomeDrawer extends StatelessWidget {
  const _PregnantHomeDrawer({
    required this.userName,
    required this.onTodaysPlan,
    required this.onDiet,
    required this.onSymptoms,
    required this.onReminders,
    required this.onCheckups,
  });

  final String userName;
  final VoidCallback onTodaysPlan;
  final VoidCallback onDiet;
  final VoidCallback onSymptoms;
  final VoidCallback onReminders;
  final VoidCallback onCheckups;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFF5F7),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Text(
              'Hi, $userName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3A55),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Quick pregnancy shortcuts',
              style: TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.checklist_rounded,
                color: AppColors.magenta,
              ),
              title: const Text("Today's Plan"),
              onTap: onTodaysPlan,
            ),
            ListTile(
              leading: const Icon(
                Icons.restaurant_rounded,
                color: AppColors.magenta,
              ),
              title: const Text('Diet & Meals'),
              onTap: onDiet,
            ),
            ListTile(
              leading: const Icon(
                Icons.healing_outlined,
                color: AppColors.magenta,
              ),
              title: const Text('Symptoms & Pain'),
              onTap: onSymptoms,
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications_active_outlined,
                color: AppColors.magenta,
              ),
              title: const Text('Reminders'),
              onTap: onReminders,
            ),
            ListTile(
              leading: const Icon(
                Icons.medical_services_outlined,
                color: AppColors.magenta,
              ),
              title: const Text('Checkups'),
              onTap: onCheckups,
            ),
          ],
        ),
      ),
    );
  }
}
