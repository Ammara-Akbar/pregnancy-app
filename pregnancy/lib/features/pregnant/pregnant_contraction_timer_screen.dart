import 'dart:async';

import 'package:flutter/material.dart';

class _Contraction {
  const _Contraction({
    required this.startedAt,
    required this.duration,
    this.interval,
  });

  final DateTime startedAt;
  final Duration duration;
  final Duration? interval;
}

class PregnantContractionTimerScreen extends StatefulWidget {
  const PregnantContractionTimerScreen({super.key});

  @override
  State<PregnantContractionTimerScreen> createState() =>
      _PregnantContractionTimerScreenState();
}

class _PregnantContractionTimerScreenState
    extends State<PregnantContractionTimerScreen> {
  int _tab = 0;
  bool _running = false;
  Duration _elapsed = Duration.zero;
  DateTime? _startedAt;
  Timer? _timer;
  final List<_Contraction> _history = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
      _timer = null;
      final previousStart = _history.isEmpty ? null : _history.first.startedAt;
      setState(() {
        _history.insert(
          0,
          _Contraction(
            startedAt: _startedAt!,
            duration: _elapsed,
            interval: previousStart == null
                ? null
                : _startedAt!.difference(previousStart),
          ),
        );
        _running = false;
        _elapsed = Duration.zero;
        _startedAt = null;
      });
    } else {
      _startedAt = DateTime.now();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() => _elapsed += const Duration(seconds: 1));
        }
      });
      setState(() => _running = true);
    }
  }

  static String _mmss(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get _intensity {
    final last = _history.isEmpty ? null : _history.first;
    if (last == null) return '-';
    if (last.duration.inSeconds < 45) return 'Mild';
    if (last.duration.inSeconds < 75) return 'Moderate';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    final last = _history.isEmpty ? null : _history.first;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'Contraction Timer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Track your contractions',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFF0E5EB)),
              ),
              child: Row(
                children: [
                  for (final (index, label) in const [
                    (0, 'Timer'),
                    (1, 'History'),
                  ])
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tab = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tab == index
                                ? const Color(0xFFFBD9E6)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _tab == index
                                  ? const Color(0xFFDD3D74)
                                  : const Color(0xFF625A79),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_tab == 0) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF0E5EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Last Contraction',
                      style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _TimerStat(
                          label: 'Duration',
                          value: last == null ? '--:--' : _mmss(last.duration),
                        ),
                        _TimerStat(
                          label: 'Interval',
                          value: last?.interval == null
                              ? '--:--'
                              : _mmss(last!.interval!),
                        ),
                        _TimerStat(label: 'Intensity', value: _intensity),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: InkWell(
                  onTap: _toggle,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFF75590), Color(0xFFE72565)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFF73573,
                          ).withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _running
                              ? Icons.stop_circle_outlined
                              : Icons.timer_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _running ? _mmss(_elapsed) : 'Start\nContraction',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                        if (_running)
                          const Text(
                            'Tap to stop',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EDFB),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE9DBF5)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GuidelineRow(
                      text: '< 60 sec & irregular: Likely Braxton Hicks',
                    ),
                    SizedBox(height: 8),
                    _GuidelineRow(text: '60-90 sec & regular: Monitor'),
                    SizedBox(height: 8),
                    _GuidelineRow(text: '> 90 sec & regular: Call your doctor'),
                  ],
                ),
              ),
            ] else if (_history.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 60),
                alignment: Alignment.center,
                child: const Text(
                  'No contractions recorded yet.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF625A79)),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF0E5EB)),
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < _history.length; i++) ...[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFFBD9E6),
                          child: Text(
                            '${_history.length - i}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFDD3D74),
                            ),
                          ),
                        ),
                        title: Text(
                          'Duration ${_mmss(_history[i].duration)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF251064),
                          ),
                        ),
                        subtitle: Text(
                          _history[i].interval == null
                              ? 'First recorded contraction'
                              : 'Interval ${_mmss(_history[i].interval!)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF625A79),
                          ),
                        ),
                        trailing: Text(
                          '${_history[i].startedAt.hour.toString().padLeft(2, '0')}:'
                          '${_history[i].startedAt.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF625A79),
                          ),
                        ),
                      ),
                      if (i < _history.length - 1)
                        const Divider(
                          height: 1,
                          indent: 70,
                          color: Color(0xFFF0E5EB),
                        ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TimerStat extends StatelessWidget {
  const _TimerStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF625A79)),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF171426),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuidelineRow extends StatelessWidget {
  const _GuidelineRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.circle, size: 6, color: Color(0xFFDD3D74)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFF4E416A)),
          ),
        ),
      ],
    );
  }
}
