import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bride_health_report.dart';

class BrideReportDetailScreen extends StatefulWidget {
  const BrideReportDetailScreen({super.key, required this.report});

  final BrideHealthReport report;

  @override
  State<BrideReportDetailScreen> createState() =>
      _BrideReportDetailScreenState();
}

class _BrideReportDetailScreenState extends State<BrideReportDetailScreen> {
  late BrideHealthReport _report = widget.report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(_report),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF2C3A55),
          ),
        ),
        title: const Text(
          'Report details',
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
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE8EF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(_report.icon, color: AppColors.magenta, size: 30),
                ),
                const SizedBox(height: 12),
                Text(
                  _report.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _report.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.magenta,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _report.unitNote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _report.status.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _report.status.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _report.status.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _report.dateLabel,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _report.summary,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A3A42),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Recommendations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 10),
          for (final tip in _report.recommendations) ...[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFF0E4EA)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 18,
                    color: AppColors.magenta,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF4A3A42),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_report.status == BrideReportStatus.pending) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _report = _report.copyWith(
                      status: BrideReportStatus.normal,
                      value: _report.title.contains('Vitamin')
                          ? '34 ng/mL'
                          : 'Completed',
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report marked as uploaded.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.magenta,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Mark as uploaded',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
