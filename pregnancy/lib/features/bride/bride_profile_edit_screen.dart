import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

class BrideProfileData {
  const BrideProfileData({
    required this.name,
    required this.bio,
    required this.weddingDate,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.goalWeightKg,
  });

  final String name;
  final String bio;
  final DateTime weddingDate;
  final int age;
  final int heightCm;
  final double weightKg;
  final double goalWeightKg;
}

class BrideProfileEditScreen extends StatefulWidget {
  const BrideProfileEditScreen({super.key, required this.data});

  final BrideProfileData data;

  @override
  State<BrideProfileEditScreen> createState() => _BrideProfileEditScreenState();
}

class _BrideProfileEditScreenState extends State<BrideProfileEditScreen> {
  late final _nameController = TextEditingController(text: widget.data.name);
  late final _bioController = TextEditingController(text: widget.data.bio);
  late final _weightController = TextEditingController(
    text: widget.data.weightKg.toStringAsFixed(0),
  );
  late final _goalController = TextEditingController(
    text: widget.data.goalWeightKg.toStringAsFixed(0),
  );
  late DateTime _weddingDate = widget.data.weddingDate;
  late int _age = widget.data.age;
  late int _heightCm = widget.data.heightCm;

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _pickWeddingDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _weddingDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.magenta,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _weddingDate = picked);
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    final weight = double.tryParse(_weightController.text.trim()) ??
        widget.data.weightKg;
    final goal = double.tryParse(_goalController.text.trim()) ??
        widget.data.goalWeightKg;
    Navigator.of(context).pop(
      BrideProfileData(
        name: name,
        bio: _bioController.text.trim().isEmpty
            ? widget.data.bio
            : _bioController.text.trim(),
        weddingDate: _weddingDate,
        age: _age,
        heightCm: _heightCm,
        weightKg: weight,
        goalWeightKg: goal,
      ),
    );
  }

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
          'Edit profile',
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
          _field(
            label: 'Name',
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 12),
          _field(
            label: 'Bio',
            child: TextField(
              controller: _bioController,
              maxLines: 2,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 12),
          _field(
            label: 'Wedding Date',
            onTap: _pickWeddingDate,
            child: Text(_formatDate(_weddingDate)),
          ),
          const SizedBox(height: 12),
          _field(
            label: 'Age',
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      setState(() => _age = (_age - 1).clamp(16, 60)),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '$_age years',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                IconButton(
                  onPressed: () =>
                      setState(() => _age = (_age + 1).clamp(16, 60)),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _field(
            label: 'Height (cm)',
            child: Slider(
              value: _heightCm.toDouble(),
              min: 140,
              max: 185,
              divisions: 45,
              activeColor: AppColors.magenta,
              label: '$_heightCm cm',
              onChanged: (v) => setState(() => _heightCm = v.round()),
            ),
          ),
          const SizedBox(height: 12),
          _field(
            label: 'Current weight (kg)',
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _weightController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                suffixText: 'kg',
              ),
            ),
          ),
          const SizedBox(height: 12),
          _field(
            label: 'Goal weight (kg)',
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _goalController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                suffixText: 'kg',
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.magenta,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Save changes',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required String label,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
