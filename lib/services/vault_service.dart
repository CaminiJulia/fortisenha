import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VaultService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static String get _uid {
    final u = _auth.currentUser;
    if (u == null) throw StateError('Usuário não autenticado');
    return u.uid;
  }

  static CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('users').doc(_uid).collection('vault');

  static Future<String> addItem({
    required String title,
    required String username,
    required String url,
    required String note,
    required String secretPlaintext, // TEMP: sem criptografia
  }) async {
    final doc = await _col.add({
      'title': title,
      'username': username,
      'url': url,
      'note': note,
      'ciphertext': secretPlaintext,
      'nonce': '',
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  static Stream<List<Map<String, dynamic>>> watchItems() {
    return _col.orderBy('updatedAt', descending: true).snapshots().map(
      (q) => q.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
    );
  }

  static Future<void> updateItem(String id, Map<String, dynamic> data) =>
      _col.doc(id).update(data);

  static Future<void> deleteItem(String id) =>
      _col.doc(id).delete();
}
