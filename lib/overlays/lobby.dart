import 'package:flutter/material.dart';
import '../pet_battle_game.dart';

class LobbyOverlay extends StatelessWidget {
  final PetBattleGame game;
  const LobbyOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: ElevatedButton(
          child: const Text('Join/Create Match'),
          onPressed: () async {
            // For demo, use a fixed userId or FirebaseAuth userId
            await game.joinOrCreateMatch('user123');
          },
        ),
      ),
    );
  }
}
