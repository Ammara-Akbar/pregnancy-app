import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../models/health_checkup_models.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';
import 'upload_reports_screen.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key, required this.categoryId});

  final HealthCategoryId categoryId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HealthCheckupProvider>();
    final category = provider.categoryById(categoryId);

    return HealthCheckupScaffold(
      title: category.title,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: Row(
              children: [
                Hero(
                  tag: 'cat_${category.id.name}',
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: category.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(category.icon, color: category.accent, size: 28),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.description,
                        style: const TextStyle(
                          color: HealthCheckupColors.muted,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: category.progress,
                          minHeight: 8,
                          backgroundColor: HealthCheckupColors.softPinkLight,
                          color: category.accent,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${(category.progress * 100).round()}% complete · '
                        '${category.completedCount}/${category.totalCount}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                          color: HealthCheckupColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (category.optional) ...[
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: StatusChip(
                label: 'Optional for partner',
                color: Color(0xFF5BA8D9),
              ),
            ),
          ],
          const SizedBox(height: 16),
          ...category.items.map((item) {
            if (item.expandable) {
              return _ExpandableItem(
                item: item,
                accent: category.accent,
                onToggle: () => provider.toggleItem(categoryId, item.id),
                onUpload: () => _openUpload(context),
              );
            }
            return _ChecklistItem(
              item: item,
              accent: category.accent,
              showReminder: categoryId == HealthCategoryId.womens ||
                  categoryId == HealthCategoryId.essential,
              onToggle: () => provider.toggleItem(categoryId, item.id),
              onUpload: () => _openUpload(context),
            );
          }),
        ],
      ),
    );
  }

  void _openUpload(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UploadReportsScreen()),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({
    required this.item,
    required this.accent,
    required this.onToggle,
    required this.onUpload,
    this.showReminder = false,
  });

  final HealthTestItem item;
  final Color accent;
  final VoidCallback onToggle;
  final VoidCallback onUpload;
  final bool showReminder;

  @override
  Widget build(BuildContext context) {
    final done = item.status == HealthItemStatus.completed;
    final optional = item.status == HealthItemStatus.optional;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? accent : Colors.transparent,
                      border: Border.all(
                        color: done ? accent : HealthCheckupColors.muted,
                        width: 2,
                      ),
                    ),
                    child: done
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: HealthCheckupColors.navy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: HealthCheckupColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusChip(
                  label: optional
                      ? 'Optional'
                      : done
                          ? 'Completed'
                          : 'Pending',
                  color: optional
                      ? const Color(0xFF5BA8D9)
                      : done
                          ? HealthCheckupColors.green
                          : HealthCheckupColors.yellow,
                ),
              ],
            ),
            if (showReminder && item.reminder != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    size: 16,
                    color: HealthCheckupColors.softPink,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.reminder!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: HealthCheckupColors.softPinkDark,
                    ),
                  ),
                ],
              ),
            ],
            if (item.aiNote != null) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: HealthCheckupColors.softPinkLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'AI: ${item.aiNote}',
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: HealthCheckupColors.navy,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                TextButton.icon(
                  onPressed: onUpload,
                  icon: const Icon(Icons.upload_rounded, size: 18),
                  label: const Text('Upload Report'),
                  style: TextButton.styleFrom(
                    foregroundColor: HealthCheckupColors.softPink,
                  ),
                ),
                if (item.severity != null)
                  StatusChip(
                    label: item.severity!,
                    color: item.severity == 'Low'
                        ? HealthCheckupColors.yellow
                        : HealthCheckupColors.green,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableItem extends StatelessWidget {
  const _ExpandableItem({
    required this.item,
    required this.accent,
    required this.onToggle,
    required this.onUpload,
  });

  final HealthTestItem item;
  final Color accent;
  final VoidCallback onToggle;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final done = item.status == HealthItemStatus.completed;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PremiumCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            leading: Icon(
              done ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
              color: done ? accent : HealthCheckupColors.muted,
            ),
            title: Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: HealthCheckupColors.navy,
              ),
            ),
            subtitle: Text(
              item.description,
              style: const TextStyle(
                fontSize: 12,
                color: HealthCheckupColors.muted,
              ),
            ),
            children: [
              Text(
                item.aiNote ??
                    'Expand to review guidance, upload reports, and mark complete.',
                style: const TextStyle(height: 1.4, color: HealthCheckupColors.navy),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  FilledButton(
                    onPressed: onToggle,
                    style: FilledButton.styleFrom(
                      backgroundColor: HealthCheckupColors.softPink,
                    ),
                    child: Text(done ? 'Mark Pending' : 'Mark Completed'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: onUpload,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: HealthCheckupColors.softPink,
                      side: const BorderSide(color: HealthCheckupColors.softPink),
                    ),
                    child: const Text('Upload Report'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
