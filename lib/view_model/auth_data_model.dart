import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/firebase_model/user_model.dart';

class AuthModel{
  static Future<void> getUserData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) return;

    final doc = await FirebaseFirestore.instance
        .collection(Users.collectionName)
        .doc(firebaseUser.uid)
        .get();

    if (!doc.exists) return;

    final user = Users.fromFirebaseStore(doc.data()!);

    print(user.name);
    print(user.email);
    print(user.phone);
    print(user.image);
  }
}
