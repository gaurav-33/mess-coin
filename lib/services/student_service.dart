import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/firestore_ref_service.dart';
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

  Future<void> addRechargeTransaction(
      String hostelId,
      String uid,
      int currentBal,
      int leftCredit,
      int rechargeAmount,
      DateTime transactionTime,
      TopupHistory topupHistory) async {
    try {
      CollectionReference<StudentModel> studentModelRef =
          firestoreRefService.getCollectionRef<StudentModel>(
              basePath: "hostel_mess/$hostelId/students",
              fromJson: (json) => StudentModel.fromJson(json),
              toJson: (model) => model.toJson());

      await studentModelRef.doc(uid).update({
        'current_bal': currentBal + rechargeAmount,
        'left_credit': leftCredit - rechargeAmount,
        'updated_at': transactionTime.toIso8601String(),
        'topup_history': FieldValue.arrayUnion([topupHistory.toJson()]),
      });
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
  }

  Future<void> addCouponTransaction(
      String hostelId,
      String uid,
      int paymentAmount,
      DateTime transactionTime,
      int prevAmount,
      CouponTransactionHistory couponTransactionHistory) async {
    try {
      CollectionReference<CouponTransactionHistory>
          couponTransactionHistoryRef =
          firestoreRefService.getCollectionRef<CouponTransactionHistory>(
              basePath:
                  "hostel_mess/$hostelId/students/$uid/coupon_transaction_history/doc/${DateTime.now().toIso8601String().split('T')[0]}",
              fromJson: (json) => CouponTransactionHistory.fromJson(json),
              toJson: (model) => model.toJson());

      await couponTransactionHistoryRef
          .doc(couponTransactionHistory.transactionId)
          .set(couponTransactionHistory);

      CollectionReference<StudentModel> studentModelRef =
          firestoreRefService.getCollectionRef<StudentModel>(
              basePath: "hostel_mess/$hostelId/students",
              fromJson: (json) => StudentModel.fromJson(json),
              toJson: (model) => model.toJson());
      int currAmount = prevAmount - paymentAmount;

      await studentModelRef.doc(uid).update({
        'current_bal': currAmount,
        'updated_at': transactionTime.toIso8601String(),
      });
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
  }

  Future<List<CouponTransactionHistory>> fetchCouponTransactionHistory(
      String uid, String hostelId) async {
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
