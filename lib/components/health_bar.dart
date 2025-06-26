import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent {
  double maxHealth;
  double currentHealth;

  HealthBar({required this.maxHealth, required this.currentHealth, Vector2? position})
      : super(position: position ?? Vector2.zero(), size: Vector2(60, 6));

  @override
  void render(Canvas canvas) {
    final bgPaint = Paint()..color = Colors.red.shade900;
    final fgPaint = Paint()..color = Colors.greenAccent;

    canvas.drawRect(size.toRect(), bgPaint);

    final healthWidth = size.x * (currentHealth / maxHealth);
    canvas.drawRect(Rect.fromLTWH(0, 0, healthWidth, size.y), fgPaint);
  }

  void updateHealth(double newHealth) {
    currentHealth = newHealth.clamp(0, maxHealth);
  }
}
