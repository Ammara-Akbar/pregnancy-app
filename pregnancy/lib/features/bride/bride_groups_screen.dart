import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BrideGroupItem {
  const BrideGroupItem({
    required this.id,
    required this.title,
    required this.members,
    required this.description,
  });

  final String id;
  final String title;
  final String members;
  final String description;
}

class BrideGroupsScreen extends StatefulWidget {
  const BrideGroupsScreen({
    super.key,
    required this.groups,
    required this.joinedIds,
  });

  final List<BrideGroupItem> groups;
  final Set<String> joinedIds;

  @override
  State<BrideGroupsScreen> createState() => _BrideGroupsScreenState();
}

class _BrideGroupsScreenState extends State<BrideGroupsScreen> {
  late final Set<String> _joined = {...widget.joinedIds};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(_joined),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'Popular Groups',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        itemCount: widget.groups.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final g = widget.groups[index];
          final joined = _joined.contains(g.id);
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE8EF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        color: AppColors.magenta,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            g.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3A55),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            g.members,
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
                const SizedBox(height: 10),
                Text(
                  g.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4A3A42),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (joined) {
                          _joined.remove(g.id);
                        } else {
                          _joined.add(g.id);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          joined ? const Color(0xFF4CAF7A) : AppColors.magenta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(joined ? 'Joined' : 'Join group'),
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
