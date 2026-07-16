/// Maps pregnancy week → fruit comparison used across pregnant screens.
class PregnantBabySize {
  const PregnantBabySize({
    required this.fruitName,
    required this.sizeLabel,
    required this.imageAsset,
    required this.blurb,
  });

  final String fruitName;
  final String sizeLabel;
  final String imageAsset;
  final String blurb;

  static PregnantBabySize forWeek(int weeks) {
    final w = weeks.clamp(1, 42);
    if (w <= 8) {
      return const PregnantBabySize(
        fruitName: 'Raspberry',
        sizeLabel: '1.6 cm',
        imageAsset: 'assets/images/baby_size_raspberry.png',
        blurb:
            'Your baby is about the size of a raspberry. Early organs and facial features are forming.',
      );
    }
    if (w <= 12) {
      return const PregnantBabySize(
        fruitName: 'Plum',
        sizeLabel: '5.4 cm',
        imageAsset: 'assets/images/baby_size_plum.png',
        blurb:
            'Your baby is about the size of a plum. Limbs and fingers are developing.',
      );
    }
    if (w <= 16) {
      return const PregnantBabySize(
        fruitName: 'Avocado',
        sizeLabel: '11.6 cm',
        imageAsset: 'assets/images/baby_size_avocado.png',
        blurb:
            'Your baby is about the size of an avocado. Muscles and bones are getting stronger.',
      );
    }
    if (w <= 20) {
      return const PregnantBabySize(
        fruitName: 'Banana',
        sizeLabel: '25.6 cm',
        imageAsset: 'assets/images/baby_size_banana.png',
        blurb:
            'Your baby is about the size of a banana. You may start feeling flutters soon.',
      );
    }
    if (w <= 24) {
      return const PregnantBabySize(
        fruitName: 'Corn',
        sizeLabel: '30 cm',
        imageAsset: 'assets/images/baby_size_corn.png',
        blurb:
            'Your baby is about the size of an ear of corn. Hearing and balance are maturing.',
      );
    }
    if (w <= 28) {
      return const PregnantBabySize(
        fruitName: 'Eggplant',
        sizeLabel: '37.6 cm',
        imageAsset: 'assets/images/baby_size_eggplant.png',
        blurb:
            'Your baby is about the size of an eggplant. Eyes can open and movements feel stronger.',
      );
    }
    if (w <= 32) {
      return const PregnantBabySize(
        fruitName: 'Coconut',
        sizeLabel: '42.4 cm',
        imageAsset: 'assets/images/baby_size_coconut.png',
        blurb:
            'Your baby is about the size of a coconut. Fat stores and brain growth are accelerating.',
      );
    }
    if (w <= 36) {
      return const PregnantBabySize(
        fruitName: 'Romaine lettuce',
        sizeLabel: '47.4 cm',
        imageAsset: 'assets/images/baby_size_romaine.png',
        blurb:
            'Your baby is about the size of a head of romaine. Lungs and immune system keep maturing.',
      );
    }
    return const PregnantBabySize(
      fruitName: 'Watermelon',
      sizeLabel: '51 cm',
      imageAsset: 'assets/images/baby_size_watermelon.png',
      blurb:
          'Your baby is about the size of a watermelon. Getting ready for birth with final weight gain.',
    );
  }

  /// Soft fetus illustration for the progress card by trimester band.
  static String fetusAssetForWeek(int weeks) {
    final w = weeks.clamp(1, 42);
    if (w <= 13) return 'assets/images/fetus_week12.png';
    return 'assets/images/fetus_week20.png';
  }
}
