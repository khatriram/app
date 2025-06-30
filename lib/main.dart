import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Generated via flutterfire CLI
import 'pet_battle_game.dart';
import 'overlays/skill_buttons.dart';
import 'overlays/lobby.dart';
import 'overlays/leaderboard.dart';
import 'package:flame/game.dart'; // For GameWidget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Battle Royale',
      debugShowCheckedModeBanner: false,
      home: GameWidget<PetBattleGame>(
        game: PetBattleGame(),
        overlayBuilderMap: {
          'skills': (context, game) => SkillButtons(
            onSkillTap: (skill) => game.activateSkill(skill),
          ),
          'lobby': (context, game) => LobbyOverlay(game),
          'leaderboard': (context, game) => const LeaderboardOverlay(),
        },
        initialActiveOverlays: const ['lobby'],
      ),
    );
  }
}
