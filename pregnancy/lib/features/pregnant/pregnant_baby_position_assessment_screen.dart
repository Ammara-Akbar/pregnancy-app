import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum _TorsoHighlight { lower, upper, left, right, all, none, round, oval }

class _AssessmentQuestion {
  const _AssessmentQuestion(this.prompt, this.options, this.highlights);

  final String prompt;
  final List<String> options;
  final List<_TorsoHighlight> highlights;
}

class PregnantBabyPositionAssessmentScreen extends StatefulWidget {
  const PregnantBabyPositionAssessmentScreen({super.key});

  @override
  State<PregnantBabyPositionAssessmentScreen> createState() =>
      _PregnantBabyPositionAssessmentScreenState();
}

class _PregnantBabyPositionAssessmentScreenState
    extends State<PregnantBabyPositionAssessmentScreen> {
  static const _questions = [
    _AssessmentQuestion(
      'Is this your first pregnancy?',
      ['Yes', 'No', 'Not sure'],
      [_TorsoHighlight.none, _TorsoHighlight.none, _TorsoHighlight.none],
    ),
    _AssessmentQuestion(
      'How would you describe your belly?',
      ['Round', 'Oval / longer', 'Wide across sides', 'Not sure'],
      [
        _TorsoHighlight.round,
        _TorsoHighlight.oval,
        _TorsoHighlight.all,
        _TorsoHighlight.none,
      ],
    ),
    _AssessmentQuestion(
      "Where do you feel most of your baby's movements?",
      ['Lower abdomen', 'Upper abdomen', 'Left side', 'Right side', 'All over'],
      [
        _TorsoHighlight.lower,
        _TorsoHighlight.upper,
        _TorsoHighlight.left,
        _TorsoHighlight.right,
        _TorsoHighlight.all,
      ],
    ),
    _AssessmentQuestion(
      'Where do you feel the strongest kicks?',
      [
        'High near the ribs',
        'Low in the pelvis',
        'Mostly on the left',
        'Mostly on the right',
        'All over',
      ],
      [
        _TorsoHighlight.upper,
        _TorsoHighlight.lower,
        _TorsoHighlight.left,
        _TorsoHighlight.right,
        _TorsoHighlight.all,
      ],
    ),
    _AssessmentQuestion(
      'Where do you feel a firm, rounded area (possible head or bottom)?',
      ['Upper abdomen', 'Lower abdomen', 'Left side', 'Right side', 'Not sure'],
      [
        _TorsoHighlight.upper,
        _TorsoHighlight.lower,
        _TorsoHighlight.left,
        _TorsoHighlight.right,
        _TorsoHighlight.none,
      ],
    ),
    _AssessmentQuestion(
      'Where do you feel regular hiccups?',
      [
        'Low in the abdomen',
        'High in the abdomen',
        'Left side',
        'Right side',
        'I have not noticed',
      ],
      [
        _TorsoHighlight.lower,
        _TorsoHighlight.upper,
        _TorsoHighlight.left,
        _TorsoHighlight.right,
        _TorsoHighlight.none,
      ],
    ),
    _AssessmentQuestion(
      'Where do you feel the most pressure?',
      [
        'Deep in the pelvis',
        'Under the ribs',
        'Across the abdomen',
        'Mostly on one side',
        'No strong pressure',
      ],
      [
        _TorsoHighlight.lower,
        _TorsoHighlight.upper,
        _TorsoHighlight.all,
        _TorsoHighlight.right,
        _TorsoHighlight.none,
      ],
    ),
    _AssessmentQuestion(
      'In the last week, has baby’s movement pattern felt consistent?',
      ['Yes, mostly consistent', 'It changes day to day', 'Not sure yet'],
      [_TorsoHighlight.none, _TorsoHighlight.none, _TorsoHighlight.none],
    ),
  ];

  final List<int?> _answers = List<int?>.filled(_questions.length, null);
  int _questionIndex = 0;
  bool _showResult = false;

  double get _progress => (_questionIndex + 1) / _questions.length;

  void _next() {
    if (_answers[_questionIndex] == null) return;
    if (_questionIndex < _questions.length - 1) {
      setState(() => _questionIndex++);
    } else {
      setState(() => _showResult = true);
    }
  }

  void _previous() {
    if (_showResult) {
      setState(() => _showResult = false);
      return;
    }
    if (_questionIndex > 0) {
      setState(() => _questionIndex--);
    }
  }

  void _jumpToQuestion(int index) {
    setState(() {
      _showResult = false;
      _questionIndex = index;
    });
  }

  String get _possiblePosition {
    final movements = _answers[2];
    final kicks = _answers[3];
    final firm = _answers[4];
    final pressure = _answers[6];

    final headDownSignals =
        (kicks == 0 ? 1 : 0) +
        (movements == 1 ? 1 : 0) +
        (firm == 1 ? 1 : 0) +
        (pressure == 0 ? 1 : 0);
    final breechSignals =
        (kicks == 1 ? 1 : 0) +
        (movements == 0 ? 1 : 0) +
        (firm == 0 ? 1 : 0) +
        (pressure == 1 ? 1 : 0);
    final transverseSignals =
        (movements == 2 || movements == 3 ? 1 : 0) + (pressure == 3 ? 1 : 0);

    if (headDownSignals >= 2) return 'Baby may be head-down (cephalic)';
    if (breechSignals >= 2) return 'Baby may be in a breech position';
    if (transverseSignals >= 2) return 'Baby may be lying sideways';
    return 'Baby’s position is not clear yet';
  }

  void _showInfo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'About this assessment',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.burgundy,
          ),
        ),
        content: const Text(
          'These questions give a general idea only. Baby position can change '
          'often and should always be confirmed by your healthcare professional.',
          style: TextStyle(height: 1.4, color: AppColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: AppColors.magenta,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5F8),
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Baby Position Assessment',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: _showInfo,
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: _showResult ? _buildResult() : _buildQuestionFlow(),
      ),
    );
  }

  Widget _buildQuestionFlow() {
    final question = _questions[_questionIndex];
    final answeredBefore = <int>[
      for (var i = 0; i <= _questionIndex; i++)
        if (_answers[i] != null) i,
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
      children: [
        const Text(
          'Answer a few questions to get an idea of your baby\'s position.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.5,
            height: 1.35,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 14),
        const _DisclaimerBanner(),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.mistPink),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Question ${_questionIndex + 1} of ${_questions.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${(_progress * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.magenta,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: AppColors.ringPink,
                  color: AppColors.magenta,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                question.prompt,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.burgundy,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < question.options.length; i++) ...[
                _AnswerTile(
                  label: question.options[i],
                  highlight: question.highlights[i],
                  selected: _answers[_questionIndex] == i,
                  onTap: () => setState(() => _answers[_questionIndex] = i),
                ),
                if (i < question.options.length - 1) const SizedBox(height: 8),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _questionIndex == 0 ? null : _previous,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.burgundy,
                        disabledForegroundColor: AppColors.skipGrey,
                        side: const BorderSide(color: AppColors.ringPink),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: _answers[_questionIndex] == null
                          ? null
                          : _next,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.magenta,
                        disabledBackgroundColor: AppColors.ringPink,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _questionIndex == _questions.length - 1
                            ? 'See Result'
                            : 'Next',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (answeredBefore.isNotEmpty) ...[
          const SizedBox(height: 16),
          _PreviousAnswersCard(
            questions: _questions,
            answers: _answers,
            visibleIndexes: answeredBefore,
            currentIndex: _questionIndex,
            onEdit: _jumpToQuestion,
          ),
        ],
      ],
    );
  }

  Widget _buildResult() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
      children: [
        const _DisclaimerBanner(),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.mistPink),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/baby_position_fetus.png',
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Assessment Result',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _possiblePosition,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.burgundy,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your answers provide only a general indication. Baby position '
                'can change frequently, especially before the final weeks.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.45,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _PreviousAnswersCard(
          questions: _questions,
          answers: _answers,
          visibleIndexes: [
            for (var i = 0; i < _questions.length; i++)
              if (_answers[i] != null) i,
          ],
          currentIndex: -1,
          onEdit: _jumpToQuestion,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: () {
              setState(() {
                _answers.fillRange(0, _answers.length, null);
                _questionIndex = 0;
                _showResult = false;
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.magenta,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Retake Assessment',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}

class _DisclaimerBanner extends StatelessWidget {
  const _DisclaimerBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.health_and_safety_outlined,
              color: AppColors.burgundy,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'This is not a medical diagnosis. Please confirm with your '
              'healthcare professional.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                fontWeight: FontWeight.w600,
                color: AppColors.burgundy,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/baby_position_fetus.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.label,
    required this.highlight,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final _TorsoHighlight highlight;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.softPink : AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.magenta : AppColors.mistPink,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              _TorsoIcon(highlight: highlight, selected: selected),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? AppColors.magenta : AppColors.textDark,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: AppColors.magenta,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TorsoIcon extends StatelessWidget {
  const _TorsoIcon({required this.highlight, required this.selected});

  final _TorsoHighlight highlight;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: selected ? AppColors.white : AppColors.softPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomPaint(
        painter: _TorsoPainter(
          highlight: highlight,
          accent: selected ? AppColors.magenta : AppColors.burgundy,
        ),
      ),
    );
  }
}

class _TorsoPainter extends CustomPainter {
  _TorsoPainter({required this.highlight, required this.accent});

  final _TorsoHighlight highlight;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final outline = Paint()
      ..color = accent.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final fill = Paint()
      ..color = accent.withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.28,
        size.height * 0.18,
        size.width * 0.44,
        size.height * 0.62,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(body, outline);

    late Rect hotspot;
    switch (highlight) {
      case _TorsoHighlight.lower:
        hotspot = Rect.fromLTWH(
          size.width * 0.34,
          size.height * 0.48,
          size.width * 0.32,
          size.height * 0.22,
        );
      case _TorsoHighlight.upper:
        hotspot = Rect.fromLTWH(
          size.width * 0.34,
          size.height * 0.24,
          size.width * 0.32,
          size.height * 0.2,
        );
      case _TorsoHighlight.left:
        hotspot = Rect.fromLTWH(
          size.width * 0.28,
          size.height * 0.32,
          size.width * 0.18,
          size.height * 0.34,
        );
      case _TorsoHighlight.right:
        hotspot = Rect.fromLTWH(
          size.width * 0.54,
          size.height * 0.32,
          size.width * 0.18,
          size.height * 0.34,
        );
      case _TorsoHighlight.all:
      case _TorsoHighlight.round:
      case _TorsoHighlight.oval:
        hotspot = Rect.fromLTWH(
          size.width * 0.32,
          size.height * 0.28,
          size.width * 0.36,
          size.height * 0.42,
        );
      case _TorsoHighlight.none:
        return;
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(hotspot, const Radius.circular(6)),
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant _TorsoPainter oldDelegate) {
    return oldDelegate.highlight != highlight || oldDelegate.accent != accent;
  }
}

class _PreviousAnswersCard extends StatelessWidget {
  const _PreviousAnswersCard({
    required this.questions,
    required this.answers,
    required this.visibleIndexes,
    required this.currentIndex,
    required this.onEdit,
  });

  final List<_AssessmentQuestion> questions;
  final List<int?> answers;
  final List<int> visibleIndexes;
  final int currentIndex;
  final ValueChanged<int> onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.softPink,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Your Previous Answers',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.burgundy,
                  ),
                ),
              ),
              TextButton(
                onPressed: visibleIndexes.isEmpty
                    ? null
                    : () => onEdit(visibleIndexes.first),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.magenta,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (var n = 0; n < visibleIndexes.length; n++) ...[
            Builder(
              builder: (context) {
                final i = visibleIndexes[n];
                final answerIndex = answers[i];
                if (answerIndex == null) return const SizedBox.shrink();
                final isCurrent = i == currentIndex;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: n == visibleIndexes.length - 1 ? 0 : 8,
                  ),
                  child: InkWell(
                    onTap: () => onEdit(i),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${n + 1}.',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.burgundy,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: isCurrent
                                      ? '(Current) ${questions[i].prompt}'
                                      : questions[i].prompt,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.35,
                                    color: AppColors.burgundy,
                                  ),
                                ),
                                const TextSpan(text: '  —  '),
                                TextSpan(
                                  text: questions[i].options[answerIndex],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.35,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.burgundy,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
