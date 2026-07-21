import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantWeightTrackerScreen extends StatefulWidget {
  const PregnantWeightTrackerScreen({super.key});

  @override
  State<PregnantWeightTrackerScreen> createState() =>
      _PregnantWeightTrackerScreenState();
}

class _PregnantWeightTrackerScreenState
    extends State<PregnantWeightTrackerScreen> {
  double _currentWeight = 65.8;
  static const _startingWeight = 59.6;

  Future<void> _updateWeight() async {
    final controller = TextEditingController(
      text: _currentWeight.toStringAsFixed(1),
    );
    final value = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update weight'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Current weight',
            suffixText: 'kg',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final weight = double.tryParse(controller.text);
              Navigator.pop(context, weight);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null && value > 0 && mounted) {
      setState(() => _currentWeight = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gain = _currentWeight - _startingWeight;
    final isHealthy = gain >= 5 && gain <= 11.5;
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        centerTitle: true,
        title: const Text(
          'Weight Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Update weight',
            onPressed: _updateWeight,
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            const Text(
              'Track your weight gain during pregnancy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 22),
            _InfoCard(
              child: Row(
                children: [
                  Expanded(
                    child: _Metric(
                      label: 'Current Weight',
                      value: _currentWeight.toStringAsFixed(1),
                      unit: 'kg',
                    ),
                  ),
                  const SizedBox(
                    height: 52,
                    child: VerticalDivider(color: AppColors.mistPink),
                  ),
                  Expanded(
                    child: _Metric(
                      label: 'Total Gain',
                      value: gain.toStringAsFixed(1),
                      unit: 'kg',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    isHealthy ? 'Good' : 'Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isHealthy
                          ? AppColors.iconHealth
                          : AppColors.iconMedicine,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isHealthy
                        ? 'You are in a healthy range'
                        : 'Check your recommended weight range',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: (gain / 11.5).clamp(0, 1),
                      backgroundColor: AppColors.ringPink,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.iconHealth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${gain.toStringAsFixed(1)} kg / 11.5 kg',
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weight Gain (kg)',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _WeightChartPainter(
                        currentWeight: _currentWeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const _InfoCard(
              tint: AppColors.blush,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended Range',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  SizedBox(height: 7),
                  Text(
                    '5.0 kg - 11.5 kg',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.burgundy,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Total Weight Gain',
                    style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child, this.tint = AppColors.white});

  final Widget child;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: child,
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.unit});

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.burgundy,
            ),
            children: [
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeightChartPainter extends CustomPainter {
  const _WeightChartPainter({required this.currentWeight});

  final double currentWeight;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = AppColors.mistPink
      ..strokeWidth = 1;
    final line = Paint()
      ..color = AppColors.magenta
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final dot = Paint()..color = AppColors.magenta;
    final values = [59.6, 61.7, 65.0, 68.9, 72.5, 75.0, currentWeight];
    const labels = ['5w', '10w', '15w', '20w', '25w', '30w', '40w'];
    const left = 8.0;
    final chartBottom = size.height - 24;

    for (var i = 0; i < 4; i++) {
      final y = i * chartBottom / 3;
      canvas.drawLine(Offset(left, y), Offset(size.width, y), grid);
    }

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = left + i * (size.width - left) / (values.length - 1);
      final normalized = ((values[i] - 50) / 35).clamp(0.0, 1.0);
      final y = chartBottom - normalized * (chartBottom - 8);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 3.5, dot);
      final text = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      text.paint(canvas, Offset(x - text.width / 2, chartBottom + 8));
    }
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _WeightChartPainter oldDelegate) =>
      oldDelegate.currentWeight != currentWeight;
}
