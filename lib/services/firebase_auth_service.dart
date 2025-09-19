import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static Future<void> signIn({
    required String email,
    required String password,
  }) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email, password: password,
    );
    final uid = cred.user!.uid;

    await _db.collection('users').doc(uid).set({
      'displayName': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await cred.user!.updateDisplayName(name);
  }

  static Future<void> resetPassword({required String email}) =>
      _auth.sendPasswordResetEmail(email: email);

  static Future<void> signOut() => _auth.signOut();

  static User? get currentUser => _auth.currentUser;
}
