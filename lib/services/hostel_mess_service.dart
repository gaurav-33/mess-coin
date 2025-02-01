import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messcoin/models/hostel_mess_model.dart';
import 'package:messcoin/services/firestore_ref_service.dart';
import '../utils/toast_snack_bar.dart';

class HostelMessService {
  late final FirestoreRefService firestoreRefService;
  HostelMessService() {
    firestoreRefService = FirestoreRefService();
  }

  Future<List<Map<String, String>>> fetchHostel() async {
  try {
    final CollectionReference<HostelMessModel> hostelCollRef =
        firestoreRefService.getCollectionRef(
      basePath: 'hostel_mess',
      fromJson: (data) => HostelMessModel.fromJson(data),
      toJson: (model) => model.toJson(),
    );

    QuerySnapshot<HostelMessModel> snapshot = await hostelCollRef.get();

    List<Map<String, String>> hostelList = snapshot.docs.map((doc) {
      final hostelMess = doc.data();
      return {
        'id': doc.id,
        'name': hostelMess.hostelName!,
      };
    }).toList();

    return hostelList;
  } catch (e) {
    if (e is FirebaseException) {
      AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
    } else {
      AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
    }
    return [];
  }
}

}
