import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/hostel_mess_model.dart';
import '../services/firestore_ref_service.dart';
import '../models/mess_topup_history_model.dart';
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

  Future<void> addTransaction(
      {required bool isTopUp,
      required String hostelId,
      required String name,
      required String rollNo,
      required int rechargeAmount,
      required String transactionId,
      required String transactionTime}) async {
    try {
      String path = isTopUp ? "topup_history" : "coupon_history";
      CollectionReference<MessTopupHistoryModel> messTopupModelRef =
          firestoreRefService.getCollectionRef<MessTopupHistoryModel>(
              basePath:
                  'hostel_mess/$hostelId/$path/doc/${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
              fromJson: (json) => MessTopupHistoryModel.fromJson(json),
              toJson: (model) => model.toJson());

      MessTopupHistoryModel messTopupHistoryModel = MessTopupHistoryModel(
          name: name,
          roll: rollNo,
          amount: rechargeAmount,
          transactionId: transactionId,
          transactionTime: transactionTime);

      await messTopupModelRef.doc(transactionId).set(messTopupHistoryModel);
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
  }
}
