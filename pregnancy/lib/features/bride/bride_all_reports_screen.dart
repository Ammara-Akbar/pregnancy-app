import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_health_report.dart';
import 'bride_report_detail_screen.dart';

class BrideAllReportsScreen extends StatefulWidget {
  const BrideAllReportsScreen({super.key, required this.reports});

  final List<BrideHealthReport> reports;

  @override
  State<BrideAllReportsScreen> createState() => _BrideAllReportsScreenState();
}

class _BrideAllReportsScreenState extends State<BrideAllReportsScreen> {
  late final List<BrideHealthReport> _reports = List.of(widget.reports);
  int _filter = 0; // 0 all, 1 normal, 2 pending

  List<BrideHealthReport> get _filtered {
    return switch (_filter) {
      1 => _reports
          .where((r) => r.status == BrideReportStatus.normal)
          .toList(),
      2 => _reports
          .where((r) => r.status == BrideReportStatus.pending)
          .toList(),
      _ => _reports,
    };
  }

  Future<void> _open(BrideHealthReport report) async {
    final updated = await Navigator.of(context).push<BrideHealthReport>(
      MaterialPageRoute(
        builder: (_) => BrideReportDetailScreen(report: report),
      ),
    );
    if (updated != null && mounted) {
      setState(() {
        final i = _reports.indexWhere((r) => r.id == updated.id);
        if (i != -1) _reports[i] = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(_reports),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'All reports',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _filter == 0,
                  onTap: () => setState(() => _filter = 0),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Normal',
                  selected: _filter == 1,
                  onTap: () => setState(() => _filter = 1),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Pending',
                  selected: _filter == 2,
                  onTap: () => setState(() => _filter = 2),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              itemCount: _filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final report = _filtered[index];
                return Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => _open(report),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCE8EF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              report.icon,
                              color: AppColors.magenta,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  report.title,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3A55),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${report.value} · ${report.dateLabel}',
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: report.status.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              report.status.label,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: report.status.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.magenta : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.magenta : const Color(0xFFE8DDE2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF2C3A55),
          ),
        ),
      ),
    );
  }
}
