import 'package:flutter/foundation.dart';

import '../models/health_checkup_models.dart';
import '../repositories/health_checkup_repository.dart';
import '../services/readiness_score_service.dart';

class HealthCheckupProvider extends ChangeNotifier {
  HealthCheckupProvider({
    HealthCheckupRepository? repository,
    ReadinessScoreService? scoreService,
  })  : _repository = repository ?? HealthCheckupRepository(),
        _scoreService = scoreService ?? const ReadinessScoreService() {
    _categories = _repository.seedCategories();
    _uploads = List.of(_repository.seedUploads());
    _findings = _repository.seedAiFindings();
    _doctors = _repository.seedDoctors();
  }

  final HealthCheckupRepository _repository;
  final ReadinessScoreService _scoreService;

  late List<HealthCategory> _categories;
  late List<UploadedReport> _uploads;
  late List<AiFinding> _findings;
  late List<DoctorProfile> _doctors;
  LifestyleAnswers _lifestyle = const LifestyleAnswers();
  bool _loading = false;

  List<HealthCategory> get categories => _categories;
  List<UploadedReport> get uploads => _uploads;
  List<AiFinding> get findings => _findings;
  List<DoctorProfile> get doctors => _doctors;
  LifestyleAnswers get lifestyle => _lifestyle;
  bool get loading => _loading;

  int get completedTests {
    var n = 0;
    for (final c in _categories) {
      if (c.optional) continue;
      n += c.completedCount;
    }
    return n;
  }

  int get totalTests {
    var n = 0;
    for (final c in _categories) {
      if (c.optional) continue;
      n += c.totalCount;
    }
    return n;
  }

  double get testProgress =>
      totalTests == 0 ? 0 : completedTests / totalTests;

  int get readinessPercent => _scoreService.calculate(
        categories: _categories,
        lifestyle: _lifestyle,
      );

  String get readinessLabel {
    final p = readinessPercent;
    if (p >= 85) return 'Excellent';
    if (p >= 70) return 'Good';
    return 'Needs Improvement';
  }

  HealthCategory categoryById(HealthCategoryId id) =>
      _categories.firstWhere((c) => c.id == id);

  Future<void> simulateLoad() async {
    _loading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 650));
    _loading = false;
    notifyListeners();
  }

  void toggleItem(HealthCategoryId categoryId, String itemId) {
    final ci = _categories.indexWhere((c) => c.id == categoryId);
    if (ci < 0) return;
    final cat = _categories[ci];
    final items = List<HealthTestItem>.from(cat.items);
    final ii = items.indexWhere((i) => i.id == itemId);
    if (ii < 0) return;
    final item = items[ii];
    final next = item.status == HealthItemStatus.completed
        ? HealthItemStatus.pending
        : HealthItemStatus.completed;
    items[ii] = item.copyWith(status: next);
    _categories[ci] = HealthCategory(
      id: cat.id,
      title: cat.title,
      description: cat.description,
      icon: cat.icon,
      accent: cat.accent,
      items: items,
      optional: cat.optional,
    );
    notifyListeners();
  }

  void addUpload(String name, String source) {
    _uploads.insert(
      0,
      UploadedReport(
        id: 'u${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        dateLabel: 'Just now',
        source: source,
      ),
    );
    notifyListeners();
  }

  void updateLifestyle(LifestyleAnswers answers) {
    _lifestyle = answers;
    notifyListeners();
  }

  void toggleSaveDoctor(String id) {
    final i = _doctors.indexWhere((d) => d.id == id);
    if (i < 0) return;
    _doctors[i] = _doctors[i].copyWith(saved: !_doctors[i].saved);
    notifyListeners();
  }
}
