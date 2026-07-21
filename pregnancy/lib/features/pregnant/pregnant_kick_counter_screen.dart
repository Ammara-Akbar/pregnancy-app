import 'dart:async';

import 'package:flutter/material.dart';

class PregnantKickCounterScreen extends StatefulWidget {
  const PregnantKickCounterScreen({super.key});

  @override
  State<PregnantKickCounterScreen> createState() =>
      _PregnantKickCounterScreenState();
}

class _PregnantKickCounterScreenState extends State<PregnantKickCounterScreen> {
  static const _pink = Color(0xFFF73573);
  int _kicks = 0;
  int _elapsedSeconds = 0;
  int _sessions = 0;
  int _totalKicks = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _recordKick() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsedSeconds++);
    });
    setState(() => _kicks++);
  }

  void _endSession() {
    if (_kicks == 0) return;
    _timer?.cancel();
    _timer = null;
    setState(() {
      _sessions++;
      _totalKicks += _kicks;
      _kicks = 0;
      _elapsedSeconds = 0;
    });
  }

  String get _time {
    final hours = (_elapsedSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_elapsedSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final average = _sessions == 0 ? 0 : (_totalKicks / _sessions).round();
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF21145F),
        centerTitle: true,
        title: const Text(
          'Kick Counter',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
          children: [
            const Text(
              "Count your baby's kicks to track their movements.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 34),
            Center(
              child: Container(
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD9C9F4), width: 10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.child_friendly_rounded,
                      color: Color(0xFF8060BF),
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_kicks',
                      style: const TextStyle(
                        fontSize: 48,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF251064),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kicks',
                      style: TextStyle(fontSize: 13, color: Color(0xFF625A79)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Session Time',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF625A79)),
            ),
            const SizedBox(height: 4),
            Text(
              _time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF251064),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _recordKick,
                style: FilledButton.styleFrom(
                  backgroundColor: _pink,
                  shape: const StadiumBorder(),
                ),
                icon: const Icon(Icons.touch_app_outlined, size: 20),
                label: const Text(
                  'Kick Detected',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: _endSession,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _pink,
                  side: const BorderSide(color: Color(0xFFFFA7C0)),
                  shape: const StadiumBorder(),
                ),
                child: const Text('End Session'),
              ),
            ),
            const SizedBox(height: 38),
            _SummaryCard(
              sessions: _sessions,
              totalKicks: _totalKicks,
              average: average,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.sessions,
    required this.totalKicks,
    required this.average,
  });

  final int sessions;
  final int totalKicks;
  final int average;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Today's Summary",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF251064),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _SummaryValue(label: 'Sessions', value: '$sessions'),
              _SummaryValue(label: 'Total Kicks', value: '$totalKicks'),
              _SummaryValue(label: 'Avg. per Hour', value: '$average'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({required this.label, required this.value});

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
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF251064),
            ),
          ),
        ],
      ),
    );
  }
}
