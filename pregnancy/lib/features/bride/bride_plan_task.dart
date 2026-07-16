import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';

class BridePlanTask {
  const BridePlanTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.icon,
    required this.color,
    required this.steps,
    required this.tips,
    this.done = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String duration;
  final IconData icon;
  final Color color;
  final List<String> steps;
  final List<String> tips;
  final bool done;

  BridePlanTask copyWith({bool? done}) {
    return BridePlanTask(
      id: id,
      title: title,
      subtitle: subtitle,
      duration: duration,
      icon: icon,
      color: color,
      steps: steps,
      tips: tips,
      done: done ?? this.done,
    );
  }

  static List<BridePlanTask> get defaults {
    final desi = UserPreferences.instance.isDesi;
    return [
      BridePlanTask(
        id: 'iron',
        title: 'Eat iron rich foods',
        subtitle: desi
            ? 'Add spinach, daal, and dates to today\'s meals.'
            : 'Add leafy greens, lentils, and lean protein today.',
        duration: 'With meals',
        icon: Icons.rice_bowl_rounded,
        color: const Color(0xFFE07A4A),
        steps: desi
            ? [
                'Include saag, daal, or chickpeas in lunch.',
                'Add soaked almonds or dates as a snack.',
                'Pair with lemon or orange for better iron absorption.',
              ]
            : [
                'Include spinach salad or lentil soup at lunch.',
                'Snack on nuts or an iron-fortified cereal bar.',
                'Pair with citrus fruit for better iron absorption.',
              ],
        tips: const [
          'Avoid tea or coffee right with iron-rich meals.',
          'Stay consistent — small daily choices build long-term health.',
        ],
      ),
      BridePlanTask(
        id: 'folic',
        title: 'Take Folic Acid',
        subtitle: 'Support hormonal balance and future pregnancy readiness.',
        duration: '1 minute',
        icon: Icons.medication_rounded,
        color: const Color(0xFF4CAF7A),
        steps: const [
          'Take your folic acid with water after breakfast.',
          'Mark it done so your streak stays on track.',
          'Set a reminder if you often forget supplements.',
        ],
        tips: const [
          'Ask your doctor about the right dose for you.',
          'Keep supplements visible near your toothbrush or kettle.',
        ],
      ),
      BridePlanTask(
        id: 'walk',
        title: '30 min walk',
        subtitle: 'Gentle movement for energy, mood, and bridal fitness.',
        duration: '30 minutes',
        icon: Icons.directions_walk_rounded,
        color: const Color(0xFF66BB6A),
        steps: const [
          'Put on comfortable shoes and stretch for 2 minutes.',
          'Walk outdoors or indoors at a steady pace.',
          'Finish with deep breathing and a glass of water.',
        ],
        tips: const [
          'Invite a friend or play calming music.',
          'Even 2×15 minutes counts if your day is busy.',
        ],
      ),
      BridePlanTask(
        id: 'water',
        title: 'Drink 8 glasses of water',
        subtitle: 'Hydration supports glow, energy, and digestion.',
        duration: 'All day',
        icon: Icons.local_drink_rounded,
        color: const Color(0xFF5BA8D9),
        steps: const [
          'Start with one glass after waking up.',
          'Sip regularly — aim for a glass every 2 hours.',
          'Track glasses in your progress card tonight.',
        ],
        tips: const [
          'Add lemon or mint if plain water feels boring.',
          'Carry a bottle so drinking stays effortless.',
        ],
      ),
      BridePlanTask(
        id: 'meditate',
        title: '10 min meditation',
        subtitle: 'Calm wedding stress and improve sleep quality.',
        duration: '10 minutes',
        icon: Icons.self_improvement_rounded,
        color: AppColors.magenta,
        steps: const [
          'Find a quiet spot and sit comfortably.',
          'Close your eyes and breathe slowly for 10 minutes.',
          'Note one thing you feel grateful for today.',
        ],
        tips: const [
          'Use a simple timer so you do not check your phone.',
          'Evening practice can help you unwind before bed.',
        ],
      ),
      BridePlanTask(
        id: 'skincare',
        title: 'Evening skincare routine',
        subtitle: 'Keep your glow consistent before the big day.',
        duration: '8 minutes',
        icon: Icons.spa_outlined,
        color: const Color(0xFFE07A4A),
        steps: const [
          'Cleanse gently and pat dry.',
          'Apply moisturizer (and sunscreen in the morning).',
          'Drink water and avoid late-night junk snacks.',
        ],
        tips: const [
          'Patch-test new products well before the wedding.',
          'Sleep is part of skincare — aim for 7–8 hours.',
        ],
      ),
    ];
  }
}
