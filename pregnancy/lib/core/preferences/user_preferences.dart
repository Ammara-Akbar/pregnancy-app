import 'package:flutter/foundation.dart';

/// Content & cultural preference for global users.
enum ContentRegion {
  desi,
  international,
}

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

  ContentRegion get region => _region;

  bool get isDesi => _region == ContentRegion.desi;

  void setRegion(ContentRegion region) {
    if (_region == region) return;
    _region = region;
    notifyListeners();
  }
}
