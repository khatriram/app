import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'player_pet.dart';
import 'enemy.dart';
import 'fireball.dart';
import 'components/joystick.dart';
import 'services/firebase_service.dart';
import 'package:flutter/material.dart';

class PetBattleGame extends FlameGame
    with HasKeyboardHandlerComponents, HasTappables, HasDraggables {
  late PlayerPet player;
  late Joystick joystick;
  final FirebaseService firebaseService = FirebaseService();

  String? matchId;
  Map<String, dynamic> remotePlayers = {};

  @override
  Future<void> onLoad() async {
    joystick = Joystick();
    add(joystick);

    player = PlayerPet(joystick: joystick);
    add(player);

    add(Enemy());

    if (matchId != null) {
      firebaseService.matchStream(matchId!).listen((doc) {
        if (doc.exists) {
          remotePlayers = doc['positions'] ?? {};
          // Update remote players here...
        }
      });
    }
  }

  void activateSkill(String skill) {
    player.activateSkill(skill);
  }

  Future<void> joinOrCreateMatch(String userId) async {
    if (matchId == null) {
      matchId = await firebaseService.createMatch(userId);
      overlays.remove('lobby');
      overlays.add('skills');
    }
  }
}
