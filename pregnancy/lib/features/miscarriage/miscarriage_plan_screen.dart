import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MiscarriagePlanScreen extends StatelessWidget {
  const MiscarriagePlanScreen({super.key});

  static const _roadmap = [
    (
      'Physical Healing',
      'Weeks 1-2',
      'Rest, nutrition, and hydration to help your body recover.',
      true,
    ),
    (
      'Hormonal Balance',
      'Weeks 3-4',
      'Support hormones and gently track your cycle.',
      false,
    ),
    (
      'Emotional Healing',
      'Weeks 5-6',
      'Mind care, stress relief, and emotional support.',
      false,
    ),
    (
      'Trying Again (When Ready)',
      'Weeks 7-8',
      'Preconception care when you feel ready.',
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Recovery Plan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Personalized plan for your healing',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF2C3A55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Healing Progress',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3A55),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Week 2 of 8',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '25%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.magenta,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        child: LinearProgressIndicator(
                          value: 0.25,
                          minHeight: 8,
                          backgroundColor: Color(0xFFF0C8D8),
                          color: AppColors.magenta,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.self_improvement_rounded,
                    color: AppColors.magenta,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.ringPink),
            ),
            child: const Row(
              children: [
                Icon(Icons.favorite, color: AppColors.magenta, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Be gentle with yourself every day. Healing takes time and that\'s okay.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3A55),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Recovery Roadmap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                for (var i = 0; i < _roadmap.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _roadmap[i].$4
                                    ? AppColors.magenta
                                    : Colors.transparent,
                                border: Border.all(
                                  color: _roadmap[i].$4
                                      ? AppColors.magenta
                                      : AppColors.ringPink,
                                  width: 2,
                                ),
                              ),
                              child: _roadmap[i].$4
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            if (i < _roadmap.length - 1)
                              Container(
                                width: 2,
                                height: 42,
                                color: AppColors.ringPink,
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_roadmap[i].$1} (${_roadmap[i].$2})',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2C3A55),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _roadmap[i].$3,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.textMuted,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    '"I am healing. I am growing. I am becoming stronger every day."',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF2C3A55),
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.favorite, color: AppColors.magenta, size: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
