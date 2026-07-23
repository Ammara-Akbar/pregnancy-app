import '../models/health_checkup_models.dart';

class ReadinessScoreService {
  const ReadinessScoreService();

  int calculate({
    required List<HealthCategory> categories,
    required LifestyleAnswers lifestyle,
  }) {
    var completed = 0;
    var total = 0;
    var vaccinesDone = 0;
    var vaccinesTotal = 0;

    for (final c in categories) {
      if (c.optional) continue;
      completed += c.completedCount;
      total += c.totalCount;
      if (c.id == HealthCategoryId.vaccinations) {
        vaccinesDone = c.completedCount;
        vaccinesTotal = c.totalCount;
      }
    }

    final testScore = total == 0 ? 0.0 : completed / total;
    final vaccineScore =
        vaccinesTotal == 0 ? 0.0 : vaccinesDone / vaccinesTotal;
    final lifestyleScore = lifestyle.score / 100.0;
    final bmiScore = (lifestyle.bmi >= 18.5 && lifestyle.bmi <= 24.9) ? 1.0 : 0.6;
    final hydrationScore = (lifestyle.waterGlasses / 8).clamp(0.0, 1.0);
    final exerciseScore = lifestyle.exercises ? 1.0 : 0.5;
    final historyScore = categories
            .where((c) => c.id == HealthCategoryId.genetic)
            .fold<double>(0, (p, c) => p + c.progress) /
        1;

    final weighted = (testScore * 0.35) +
        (vaccineScore * 0.15) +
        (lifestyleScore * 0.15) +
        (bmiScore * 0.1) +
        (hydrationScore * 0.08) +
        (exerciseScore * 0.07) +
        (historyScore * 0.1);

    return (weighted * 100).round().clamp(0, 100);
  }
}
