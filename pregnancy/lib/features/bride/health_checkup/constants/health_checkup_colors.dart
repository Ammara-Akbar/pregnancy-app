import 'package:flutter/material.dart';

/// Soft-pink premium palette for Bride Pre-Marriage Health Checkup.
abstract final class HealthCheckupColors {
  static const softPink = Color(0xFFF96C8C);
  static const softPinkLight = Color(0xFFFFE4EC);
  static const softPinkDark = Color(0xFFE84A72);
  static const blush = Color(0xFFFFF5F7);
  static const white = Color(0xFFFFFFFF);
  static const navy = Color(0xFF1A1C3D);
  static const muted = Color(0xFF8A8490);
  static const green = Color(0xFF4CAF7A);
  static const greenSoft = Color(0xFFE8F5E9);
  static const yellow = Color(0xFFF5A623);
  static const yellowSoft = Color(0xFFFFF4D6);
  static const red = Color(0xFFE53935);
  static const redSoft = Color(0xFFFFEBEE);
  static const lavender = Color(0xFF9C7BC7);
  static const peach = Color(0xFFFF9B7A);

  static LinearGradient get cardGradient => const LinearGradient(
        colors: [Color(0xFFFFF8FA), Color(0xFFFFE8EF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get pinkGradient => const LinearGradient(
        colors: [Color(0xFFFF9BB0), softPink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: softPink.withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}
