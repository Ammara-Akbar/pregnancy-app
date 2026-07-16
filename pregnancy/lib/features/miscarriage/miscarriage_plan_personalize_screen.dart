import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'miscarriage_review_confirm_screen.dart';
import 'miscarriage_subscription_plan.dart';

class MiscarriagePlanPersonalizeScreen extends StatefulWidget {
  const MiscarriagePlanPersonalizeScreen({
    super.key,
    required this.selectedPlan,
    this.yearly = false,
  });

  final MiscarriageSubscriptionPlan selectedPlan;
  final bool yearly;

  @override
  State<MiscarriagePlanPersonalizeScreen> createState() =>
      _MiscarriagePlanPersonalizeScreenState();
}

class _MiscarriagePlanPersonalizeScreenState
    extends State<MiscarriagePlanPersonalizeScreen> {
  final _nameController = TextEditingController(text: 'Ayesha Khan');
  DateTime? _lossDate = DateTime(2024, 6, 20);
  String _supportNeeded = 'Physical & Emotional Healing';
  String _weeksPregnant = '6–12 weeks';
  String _medicalCondition = 'No';
  int _moodIndex = 0;

  static const _supportOptions = [
    'Physical & Emotional Healing',
    'Emotional Support Only',
    'Physical Recovery Only',
    'Trying Again Guidance',
  ];

  static const _weeksOptions = [
    'Under 6 weeks',
    '6–12 weeks',
    '13–20 weeks',
    'Over 20 weeks',
    'Prefer not to say',
  ];

  static const _medicalOptions = [
    'No',
    'Diabetes',
    'Hypertension',
    'Anemia',
    'Thyroid',
    'Other',
  ];

  static const _moods = [
    (Icons.sentiment_very_satisfied_rounded, 'Good', Color(0xFF4CAF7A)),
    (Icons.sentiment_satisfied_rounded, 'Okay', Color(0xFFFFA726)),
    (Icons.sentiment_neutral_rounded, 'Tired', Color(0xFFFF8A65)),
    (Icons.sentiment_dissatisfied_rounded, 'Struggling', Color(0xFFEF5350)),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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

  Future<void> _pickLossDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lossDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.magenta,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: Color(0xFF2C3A55),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _lossDate = picked);
  }

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required String current,
    required ValueChanged<String> onSelected,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
              ),
              for (final option in options)
                ListTile(
                  title: Text(option),
                  trailing: option == current
                      ? const Icon(Icons.check, color: AppColors.magenta)
                      : null,
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _continue() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    if (_lossDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date of loss')),
      );
      return;
    }

    final name = _nameController.text.trim().split(' ').first;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MiscarriageReviewConfirmScreen(
          selectedPlan: widget.selectedPlan,
          yearly: widget.yearly,
          userName: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FA),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: Color(0xFF2C3A55),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
                child: Column(
                  children: [
                    const Text.rich(
                      TextSpan(
                        text: "Let's ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                        children: [
                          TextSpan(
                            text: 'personalize your plan',
                            style: TextStyle(color: AppColors.magenta),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Answer a few questions so we can support you gently and personally.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _LabeledField(
                      label: 'Your Name',
                      child: TextField(
                        controller: _nameController,
                        style: _valueStyle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'Date of Loss',
                      onTap: _pickLossDate,
                      trailing: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(
                        _lossDate == null
                            ? 'Select date'
                            : _formatDate(_lossDate!),
                        style: _valueStyle,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'Type of Support Needed',
                      onTap: () => _pickOption(
                        title: 'Type of Support Needed',
                        options: _supportOptions,
                        current: _supportNeeded,
                        onSelected: (v) => setState(() => _supportNeeded = v),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(_supportNeeded, style: _valueStyle),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'How far along were you?',
                      onTap: () => _pickOption(
                        title: 'How far along were you?',
                        options: _weeksOptions,
                        current: _weeksPregnant,
                        onSelected: (v) => setState(() => _weeksPregnant = v),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(_weeksPregnant, style: _valueStyle),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'Any medical condition?',
                      onTap: () => _pickOption(
                        title: 'Medical condition',
                        options: _medicalOptions,
                        current: _medicalCondition,
                        onSelected: (v) =>
                            setState(() => _medicalCondition = v),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(_medicalCondition, style: _valueStyle),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE8DEE3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'How is your mood today?',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < _moods.length; i++)
                                GestureDetector(
                                  onTap: () => setState(() => _moodIndex = i),
                                  child: Column(
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 180),
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _moods[i].$3.withValues(
                                            alpha: _moodIndex == i ? 0.2 : 0.1,
                                          ),
                                          border: Border.all(
                                            color: _moodIndex == i
                                                ? _moods[i].$3
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          _moods[i].$1,
                                          color: _moods[i].$3,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        _moods[i].$2,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: _moodIndex == i
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: _moodIndex == i
                                              ? _moods[i].$3
                                              : AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE8EF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Why we ask this?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.magenta,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'This helps us create a plan tailored to your physical recovery and emotional well-being.',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.magenta.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_user_rounded,
                              color: AppColors.magenta,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                8,
                24,
                8 + MediaQuery.paddingOf(context).bottom,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.magenta,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _StepDots(activeIndex: 2, count: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _valueStyle = TextStyle(
  fontSize: 15.5,
  fontWeight: FontWeight.w600,
  color: Color(0xFF2C3A55),
);

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
    this.onTap,
    this.trailing,
  });

  final String label;
  final Widget child;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8DEE3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    child,
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 9 : 7,
          height: active ? 9 : 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.magenta : AppColors.ringPink,
          ),
        );
      }),
    );
  }
}
