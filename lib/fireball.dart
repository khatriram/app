import 'package:flame/components.dart';
import 'pet_battle_game.dart'; // Update this path if your file is in a different location
class Fireball extends SpriteComponent with HasGameReference<PetBattleGame> {
  final Vector2 velocity = Vector2(350, 0);

  Fireball(Vector2 startPosition)
      : super(
    size: Vector2.all(48),
    position: startPosition,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await game.loadSprite('pets/fireball.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.x - size.x / 2 > game.size.x) {
      removeFromParent();
    }
  }
}
