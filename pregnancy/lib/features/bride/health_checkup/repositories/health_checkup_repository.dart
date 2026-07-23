import 'package:flutter/material.dart';

import '../constants/health_checkup_colors.dart';
import '../models/health_checkup_models.dart';

class HealthCheckupRepository {
  List<HealthCategory> seedCategories() {
    return [
      HealthCategory(
        id: HealthCategoryId.essential,
        title: 'Essential Health',
        description: 'Core labs & vitals for readiness.',
        icon: Icons.favorite_rounded,
        accent: HealthCheckupColors.softPink,
        items: const [
          HealthTestItem(
            id: 'cbc',
            title: 'CBC',
            description: 'Complete blood count baseline.',
            status: HealthItemStatus.completed,
            aiNote: 'Within expected range for age.',
            severity: 'Normal',
          ),
          HealthTestItem(
            id: 'blood_group',
            title: 'Blood Group',
            description: 'ABO and Rh typing.',
            status: HealthItemStatus.completed,
            aiNote: 'Record saved for partner matching.',
            severity: 'Normal',
          ),
          HealthTestItem(
            id: 'bp',
            title: 'Blood Pressure',
            description: 'Resting BP measurement.',
            status: HealthItemStatus.completed,
            severity: 'Normal',
          ),
          HealthTestItem(
            id: 'sugar',
            title: 'Blood Sugar',
            description: 'Fasting glucose check.',
            status: HealthItemStatus.pending,
            reminder: 'Schedule this week',
          ),
          HealthTestItem(
            id: 'bmi',
            title: 'BMI',
            description: 'Body mass index assessment.',
            status: HealthItemStatus.completed,
            severity: 'Normal',
          ),
          HealthTestItem(
            id: 'weight',
            title: 'Weight',
            description: 'Current body weight.',
            status: HealthItemStatus.completed,
          ),
          HealthTestItem(
            id: 'height',
            title: 'Height',
            description: 'Standing height measurement.',
            status: HealthItemStatus.completed,
          ),
        ],
      ),
      HealthCategory(
        id: HealthCategoryId.genetic,
        title: 'Genetic Screening',
        description: 'Thalassemia & family history.',
        icon: Icons.biotech_rounded,
        accent: HealthCheckupColors.lavender,
        items: const [
          HealthTestItem(
            id: 'thalassemia',
            title: 'Thalassemia Screening',
            description: 'Carrier screening before marriage.',
            status: HealthItemStatus.completed,
            expandable: true,
            aiNote: 'No carrier traits detected in report.',
            severity: 'Normal',
          ),
          HealthTestItem(
            id: 'family_history',
            title: 'Family Medical History',
            description: 'Inherited conditions questionnaire.',
            status: HealthItemStatus.pending,
            expandable: true,
            reminder: 'Complete with family',
          ),
          HealthTestItem(
            id: 'genetic_counsel',
            title: 'Genetic Counseling',
            description: 'Optional counseling session.',
            status: HealthItemStatus.optional,
            expandable: true,
          ),
        ],
      ),
      HealthCategory(
        id: HealthCategoryId.infectious,
        title: 'Infectious Disease Screening',
        description: 'Protect yourself & future pregnancy.',
        icon: Icons.bloodtype_rounded,
        accent: HealthCheckupColors.red,
        items: const [
          HealthTestItem(
            id: 'hiv',
            title: 'HIV Screening',
            description: 'Pre-marriage infectious panel.',
            status: HealthItemStatus.completed,
            severity: 'Normal',
          ),
          HealthTestItem(
            id: 'hep_c',
            title: 'Hepatitis C',
            description: 'HCV antibody test.',
            status: HealthItemStatus.pending,
          ),
          HealthTestItem(
            id: 'syphilis',
            title: 'Syphilis (VDRL)',
            description: 'Standard premarital screen.',
            status: HealthItemStatus.pending,
          ),
        ],
      ),
      HealthCategory(
        id: HealthCategoryId.womens,
        title: "Women's Health",
        description: 'Hormones, iron & cycle health.',
        icon: Icons.spa_rounded,
        accent: const Color(0xFFE89AB8),
        items: const [
          HealthTestItem(
            id: 'thyroid',
            title: 'Thyroid',
            description: 'TSH / T3 / T4 panel.',
            status: HealthItemStatus.completed,
            severity: 'Normal',
            reminder: 'Retest in 6 months',
          ),
          HealthTestItem(
            id: 'iron',
            title: 'Iron',
            description: 'Ferritin & serum iron.',
            status: HealthItemStatus.pending,
            severity: 'Low',
            reminder: 'Upload latest report',
            aiNote: 'Iron appears low — discuss diet with doctor.',
          ),
          HealthTestItem(
            id: 'vit_d',
            title: 'Vitamin D',
            description: '25-OH Vitamin D level.',
            status: HealthItemStatus.pending,
            severity: 'Low',
          ),
          HealthTestItem(
            id: 'hormones',
            title: 'Hormone Assessment',
            description: 'Reproductive hormone overview.',
            status: HealthItemStatus.pending,
          ),
          HealthTestItem(
            id: 'pcos',
            title: 'PCOS Screening',
            description: 'Clinical & lab markers.',
            status: HealthItemStatus.optional,
          ),
          HealthTestItem(
            id: 'cycle',
            title: 'Cycle Health',
            description: 'Cycle regularity tracking.',
            status: HealthItemStatus.completed,
          ),
        ],
      ),
      HealthCategory(
        id: HealthCategoryId.vaccinations,
        title: 'Vaccinations',
        description: 'Immunizations for a healthy start.',
        icon: Icons.vaccines_rounded,
        accent: HealthCheckupColors.peach,
        items: const [
          HealthTestItem(
            id: 'rubella',
            title: 'Rubella',
            description: 'MMR / Rubella immunity.',
            status: HealthItemStatus.completed,
          ),
          HealthTestItem(
            id: 'hpv',
            title: 'HPV',
            description: 'HPV vaccination series.',
            status: HealthItemStatus.pending,
          ),
          HealthTestItem(
            id: 'hepb',
            title: 'Hepatitis B',
            description: 'Hep B vaccine status.',
            status: HealthItemStatus.completed,
          ),
          HealthTestItem(
            id: 'tetanus',
            title: 'Tetanus',
            description: 'Td / Tdap booster.',
            status: HealthItemStatus.completed,
          ),
          HealthTestItem(
            id: 'covid',
            title: 'COVID Vaccine',
            description: 'Primary series + boosters.',
            status: HealthItemStatus.completed,
          ),
        ],
      ),
      HealthCategory(
        id: HealthCategoryId.partner,
        title: 'Future Partner',
        description: 'Optional partner readiness checks.',
        icon: Icons.people_alt_rounded,
        accent: const Color(0xFF5BA8D9),
        optional: true,
        items: const [
          HealthTestItem(
            id: 'partner_bg',
            title: 'Partner Blood Group',
            description: 'ABO/Rh compatibility planning.',
            status: HealthItemStatus.optional,
          ),
          HealthTestItem(
            id: 'partner_thal',
            title: 'Partner Thalassemia Test',
            description: 'Carrier screening for partner.',
            status: HealthItemStatus.optional,
          ),
          HealthTestItem(
            id: 'partner_general',
            title: 'General Health',
            description: 'Basic wellness checkup.',
            status: HealthItemStatus.optional,
          ),
          HealthTestItem(
            id: 'semen',
            title: 'Semen Analysis',
            description: 'Optional fertility assessment.',
            status: HealthItemStatus.optional,
          ),
        ],
      ),
    ];
  }

