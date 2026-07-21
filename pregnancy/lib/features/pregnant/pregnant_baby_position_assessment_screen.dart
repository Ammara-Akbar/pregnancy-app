import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _AssessmentQuestion {
  const _AssessmentQuestion(this.prompt, this.options);

  final String prompt;
  final List<String> options;
}

class PregnantBabyPositionAssessmentScreen extends StatefulWidget {
  const PregnantBabyPositionAssessmentScreen({super.key});

  @override
  State<PregnantBabyPositionAssessmentScreen> createState() =>
      _PregnantBabyPositionAssessmentScreenState();
}

class _PregnantBabyPositionAssessmentScreenState
    extends State<PregnantBabyPositionAssessmentScreen> {
  static const _pink = AppColors.magenta;
  static const _questions = [
    _AssessmentQuestion('Where do you feel the strongest kicks?', [
      'High near the ribs',
      'Low in the pelvis',
      'Mostly on the left',
      'Mostly on the right',
      'All over',
    ]),
    _AssessmentQuestion("Where do you feel the baby's movements more often?", [
      'Lower abdomen',
      'Upper abdomen',
      'Left side',
      'Right side',
      'All over',
    ]),
    _AssessmentQuestion('Where do you feel a firm, rounded area?', [
      'Upper abdomen',
      'Lower abdomen',
      'Left side',
      'Right side',
      'Not sure',
    ]),
    _AssessmentQuestion('Where do you feel regular hiccups?', [
      'Low in the abdomen',
      'High in the abdomen',
      'Left side',
      'Right side',
      'I have not noticed',
    ]),
    _AssessmentQuestion('Where do you feel the most pressure?', [
      'Deep in the pelvis',
      'Under the ribs',
      'Across the abdomen',
      'Mostly on one side',
      'No strong pressure',
    ]),
    _AssessmentQuestion('How would you describe your bump shape?', [
      'More rounded in front',
      'Wider across the sides',
      'Lower and forward',
      'Higher under the ribs',
      'Not sure',
    ]),
  ];

  final List<int?> _answers = List<int?>.filled(_questions.length, null);
  int _questionIndex = 0;
  bool _showResult = false;

  void _next() {
    if (_answers[_questionIndex] == null) return;
    if (_questionIndex < _questions.length - 1) {
      setState(() => _questionIndex++);
    } else {
      setState(() => _showResult = true);
    }
  }

  void _back() {
    if (_showResult) {
      setState(() => _showResult = false);
    } else if (_questionIndex > 0) {
      setState(() => _questionIndex--);
    } else {
      Navigator.pop(context);
    }
  }

  String get _possiblePosition {
    final upperKicks = _answers[0] == 0 || _answers[1] == 1;
    final pelvicPressure = _answers[4] == 0;
    if (upperKicks && pelvicPressure) return 'Baby may be head-down';
    if (_answers[0] == 1 || _answers[2] == 1) {
      return 'Baby may be in a breech position';
    }
    if (_answers[4] == 2 || _answers[5] == 1) {
      return 'Baby may be lying across your abdomen';
    }
    return 'Baby’s position is not clear yet';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        leading: IconButton(
          onPressed: _back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        centerTitle: true,
        title: const Text(
          'Baby Position Assessment',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: _showResult ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_questionIndex];
    return Column(
      children: [
        const Text(
          'Answer a few questions to get an idea',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${_questionIndex + 1} of ${_questions.length}',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (_questionIndex + 1) / _questions.length,
                  minHeight: 7,
                  backgroundColor: AppColors.ringPink,
                  valueColor: const AlwaysStoppedAnimation(_pink),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.mistPink),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.prompt,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (var i = 0; i < question.options.length; i++) ...[
                      _AnswerTile(
                        label: question.options[i],
                        selected: _answers[_questionIndex] == i,
                        onTap: () {
                          setState(() => _answers[_questionIndex] = i);
                        },
                      ),
                      if (i < question.options.length - 1)
                        const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const _MedicalNotice(),
              const SizedBox(height: 14),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: _answers[_questionIndex] == null ? null : _next,
              style: FilledButton.styleFrom(
                backgroundColor: _pink,
                disabledBackgroundColor: AppColors.ringPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Text(
                _questionIndex == _questions.length - 1 ? 'See Result' : 'Next',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResult() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.mistPink),
          ),
          child: Column(
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blush,
                ),
                child: const Icon(
                  Icons.child_friendly_rounded,
                  size: 42,
                  color: _pink,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Assessment Result',
                style: TextStyle(fontSize: 13, color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              Text(
                _possiblePosition,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your answers provide only a general indication. Baby position '
                'can change frequently, especially before the final weeks.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const _MedicalNotice(),
        const SizedBox(height: 18),
        SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: () {
              setState(() {
                _answers.fillRange(0, _answers.length, null);
                _questionIndex = 0;
                _showResult = false;
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: _pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: const Text(
              'Retake Assessment',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.softPink : AppColors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: selected ? AppColors.magenta : AppColors.mistPink,
            width: selected ? 1.3 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.magenta : AppColors.skipGrey,
                  width: selected ? 4 : 1.4,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: selected ? AppColors.magenta : AppColors.textDark,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_rounded,
                size: 17,
                color: AppColors.magenta,
              ),
          ],
        ),
      ),
    );
  }
}

class _MedicalNotice extends StatelessWidget {
  const _MedicalNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.medical_information_outlined,
            size: 24,
            color: AppColors.magenta,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'This is not a medical diagnosis.\n'
              'Please confirm with your healthcare professional.',
              style: TextStyle(
                fontSize: 10.5,
                height: 1.5,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
