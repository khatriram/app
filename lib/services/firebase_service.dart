import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> createMatch(String userId) async {
    final doc = await firestore.collection('matches').add({
      'players': [userId],
      'createdAt': FieldValue.serverTimestamp(),
      'state': 'waiting',
      'positions': {
        userId: {'x': 0, 'y': 0}
      },
    });
    return doc.id;
  }

  Future<bool> joinMatch(String matchId, String userId) async {
    final docRef = firestore.collection('matches').doc(matchId);
    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data()!;
      List players = data['players'] ?? [];
      if (players.length < 2) {
        players.add(userId);
        await docRef.update({'players': players, 'state': 'active'});
        return true;
      }
    }
    return false;
  }

  Stream<DocumentSnapshot> matchStream(String matchId) {
    return firestore.collection('matches').doc(matchId).snapshots();
  }

  Future<void> updatePlayerPosition(String matchId, String userId, Map<String, dynamic> pos) {
    return firestore.collection('matches').doc(matchId).update({
      'positions.$userId': pos,
    });
  }
}
