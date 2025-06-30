import 'package:flame/components.dart';
import 'components/health_bar.dart';
import 'player_pet.dart'; // Make sure this file defines the PlayerPet class

// ignore: deprecated_member_use
class Enemy extends SpriteComponent with HasGameRef {
  Vector2 velocity = Vector2.zero();
  double speed = 90;
  double maxHealth = 100;
  double currentHealth = 100;
  late HealthBar healthBar;

  Enemy() : super(size: Vector2.all(64));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('pets/enemy.png');
    position = Vector2(300, 300);
    healthBar = HealthBar(
      maxHealth: maxHealth,
      currentHealth: currentHealth,
      position: Vector2(0, -10),
    );
    add(healthBar);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final player = gameRef.children.whereType<PlayerPet>().firstOrNull;
    if (player != null) {
      final direction = (player.position - position).normalized();
      velocity = direction * speed;
      position += velocity * dt;
    }
  }

  void takeDamage(double damage) {
    currentHealth -= damage;
    healthBar.updateHealth(currentHealth);
    if (currentHealth <= 0) {
      removeFromParent();
    }
  }
}
