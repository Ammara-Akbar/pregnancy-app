import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/health_checkup_colors.dart';
import '../providers/health_checkup_provider.dart';
import '../widgets/health_checkup_widgets.dart';
import 'ai_report_screen.dart';

class UploadReportsScreen extends StatelessWidget {
  const UploadReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<HealthCheckupProvider>();

    return HealthCheckupScaffold(
      title: 'Upload Medical Reports',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          PremiumCard(
            gradient: HealthCheckupColors.cardGradient,
            child: Column(
              children: [
                const Icon(
                  Icons.cloud_upload_rounded,
                  size: 48,
                  color: HealthCheckupColors.softPink,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Add lab reports securely',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: HealthCheckupColors.navy,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Camera, gallery, or files — AI can explain results next.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HealthCheckupColors.muted),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _UploadAction(
                        icon: Icons.photo_camera_rounded,
                        label: 'Camera',
                        onTap: () => p.addUpload('Camera_Scan.jpg', 'Camera'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _UploadAction(
                        icon: Icons.photo_library_rounded,
                        label: 'Gallery',
                        onTap: () => p.addUpload('Gallery_Report.jpg', 'Gallery'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _UploadAction(
                        icon: Icons.insert_drive_file_rounded,
                        label: 'Files',
                        onTap: () => p.addUpload('Lab_Report.pdf', 'Files'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Recent Uploads',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: HealthCheckupColors.navy,
            ),
          ),
          const SizedBox(height: 10),
          ...p.uploads.map(
            (u) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PremiumCard(
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: HealthCheckupColors.softPinkLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.description_rounded,
                        color: HealthCheckupColors.softPink,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            u.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: HealthCheckupColors.navy,
                            ),
                          ),
                          Text(
                            '${u.source} · ${u.dateLabel}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: HealthCheckupColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AiReportScreen()),
                );
              },
              icon: const Icon(Icons.auto_awesome_rounded),
              label: const Text('AI Report Analysis'),
              style: FilledButton.styleFrom(
                backgroundColor: HealthCheckupColors.softPink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadAction extends StatelessWidget {
  const _UploadAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: HealthCheckupColors.softPinkLight),
        ),
        child: Column(
          children: [
            Icon(icon, color: HealthCheckupColors.softPink),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: HealthCheckupColors.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
