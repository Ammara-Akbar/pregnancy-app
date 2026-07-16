import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum BrideProfileToolType { reminders, notes, bookmarks, calendar }

class BrideProfileToolsScreen extends StatefulWidget {
  const BrideProfileToolsScreen({
    super.key,
    required this.type,
    this.onCountChanged,
  });

  final BrideProfileToolType type;
  final ValueChanged<int>? onCountChanged;

  @override
  State<BrideProfileToolsScreen> createState() =>
      _BrideProfileToolsScreenState();
}

class _BrideProfileToolsScreenState extends State<BrideProfileToolsScreen> {
  late List<_ToolItem> _items = switch (widget.type) {
    BrideProfileToolType.reminders => [
        _ToolItem('Take folic acid', 'Every day · 9:00 AM', true),
        _ToolItem('Drink water', 'Every 2 hours', true),
        _ToolItem('Evening walk', 'Weekdays · 6:30 PM', false),
      ],
    BrideProfileToolType.notes => [
        _ToolItem('Ask doctor about vitamin D', 'Saved yesterday', false),
        _ToolItem('Try spinach + lemon lunch', 'Nutrition note', false),
        _ToolItem('Outfit fitting on Sunday', 'Wedding prep', false),
        _ToolItem('Sleep by 11 PM this week', 'Wellness', false),
        _ToolItem('Pack reports folder', 'Health checklist', false),
      ],
    BrideProfileToolType.bookmarks => [
        _ToolItem('10 Tips for Pre-Marriage Lifestyle', 'Article', false),
        _ToolItem('Iron-rich meal ideas', 'Nutrition', false),
        _ToolItem('Gentle yoga for brides', 'Fitness', false),
        _ToolItem('Stress & sleep guide', 'Wellness', false),
      ],
    BrideProfileToolType.calendar => [
        _ToolItem('Gynecologist checkup', '18 Jul · 11:00 AM', false),
        _ToolItem('Bridal fitness class', '20 Jul · 5:00 PM', false),
        _ToolItem('Lab reports follow-up', '25 Jul · 10:30 AM', false),
      ],
  };

  String get _title => switch (widget.type) {
        BrideProfileToolType.reminders => 'My Reminders',
        BrideProfileToolType.notes => 'My Notes',
        BrideProfileToolType.bookmarks => 'My Bookmarks',
        BrideProfileToolType.calendar => 'My Calendar',
      };

  void _notifyCount() {
    final count = widget.type == BrideProfileToolType.reminders
        ? _items.where((e) => e.enabled).length
        : _items.length;
    widget.onCountChanged?.call(count);
  }

  void _addItem() {
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
              Text(
                'Add to $_title',
                style: const TextStyle(
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
                  hintText: 'Title',
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
                      _items = [
                        _ToolItem(text, 'Just added', true),
                        ..._items,
                      ];
                    });
                    _notifyCount();
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
        title: Text(
          _title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _addItem,
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
                if (widget.type == BrideProfileToolType.reminders)
                  Switch(
                    value: item.enabled,
                    activeThumbColor: AppColors.magenta,
                    onChanged: (v) {
                      setState(() {
                        _items[index] = _ToolItem(item.title, item.subtitle, v);
                      });
                      _notifyCount();
                    },
                  )
                else
                  IconButton(
                    onPressed: () {
                      setState(() => _items.removeAt(index));
                      _notifyCount();
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.skipGrey,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ToolItem {
  const _ToolItem(this.title, this.subtitle, this.enabled);

  final String title;
  final String subtitle;
  final bool enabled;
}
