import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantRemindersScreen extends StatefulWidget {
  const PregnantRemindersScreen({super.key});

  @override
  State<PregnantRemindersScreen> createState() =>
      _PregnantRemindersScreenState();
}

class _PregnantRemindersScreenState extends State<PregnantRemindersScreen> {
  late final List<_Reminder> _items = [
    _Reminder('Iron tablet', 'Every day · 9:00 AM', true),
    _Reminder('Folic acid', 'Every day · 9:00 AM', true),
    _Reminder('Drink water', 'Every 2 hours', true),
    _Reminder('Evening walk', 'Weekdays · 6:30 PM', false),
    _Reminder('Kick count log', 'After dinner', false),
  ];

  void _add() {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
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
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add reminder',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Reminder title',
                  filled: true,
                  fillColor: const Color(0xFFFFF5F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isEmpty) return;
                    setState(() {
                      _items.insert(0, _Reminder(text, 'Custom · Today', true));
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.magenta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
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
          'Reminders',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _add,
            icon: const Icon(Icons.add_rounded, color: AppColors.magenta),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        itemCount: _items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = _items[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: item.enabled,
                  activeThumbColor: AppColors.magenta,
                  onChanged: (v) {
                    setState(() {
                      _items[index] = _Reminder(item.title, item.subtitle, v);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Reminder {
  const _Reminder(this.title, this.subtitle, this.enabled);

  final String title;
  final String subtitle;
  final bool enabled;
}
