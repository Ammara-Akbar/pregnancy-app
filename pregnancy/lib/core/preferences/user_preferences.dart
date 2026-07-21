import 'package:flutter/foundation.dart';

/// Content & cultural preference for global users.
enum ContentRegion { desi, international }

extension ContentRegionX on ContentRegion {
  String get label => switch (this) {
    ContentRegion.desi => 'Desi / South Asian',
    ContentRegion.international => 'International',
  };

  String get shortLabel => switch (this) {
    ContentRegion.desi => 'Desi',
    ContentRegion.international => 'International',
  };

  String get description => switch (this) {
    ContentRegion.desi =>
      'Meals, tips & guidance tailored for South Asian lifestyles.',
    ContentRegion.international =>
      'Meals, tips & guidance tailored for global lifestyles.',
  };

  String get currencyCode => switch (this) {
    ContentRegion.desi => 'PKR',
    ContentRegion.international => 'USD',
  };

  /// Converts a PKR monthly amount label into the display currency.
  String formatMoney(String pkrAmountLabel) {
    if (pkrAmountLabel == '0') return 'Free';
    final pkr = int.tryParse(pkrAmountLabel) ?? 0;
    if (this == ContentRegion.desi) {
      return 'PKR $pkrAmountLabel';
    }
    // Approx display conversion for UI mock pricing.
    final usd = (pkr / 280).round().clamp(1, 9999);
    return '\$$usd';
  }
}

class UserPreferences extends ChangeNotifier {
  UserPreferences._();
  static final UserPreferences instance = UserPreferences._();

  ContentRegion _region = ContentRegion.desi;
  int _weeksPregnant = 12;
  DateTime? _dueDate;
  DateTime? _lastPeriodDate;

  ContentRegion get region => _region;

  bool get isDesi => _region == ContentRegion.desi;

  int get weeksPregnant => _weeksPregnant;

  DateTime get dueDate {
    if (_dueDate != null) return _dueDate!;
    final remaining = (40 - _weeksPregnant).clamp(0, 40);
    return DateTime.now().add(Duration(days: remaining * 7));
  }

  DateTime? get lastPeriodDate => _lastPeriodDate;

  void setRegion(ContentRegion region) {
    if (_region == region) return;
    _region = region;
    notifyListeners();
  }

  /// Seeds pregnancy week from onboarding without clearing other fields.
  void ensureWeeksPregnant(int weeks) {
    final clamped = weeks.clamp(1, 42);
    if (_weeksPregnant == clamped && _dueDate != null) return;
    _weeksPregnant = clamped;
    _dueDate ??= DateTime.now().add(
      Duration(days: (40 - clamped).clamp(0, 40) * 7),
    );
    notifyListeners();
  }

  void setWeeksPregnant(int weeks) {
    final clamped = weeks.clamp(1, 42);
    final remaining = (40 - clamped).clamp(0, 40);
    _weeksPregnant = clamped;
    _dueDate = DateTime.now().add(Duration(days: remaining * 7));
    _lastPeriodDate = _dueDate!.subtract(const Duration(days: 280));
    notifyListeners();
  }

  void setDueDate(DateTime date) {
    final today = DateTime.now();
    final clean = DateTime(date.year, date.month, date.day);
    final daysLeft = clean
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
    final weeksLeft = (daysLeft / 7).round().clamp(0, 40);
    _dueDate = clean;
    _weeksPregnant = (40 - weeksLeft).clamp(1, 42);
    _lastPeriodDate = clean.subtract(const Duration(days: 280));
    notifyListeners();
  }

  void setLastPeriodDate(DateTime date) {
    final clean = DateTime(date.year, date.month, date.day);
    final today = DateTime.now();
    final days = DateTime(
      today.year,
      today.month,
      today.day,
    ).difference(clean).inDays;
    _lastPeriodDate = clean;
    _dueDate = clean.add(const Duration(days: 280));
    _weeksPregnant = (days / 7).floor().clamp(1, 42);
    notifyListeners();
  }
}
