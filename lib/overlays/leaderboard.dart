import 'package:flutter/material.dart';

class LeaderboardOverlay extends StatelessWidget {
  const LeaderboardOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder: Replace with Firestore leaderboard fetch & list
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.black54,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Leaderboard', style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 10),
            Text('1. Player1 - 1000', style: TextStyle(color: Colors.white)),
            Text('2. Player2 - 800', style: TextStyle(color: Colors.white)),
            Text('3. Player3 - 600', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
