import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  static const Map<String, String> _nameCollectionMapping = {
    'admin': 'admin',
    'doctor': 'doctors',
    'patient': 'patients',
  };

  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument({
    required String userId,
    required String userType,
  }) async {
    final collectionName = _nameCollectionMapping[userType];
    if (collectionName == null) {
      throw Exception('Invalid userType provided');
    }

    return await _firestore.collection(collectionName).doc(userId).get();
  }

  DocumentReference<Map<String, dynamic>> getUserDocumentReference({
    required String userId,
    required String userType,
  }) {
    final collectionName = _nameCollectionMapping[userType];
    if (collectionName == null) {
      throw Exception('Invalid userType provided');
    }

    return _firestore.collection(collectionName).doc(userId);
  }

}
