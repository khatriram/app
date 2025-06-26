import 'package:flame/components.dart';

class Fireball extends SpriteComponent with HasGameRef {
  Vector2 velocity = Vector2(350, 0);

  Fireball(Vector2 startPosition)
      : super(
          size: Vector2.all(48),
          position: startPosition,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('pets/fireball.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.x > gameRef.size.x) {
      removeFromParent();
    }
  }
}