  List<UploadedReport> seedUploads() => const [
        UploadedReport(
          id: 'u1',
          name: 'CBC_Report.pdf',
          dateLabel: '2 days ago',
          source: 'Files',
        ),
        UploadedReport(
          id: 'u2',
          name: 'Thyroid_Panel.jpg',
          dateLabel: '1 week ago',
          source: 'Gallery',
        ),
      ];

  List<AiFinding> seedAiFindings() => const [
        AiFinding(
          title: 'CBC',
          status: 'Normal',
          severity: HealthSeverity.normal,
          recommendation: 'Maintain balanced nutrition and hydration.',
        ),
        AiFinding(
          title: 'Iron',
          status: 'Low',
          severity: HealthSeverity.caution,
          recommendation:
              'Increase iron-rich foods. Visit doctor if symptoms continue.',
        ),
        AiFinding(
          title: 'Vitamin D',
          status: 'Low',
          severity: HealthSeverity.caution,
          recommendation: 'Discuss supplementation with your physician.',
        ),
        AiFinding(
          title: 'Blood Sugar',
          status: 'Pending',
          severity: HealthSeverity.critical,
          recommendation: 'Complete fasting glucose test soon.',
        ),
      ];

  List<DoctorProfile> seedDoctors() => const [
        DoctorProfile(
          id: 'd1',
          name: 'Dr. Ayesha Malik',
          specialty: 'Gynecologist',
          distance: '1.2 km',
          rating: 4.9,
        ),
        DoctorProfile(
          id: 'd2',
          name: 'Dr. Sara Khan',
          specialty: 'Reproductive Health',
          distance: '2.4 km',
          rating: 4.8,
        ),
        DoctorProfile(
          id: 'd3',
          name: 'Dr. Hina Raza',
          specialty: 'Women\'s Wellness',
          distance: '3.1 km',
          rating: 4.7,
        ),
      ];
}
