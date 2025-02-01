import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRefService {
  late final FirebaseFirestore firebaseFirestore;
  FirestoreRefService() {
    firebaseFirestore = FirebaseFirestore.instance;
  }

  CollectionReference<T> getCollectionRef<T>(
      {required String basePath,
      required T Function(Map<String, dynamic>) fromJson,
      required Map<String, dynamic> Function(T) toJson}) {
    return firebaseFirestore.collection(basePath).withConverter(
          fromFirestore: (snapshots, _) => fromJson(snapshots.data()!),
          toFirestore: (data, _) => toJson(data),
        );
  }
}
