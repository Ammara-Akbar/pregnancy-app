import 'package:flutter/material.dart';

enum HealthItemStatus { completed, pending, optional }

enum HealthSeverity { normal, caution, critical }

enum HealthCategoryId {
  essential,
  genetic,
  infectious,
  womens,
  vaccinations,
  partner,
}

class HealthTestItem {
  const HealthTestItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.expandable = false,
    this.aiNote,
    this.severity,
    this.reminder,
  });

  final String id;
  final String title;
  final String description;
  final HealthItemStatus status;
  final bool expandable;
  final String? aiNote;
  final String? severity;
  final String? reminder;

  HealthTestItem copyWith({HealthItemStatus? status, String? reminder}) {
    return HealthTestItem(
      id: id,
      title: title,
      description: description,
      status: status ?? this.status,
      expandable: expandable,
      aiNote: aiNote,
      severity: severity,
      reminder: reminder ?? this.reminder,
    );
  }
}

class HealthCategory {
  const HealthCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
    required this.items,
    this.optional = false,
  });

  final HealthCategoryId id;
  final String title;
  final String description;
  final IconData icon;
  final Color accent;
  final List<HealthTestItem> items;
  final bool optional;

  int get completedCount =>
      items.where((i) => i.status == HealthItemStatus.completed).length;

  int get totalCount => items.length;

  double get progress => totalCount == 0 ? 0 : completedCount / totalCount;

  String get statusLabel {
    if (completedCount == totalCount) return 'Completed';
    if (completedCount == 0) return 'Not started';
    return 'In progress';
  }
}

class LifestyleAnswers {
  const LifestyleAnswers({
    this.smokes = false,
    this.alcohol = false,
    this.exercises = true,
    this.sleepHours = 7,
    this.waterGlasses = 6,
    this.stressLevel = 2,
    this.bmi = 22.5,
  });

  final bool smokes;
  final bool alcohol;
  final bool exercises;
  final int sleepHours;
  final int waterGlasses;
  final int stressLevel;
  final double bmi;

  LifestyleAnswers copyWith({
    bool? smokes,
    bool? alcohol,
    bool? exercises,
    int? sleepHours,
    int? waterGlasses,
    int? stressLevel,
    double? bmi,
  }) {
    return LifestyleAnswers(
      smokes: smokes ?? this.smokes,
      alcohol: alcohol ?? this.alcohol,
      exercises: exercises ?? this.exercises,
      sleepHours: sleepHours ?? this.sleepHours,
      waterGlasses: waterGlasses ?? this.waterGlasses,
      stressLevel: stressLevel ?? this.stressLevel,
      bmi: bmi ?? this.bmi,
    );
  }

  int get score {
    var s = 70;
    if (!smokes) s += 8;
    if (!alcohol) s += 6;
    if (exercises) s += 8;
    if (sleepHours >= 7 && sleepHours <= 9) s += 5;
    if (waterGlasses >= 8) s += 5;
    if (stressLevel <= 2) s += 4;
    if (bmi >= 18.5 && bmi <= 24.9) s += 6;
    return s.clamp(0, 100);
  }
}

class UploadedReport {
  const UploadedReport({
    required this.id,
    required this.name,
    required this.dateLabel,
    required this.source,
  });

  final String id;
  final String name;
  final String dateLabel;
  final String source;
}

class AiFinding {
  const AiFinding({
    required this.title,
    required this.status,
    required this.severity,
    required this.recommendation,
  });

  final String title;
  final String status;
  final HealthSeverity severity;
  final String recommendation;
}

class DoctorProfile {
  const DoctorProfile({
    required this.id,
    required this.name,
    required this.specialty,
    required this.distance,
    required this.rating,
    this.saved = false,
  });

  final String id;
  final String name;
  final String specialty;
  final String distance;
  final double rating;
  final bool saved;

  DoctorProfile copyWith({bool? saved}) {
    return DoctorProfile(
      id: id,
      name: name,
      specialty: specialty,
      distance: distance,
      rating: rating,
      saved: saved ?? this.saved,
    );
  }
}
