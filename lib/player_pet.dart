import 'package:flame/components.dart';
import 'components/joystick.dart';
import 'fireball.dart';
import 'pet_battle_game.dart'; // Import your game class

class PlayerPet extends SpriteComponent with HasGameReference<PetBattleGame> {
  final Joystick joystick;
  double speed = 120;
  bool isShielded = false;
  FlameLottieComponent? shieldEffect;

  PlayerPet({required this.joystick}) : super(size: Vector2.all(64));
  
  Null get gameRef => null;

  // REMOVE this: Null get gameRef => null;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('pets/cute_dog.png');
    position = Vector2(200, 200);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += joystick.delta * speed * dt;
  }

  void activateSkill(String skill) {
    switch (skill) {
      case 'fireball':
        spawnFireball();
        break;
      case 'dash':
        dash();
        break;
      case 'shield':
        shield();
        break;
    }
  }

  void spawnFireball() {
    final fireball = Fireball(position + Vector2(32, 0));
    gameRef.add(fireball);
  }

  void dash() {
    final direction = joystick.delta.normalized();
    position += direction * 150;
  }

  Future<void> shield() async {
    if (shieldEffect != null) return;

    isShielded = true;

    shieldEffect = await FlameLottieComponent.fromAsset(
      'lottie/shield_fx.json',
      size: Vector2(80, 80),
      repeat: true,
    );

    shieldEffect!.position = Vector2(size.x / 2, size.y / 2);
    shieldEffect!.anchor = Anchor.center;
    add(shieldEffect! as Component);

    await Future.delayed(const Duration(seconds: 3));

    isShielded = false;
    shieldEffect?.removeFromParent();
    shieldEffect = null;
  }
}

class FlameLottieComponent {
  set anchor(Anchor anchor) {}

  set position(Vector2 position) {}

  // ignore: body_might_complete_normally_nullable
  static Future<FlameLottieComponent?> fromAsset(String s, {required Vector2 size, required bool repeat}) async {}
  
  void removeFromParent() {}
}
