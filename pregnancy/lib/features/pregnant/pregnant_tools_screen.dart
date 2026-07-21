import 'package:flutter/material.dart';

import 'pregnant_baby_position_assessment_screen.dart';
import 'pregnant_baby_tracker_screen.dart';
import 'pregnant_birth_plan_screen.dart';
import 'pregnant_bp_tracker_screen.dart';
import 'pregnant_contraction_timer_screen.dart';
import 'pregnant_diet_screen.dart';
import 'pregnant_due_date_screen.dart';
import 'pregnant_hospital_bag_screen.dart';
import 'pregnant_kick_counter_screen.dart';
import 'pregnant_medicine_reminder_screen.dart';
import 'pregnant_ovulation_calendar_screen.dart';
import 'pregnant_pain_assessment_screen.dart';
import 'pregnant_water_tracker_screen.dart';
import 'pregnant_weight_tracker_screen.dart';

class PregnantToolsScreen extends StatelessWidget {
  const PregnantToolsScreen({super.key, this.weeksPregnant = 12});

  final int weeksPregnant;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const _ToolsHeader(),
          const SizedBox(height: 4),
          _ToolSection(
            title: 'Baby',
            subtitle: "Track your baby's growth & movements",
            titleColor: const Color(0xFF7B6CD9),
            backgroundColor: const Color(0xFFEFEBFB),
            tools: const [
              _Tool(
                Icons.tag_faces_outlined,
                'Kick Counter',
                Color(0xFFE86B9A),
              ),
              _Tool(Icons.child_care_rounded, 'Baby Growth', Color(0xFFE86B9A)),
              _Tool(
                Icons.event_available_outlined,
                'Due Date',
                Color(0xFFE86B9A),
              ),
              _Tool(
                Icons.swap_vert_circle_outlined,
                'Baby Position',
                Color(0xFF7B6CD9),
              ),
            ],
            onTap: (title) {
              if (title == 'Kick Counter') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantKickCounterScreen(),
                  ),
                );
              } else if (title == 'Baby Growth') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        PregnantBabyTrackerScreen(weeksPregnant: weeksPregnant),
                  ),
                );
              } else if (title == 'Due Date') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantDueDateScreen(),
                  ),
                );
              } else if (title == 'Baby Position') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        const PregnantBabyPositionAssessmentScreen(),
                  ),
                );
              }
            },
          ),
          _ToolSection(
            title: 'Health',
            subtitle: 'Track your health & wellness',
            titleColor: const Color(0xFFD45A8C),
            backgroundColor: const Color(0xFFFDEAF1),
            tools: const [
              _Tool(
                Icons.accessibility_new_rounded,
                'Pain Assessment',
                Color(0xFFD45A8C),
              ),
              _Tool(
                Icons.monitor_weight_outlined,
                'Weight Tracker',
                Color(0xFF5BA8D9),
              ),
              _Tool(
                Icons.favorite_border_rounded,
                'BP Tracker',
                Color(0xFF7B6CD9),
              ),
              _Tool(
                Icons.calendar_month_outlined,
                'Ovulation',
                Color(0xFF8A7A84),
              ),
            ],
            onTap: (title) {
              if (title == 'Pain Assessment') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantPainAssessmentScreen(),
                  ),
                );
              } else if (title == 'Weight Tracker') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantWeightTrackerScreen(),
                  ),
                );
              } else if (title == 'BP Tracker') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantBpTrackerScreen(),
                  ),
                );
              } else if (title == 'Ovulation') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantOvulationCalendarScreen(),
                  ),
                );
              }
            },
          ),
          _ToolSection(
            title: 'Nutrition',
            subtitle: 'Eat right for you & your baby',
            titleColor: const Color(0xFFE8913A),
            backgroundColor: const Color(0xFFFFF2E3),
            tools: const [
              _Tool(Icons.restaurant_rounded, 'Diet Plan', Color(0xFF6BA84C)),
              _Tool(
                Icons.brightness_low_rounded,
                'Vitamins',
                Color(0xFFE8913A),
              ),
              _Tool(
                Icons.water_drop_outlined,
                'Water Tracker',
                Color(0xFF5BA8D9),
              ),
              _Tool(
                Icons.medication_rounded,
                'Medicine Reminder',
                Color(0xFFE07A4A),
              ),
            ],
            onTap: (title) {
              if (title == 'Diet Plan') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        PregnantDietScreen(weeksPregnant: weeksPregnant),
                  ),
                );
              } else if (title == 'Water Tracker') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantWaterTrackerScreen(),
                  ),
                );
              } else if (title == 'Medicine Reminder') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantMedicineReminderScreen(),
                  ),
                );
              }
            },
          ),
          _ToolSection(
            title: 'Labor & Delivery',
            subtitle: 'Prepare for your big day',
            titleColor: const Color(0xFF4A90B8),
            backgroundColor: const Color(0xFFE8F3F9),
            tools: const [
              _Tool(
                Icons.timer_outlined,
                'Contraction Timer',
                Color(0xFF4A90B8),
              ),
              _Tool(
                Icons.work_outline_rounded,
                'Hospital Bag',
                Color(0xFFD45A8C),
              ),
              _Tool(
                Icons.description_outlined,
                'Birth Plan',
                Color(0xFF7B6CD9),
              ),
              _Tool(Icons.air_rounded, 'Breathing', Color(0xFF6BA84C)),
            ],
            onTap: (title) {
              if (title == 'Contraction Timer') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantContractionTimerScreen(),
                  ),
                );
              } else if (title == 'Hospital Bag') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantHospitalBagScreen(),
                  ),
                );
              } else if (title == 'Birth Plan') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PregnantBirthPlanScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ToolsHeader extends StatelessWidget {
  const _ToolsHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pregnancy Tools',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2C3A55),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Everything you need, all in one place',
            style: TextStyle(fontSize: 13, color: Color(0xFF8A7A84)),
          ),
        ],
      ),
    );
  }
}

class _Tool {
  const _Tool(this.icon, this.label, this.color);

  final IconData icon;
  final String label;
  final Color color;
}

class _ToolSection extends StatelessWidget {
  const _ToolSection({
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.backgroundColor,
    required this.tools,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color titleColor;
  final Color backgroundColor;
  final List<_Tool> tools;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A7A84)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < tools.length; i++) ...[
                Expanded(
                  child: _ToolTile(tool: tools[i], onTap: onTap),
                ),
                if (i < tools.length - 1) const SizedBox(width: 10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.tool, required this.onTap});

  final _Tool tool;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => onTap(tool.label),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(tool.icon, color: tool.color, size: 26),
              const SizedBox(height: 8),
              SizedBox(
                height: 28,
                child: Center(
                  child: Text(
                    tool.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3A55),
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
