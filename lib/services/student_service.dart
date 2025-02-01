import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messcoin/models/user_model.dart';
import 'package:messcoin/services/firestore_ref_service.dart';
import '../utils/toast_snack_bar.dart';

class StudentService {
  late final FirestoreRefService firestoreRefService;

  StudentService() {
    firestoreRefService = FirestoreRefService();
  }

  Future<void> addStudent(StudentModel studentModel) async {
    try {
      final CollectionReference<StudentModel> studentRef =
          firestoreRefService.getCollectionRef<StudentModel>(
              basePath: 'hostel_mess/${studentModel.hostel!.id}/students',
              fromJson: (json) => StudentModel.fromJson(json),
              toJson: (model) => model.toJson());
      await studentRef.doc(studentModel.uid!.toString()).set(studentModel);
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    }
  }

  Future<StudentModel?> fetchStudent(String uid, String hostelId) async {
    try {
      final DocumentSnapshot<StudentModel> studentDoc =
          await firestoreRefService
              .getCollectionRef<StudentModel>(
                  basePath: 'hostel_mess/$hostelId/students',
                  fromJson: (json) => StudentModel.fromJson(json),
                  toJson: (model) => model.toJson())
              .doc(uid)
              .get();

      if (studentDoc.exists) {
        return studentDoc.data();
      } else {
        AppSnackBar.error("Student does not exist for UID: $uid");
      }
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    }
    return null;
  }

  Future<List<CouponTransactionHistory>> fetchCouponTransactionHistory(
      String uid,String hostelId) async {
    try {
      List<String> dateList = getPastNdays(DateTime.now(), 3);
      List<CouponTransactionHistory> couponTransactionList = [];
      for (String date in dateList) {
        final QuerySnapshot<CouponTransactionHistory> couponSnapshot =
            await firestoreRefService
                .getCollectionRef<CouponTransactionHistory>(
                    basePath:
                        'hostel_mess/$hostelId/students/$uid/coupon_transaction_history/doc/$date',
                    fromJson: (json) => CouponTransactionHistory.fromJson(json),
                    toJson: (model) => model.toJson())
                .get();
        if (couponSnapshot.docs.isNotEmpty) {
          for (var doc in couponSnapshot.docs) {
            couponTransactionList.add(doc.data());
          }
        }
      }
      return couponTransactionList;
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
      return [];
    }
  }

  List<String> getPastNdays(DateTime startDate, int n) {
    return List.generate(n, (index) {
      DateTime pastDates = startDate.subtract(Duration(days: index));
      return "${pastDates.toLocal()}".split(' ')[0];
    });
  }
}
