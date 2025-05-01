import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreService {
  static const Map<String, String> nameCollectionMapping = {
    'admin': 'admin',
    'doctor': 'doctors',
    'patient': 'patients',
  };

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument({
    required String userId,
    required String userType,
  }) async {
    final collectionName = nameCollectionMapping[userType];
    if (collectionName == null) {
      throw Exception('Invalid userType provided');
    }

    return await _firestore.collection(collectionName).doc(userId).get();
  }
}
