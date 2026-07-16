import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/content_region_picker.dart';
import '../subscription/review_confirm_screen.dart';
import '../subscription/subscription_plan.dart';

class PregnantPlanPersonalizeScreen extends StatefulWidget {
  const PregnantPlanPersonalizeScreen({
    super.key,
    required this.selectedPlan,
    this.yearly = false,
  });

  final SubscriptionPlan selectedPlan;
  final bool yearly;

  @override
  State<PregnantPlanPersonalizeScreen> createState() =>
      _PregnantPlanPersonalizeScreenState();
}

class _PregnantPlanPersonalizeScreenState
    extends State<PregnantPlanPersonalizeScreen> {
  final _nameController = TextEditingController(text: 'Ayesha Khan');
  DateTime? _dob = DateTime(1998, 5, 15);
  int _weeks = 12;
  String _pregnancyType = 'First Pregnancy';
  String _medicalCondition = 'No';

  static const _pregnancyTypes = [
    'First Pregnancy',
    'Second Pregnancy',
    'Third or more',
  ];

  static const _medicalOptions = [
    'No',
    'Diabetes',
    'Hypertension',
    'Thyroid',
    'Anemia',
    'Other',
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

  String get _weeksLabel {
    final months = (_weeks / 4).floor();
    if (months <= 0) return '$_weeks weeks';
    return '$_weeks weeks ($months months)';
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(1998, 5, 15),
      firstDate: DateTime(1960),
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
    if (picked != null) setState(() => _dob = picked);
  }

  Future<void> _pickWeeks() async {
    var temp = _weeks;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.ringPink,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'How many weeks pregnant?',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$temp weeks',
                    style: const TextStyle(
                      color: AppColors.magenta,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Slider(
                    value: temp.toDouble(),
                    min: 1,
                    max: 42,
                    divisions: 41,
                    activeColor: AppColors.magenta,
                    onChanged: (v) => setModalState(() => temp = v.round()),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _weeks = temp);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.magenta,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
    if (_dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your date of birth')),
      );
      return;
    }

    final name = _nameController.text.trim().split(' ').first;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReviewConfirmScreen(
          journeyId: 'pregnant',
          selectedPlan: widget.selectedPlan,
          yearly: widget.yearly,
          userName: name,
          weeksPregnant: _weeks,
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
                        text: "Let's personalize\n",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                        children: [
                          TextSpan(
                            text: 'your plan',
                            style: TextStyle(color: AppColors.magenta),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Answer a few questions to get a plan perfect for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const ContentRegionPicker(compact: true),
                    const SizedBox(height: 18),
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
                      label: 'Date of Birth',
                      onTap: _pickDob,
                      trailing: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(
                        _dob == null ? 'Select date' : _formatDate(_dob!),
                        style: _valueStyle,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'How many weeks pregnant are you?',
                      onTap: _pickWeeks,
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(_weeksLabel, style: _valueStyle),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'This is your:',
                      onTap: () => _pickOption(
                        title: 'This is your',
                        options: _pregnancyTypes,
                        current: _pregnancyType,
                        onSelected: (v) => setState(() => _pregnancyType = v),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(_pregnancyType, style: _valueStyle),
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
                                  'This helps us create a plan tailored to your pregnancy stage and needs.',
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
                  const _StepDots(activeIndex: 1, count: 4),
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
