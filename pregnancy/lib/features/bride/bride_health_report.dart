import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum BrideReportStatus { normal, attention, pending }

extension BrideReportStatusX on BrideReportStatus {
  String get label => switch (this) {
        BrideReportStatus.normal => 'Normal',
        BrideReportStatus.attention => 'Attention',
        BrideReportStatus.pending => 'Pending',
      };

  Color get color => switch (this) {
        BrideReportStatus.normal => const Color(0xFF4CAF7A),
        BrideReportStatus.attention => const Color(0xFFE07A4A),
        BrideReportStatus.pending => AppColors.textMuted,
      };
}

class BrideHealthReport {
  const BrideHealthReport({
    required this.id,
    required this.title,
    required this.value,
    required this.unitNote,
    required this.status,
    required this.icon,
    required this.dateLabel,
    required this.summary,
    required this.recommendations,
  });

  final String id;
  final String title;
  final String value;
  final String unitNote;
  final BrideReportStatus status;
  final IconData icon;
  final String dateLabel;
  final String summary;
  final List<String> recommendations;

  BrideHealthReport copyWith({BrideReportStatus? status, String? value}) {
    return BrideHealthReport(
      id: id,
      title: title,
      value: value ?? this.value,
      unitNote: unitNote,
      status: status ?? this.status,
      icon: icon,
      dateLabel: dateLabel,
      summary: summary,
      recommendations: recommendations,
    );
  }

  static const defaults = [
    BrideHealthReport(
      id: 'hb',
      title: 'Hemoglobin (Hb)',
      value: '12.2 g/dL',
      unitNote: 'Typical adult female range ~12–15 g/dL',
      status: BrideReportStatus.normal,
      icon: Icons.bloodtype_outlined,
      dateLabel: '12 May 2024',
      summary:
          'Your hemoglobin looks healthy. Keep iron-rich meals and hydration consistent.',
      recommendations: [
        'Include leafy greens, lentils, and vitamin C foods.',
        'Avoid tea/coffee with iron-rich meals.',
        'Retest if you feel unusually tired.',
      ],
    ),
    BrideHealthReport(
      id: 'thal',
      title: 'Thalassemia Screening',
      value: 'Negative',
      unitNote: 'Carrier screening result',
      status: BrideReportStatus.normal,
      icon: Icons.biotech_outlined,
      dateLabel: '10 May 2024',
      summary:
          'Screening is negative. Keep a copy of this report for marriage health records.',
      recommendations: [
        'Share results with your partner’s doctor if advised.',
        'Store the report securely in your app bookmarks.',
      ],
    ),
    BrideHealthReport(
      id: 'bg',
      title: 'Blood Group',
      value: 'B+',
      unitNote: 'ABO & Rh typing',
      status: BrideReportStatus.normal,
      icon: Icons.water_drop_outlined,
      dateLabel: '10 May 2024',
      summary: 'Blood group recorded. Useful for future medical care planning.',
      recommendations: [
        'Note this on your emergency profile card.',
        'Ask about Rh considerations during future pregnancy planning.',
      ],
    ),
    BrideHealthReport(
      id: 'fbs',
      title: 'Blood Sugar (FBS)',
      value: '92 mg/dL',
      unitNote: 'Fasting blood sugar',
      status: BrideReportStatus.normal,
      icon: Icons.science_outlined,
      dateLabel: '08 May 2024',
      summary: 'Fasting sugar is within a healthy range.',
      recommendations: [
        'Keep refined sugar limited before the wedding.',
        'Pair carbs with protein/fiber at meals.',
      ],
    ),
    BrideHealthReport(
      id: 'tsh',
      title: 'Thyroid (TSH)',
      value: '2.1 mIU/L',
      unitNote: 'Typical reference often ~0.4–4.0 mIU/L',
      status: BrideReportStatus.normal,
      icon: Icons.favorite_outline,
      dateLabel: '08 May 2024',
      summary: 'TSH looks stable. Maintain consistent sleep and nutrition.',
      recommendations: [
        'Mention any fatigue or hair changes to your doctor.',
        'Keep follow-up as recommended by your clinician.',
      ],
    ),
    BrideHealthReport(
      id: 'vitd',
      title: 'Vitamin D',
      value: 'Pending',
      unitNote: 'Awaiting lab result',
      status: BrideReportStatus.pending,
      icon: Icons.wb_sunny_outlined,
      dateLabel: 'Scheduled',
      summary: 'Result not uploaded yet. Add it when the lab report is ready.',
      recommendations: [
        'Book morning sunlight when possible.',
        'Upload the report as soon as you receive it.',
      ],
    ),
    BrideHealthReport(
      id: 'usg',
      title: 'Ultrasound / Pelvic Exam',
      value: 'Pending',
      unitNote: 'Appointment recommended',
      status: BrideReportStatus.pending,
      icon: Icons.medical_services_outlined,
      dateLabel: 'To schedule',
      summary: 'Not completed yet. Discuss timing with your gynecologist.',
      recommendations: [
        'Prepare questions before your visit.',
        'Take a trusted family member if that helps you feel comfortable.',
      ],
    ),
    BrideHealthReport(
      id: 'rubella',
      title: 'Rubella Immunity',
      value: 'Pending',
      unitNote: 'Immunity screening',
      status: BrideReportStatus.pending,
      icon: Icons.vaccines_outlined,
      dateLabel: 'To schedule',
      summary: 'Pending. Important for future pregnancy readiness.',
      recommendations: [
        'Ask your doctor whether vaccination is needed.',
        'Keep vaccination records with your reports.',
      ],
    ),
  ];
}
