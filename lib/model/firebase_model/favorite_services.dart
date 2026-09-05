import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get userId {
    return _auth.currentUser!.uid;
  }

  static Future<void> addFavorite(int movieId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .set({'movieId': movieId, 'addedAt': FieldValue.serverTimestamp()});
  }

  static Future<void> removeFavorite(int movieId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .delete();
  }

  static Future<bool> isFavorite(int movieId) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .get();

    return doc.exists;
  }

  static Future<List<int>> getFavorites() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .orderBy('addedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return doc['movieId'] as int;
    }).toList();
  }
}
