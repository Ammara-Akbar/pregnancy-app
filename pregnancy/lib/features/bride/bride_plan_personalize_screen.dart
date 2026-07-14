import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

class BridePlanPersonalizeScreen extends StatefulWidget {
  const BridePlanPersonalizeScreen({super.key});

  @override
  State<BridePlanPersonalizeScreen> createState() =>
      _BridePlanPersonalizeScreenState();
}

class _BridePlanPersonalizeScreenState
    extends State<BridePlanPersonalizeScreen> {
  final _nameController = TextEditingController(text: 'Ayesha Khan');
  DateTime? _dob = DateTime(2000, 5, 15);
  DateTime? _weddingDate = DateTime(2024, 12, 12);
  int _heightCm = 160;
  int _weightKg = 68;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _heightLabel {
    final totalInches = (_heightCm / 2.54).round();
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return '$feet ft $inches in ($_heightCm cm)';
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

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onPicked,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime(2000, 1, 1),
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime(now.year + 10),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.burgundyDeep,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: Color(0xFF2C3A55),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) onPicked(picked);
  }

  Future<void> _pickHeight() async {
    var temp = _heightCm;
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
                    'Select height',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    () {
                      final totalInches = (temp / 2.54).round();
                      final feet = totalInches ~/ 12;
                      final inches = totalInches % 12;
                      return '$feet ft $inches in ($temp cm)';
                    }(),
                    style: const TextStyle(
                      color: AppColors.magenta,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Slider(
                    value: temp.toDouble(),
                    min: 120,
                    max: 200,
                    divisions: 80,
                    activeColor: AppColors.burgundyDeep,
                    onChanged: (v) => setModalState(() => temp = v.round()),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _heightCm = temp);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.burgundyDeep,
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

  Future<void> _pickWeight() async {
    final controller = TextEditingController(text: '$_weightKg');
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Current weight (kg)'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'e.g. 68',
              suffixText: 'kg',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text);
                if (value != null && value > 0 && value < 300) {
                  setState(() => _weightKg = value);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    controller.dispose();
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your Bride-to-be plan is ready')),
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
                        text: "Let's personalize ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                          fontFamily: 'sans-serif',
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
                        fontFamily: 'sans-serif',
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
                      label: 'Date of Birth',
                      onTap: () => _pickDate(
                        current: _dob,
                        lastDate: DateTime.now(),
                        onPicked: (d) => setState(() => _dob = d),
                      ),
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
                      label: 'Height',
                      onTap: _pickHeight,
                      child: Text(_heightLabel, style: _valueStyle),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'Current Weight',
                      onTap: _pickWeight,
                      child: Text('$_weightKg kg', style: _valueStyle),
                    ),
                    const SizedBox(height: 14),
                    _LabeledField(
                      label: 'Wedding Date (Optional)',
                      onTap: () => _pickDate(
                        current: _weddingDate ?? DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        onPicked: (d) => setState(() => _weddingDate = d),
                      ),
                      trailing: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.skipGrey,
                      ),
                      child: Text(
                        _weddingDate == null
                            ? 'Select date'
                            : _formatDate(_weddingDate!),
                        style: _valueStyle,
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
                                    fontFamily: 'sans-serif',
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'This helps us create a plan tailored to your body and goals.',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                    height: 1.4,
                                    fontFamily: 'sans-serif',
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
                16 + MediaQuery.paddingOf(context).bottom,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.burgundyDeep,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  child: const Text('Continue'),
                ),
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
  fontFamily: 'sans-serif',
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
                        fontFamily: 'sans-serif',
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
