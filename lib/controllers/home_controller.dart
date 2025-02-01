import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:messcoin/models/extra_meal_model.dart';
import 'package:messcoin/models/mess_menu_model.dart';
import 'package:messcoin/models/mess_topup_history_model.dart';
import 'package:messcoin/models/user_model.dart';
import 'package:messcoin/services/firestore_ref_service.dart';
import 'package:messcoin/services/menu_services.dart';
import 'package:messcoin/services/student_service.dart';
import 'package:messcoin/utils/toast_snack_bar.dart';

import '../routes/app_routes.dart';

class HomeController extends GetxController {
  Rx<StudentModel?> studentModel = Rx<StudentModel?>(null);
  Rx<ExtraMealModel?> extraMealModel = Rx<ExtraMealModel?>(null);
  RxMap<String, MessMenuModel?> messMenuModel = RxMap<String, MessMenuModel?>();
  RxList<CouponTransactionHistory> couponTransactionHistoryList =
      RxList<CouponTransactionHistory>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  RxBool isLoading = false.obs;

  late final String hostelId;

  FirestoreRefService firestoreRefService = FirestoreRefService();

  @override
  void onReady() async {
    super.onReady();
    final args = Get.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      AppSnackBar.error("Invalid arguments. Redirecting...");
      Get.offAllNamed(AppRoutes.getSelectHostelRoute());
      return;
    }
    hostelId = args['hostel_id'];

    await fetchStudentData(); 

    if (studentModel.value == null) {
      Get.offAllNamed(
          AppRoutes.getSelectHostelRoute()); 
      return;
    }

    fetchExtraMealData();
    fetchMessMenuData();
  }

  Future<void> fetchStudentData() async {
    try {
      final fetchedStudent = await StudentService().fetchStudent(uid, hostelId);
      if (fetchedStudent != null) {
        studentModel.value = fetchedStudent;
      } else {
        AppSnackBar.error("User Data Not Found.");
        return;
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  void fetchExtraMealData() async {
    try {
      final fetchedExtraMeal = await MenuServices().fetchExtraMeal(hostelId);

      if (fetchedExtraMeal != null) {
        extraMealModel.value = fetchedExtraMeal;
      } else {
        AppSnackBar.error("Extra Meal Not Found.");
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> performRecharge(
      String amount, String transactionId, DateTime transactionTime) async {
    try {
      isLoading.value = true;
      int rechargeAmount = int.tryParse(amount) ?? 0;
      CollectionReference<StudentModel> studentModelRef =
          firestoreRefService.getCollectionRef<StudentModel>(
              basePath: "hostel_mess/$hostelId/students",
              fromJson: (json) => StudentModel.fromJson(json),
              toJson: (model) => model.toJson());
      int prevAmount = studentModel.value?.currentBal ?? 0;
      int leftCredit = studentModel.value?.leftCredit ?? 0;

      TopupHistory topupHistory = TopupHistory(
          transactionId: transactionId,
          amount: rechargeAmount,
          transactionTime: transactionTime);

      await studentModelRef.doc(uid).update({
        'current_bal': prevAmount + rechargeAmount,
        'left_credit': leftCredit - rechargeAmount,
        'updated_at': transactionTime.toIso8601String(),
        'topup_history': FieldValue.arrayUnion([topupHistory.toJson()]),
      });

      CollectionReference<MessTopupHistoryModel> messTopupModelRef =
          firestoreRefService.getCollectionRef<MessTopupHistoryModel>(
              basePath:
                  'hostel_mess/$hostelId/topup_history/doc/${DateTime.now().toIso8601String().split('T')[0]}',
              fromJson: (json) => MessTopupHistoryModel.fromJson(json),
              toJson: (model) => model.toJson());

      MessTopupHistoryModel messTopupHistoryModel = MessTopupHistoryModel(
          name: "${studentModel.value?.name}",
          roll: "${studentModel.value?.rollNo}",
          amount: rechargeAmount,
          transactionId: transactionId,
          transactionTime: transactionTime.toIso8601String());

      await messTopupModelRef.doc(transactionId).set(messTopupHistoryModel);

      studentModel.value = studentModel.value?.copyWith(
        currentBal: prevAmount + rechargeAmount,
        leftCredit: leftCredit - rechargeAmount,
        topupHistory: [
          ...(studentModel.value?.topupHistory ?? []),
          topupHistory
        ],
      );
      AppSnackBar.success("Recharge successful!");
      isLoading.value = false;
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error("Failed to recharge: ${e.message}",
            errorCode: e.code);
      } else {
        AppSnackBar.error("An error occurred: ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> performPayment(
      String amount, String transactionId, DateTime transactionTime) async {
    try {
      isLoading.value = true;
      int paymentAmount = int.tryParse(amount) ?? 0;

      CollectionReference<CouponTransactionHistory>
          couponTransactionHistoryRef =
          firestoreRefService.getCollectionRef<CouponTransactionHistory>(
              basePath:
                  "hostel_mess/$hostelId/students/$uid/coupon_transaction_history/doc/${DateTime.now().toIso8601String().split('T')[0]}",
              fromJson: (json) => CouponTransactionHistory.fromJson(json),
              toJson: (model) => model.toJson());

      CouponTransactionHistory couponTransactionHistory =
          CouponTransactionHistory(
              transactionId: transactionId,
              amount: paymentAmount,
              transactionTime: transactionTime,
              status: "completed");

      await couponTransactionHistoryRef
          .doc(transactionId)
          .set(couponTransactionHistory);

      CollectionReference<StudentModel> studentModelRef =
          firestoreRefService.getCollectionRef<StudentModel>(
              basePath: "hostel_mess/$hostelId/students",
              fromJson: (json) => StudentModel.fromJson(json),
              toJson: (model) => model.toJson());
      int prevAmount = studentModel.value?.currentBal ?? 0;
      int currAmount = prevAmount - paymentAmount;

      await studentModelRef.doc(uid).update({
        'current_bal': currAmount,
        'updated_at': transactionTime.toIso8601String(),
      });

      studentModel.value = studentModel.value?.copyWith(
        currentBal: currAmount,
      );

      MessTopupHistoryModel messTopupHistoryModel = MessTopupHistoryModel(
          name: "${studentModel.value?.name}",
          roll: "${studentModel.value?.rollNo}",
          amount: paymentAmount,
          transactionId: transactionId,
          transactionTime: transactionTime.toIso8601String());

      CollectionReference<MessTopupHistoryModel> messTopupModelRef =
          firestoreRefService.getCollectionRef<MessTopupHistoryModel>(
              basePath:
                  'hostel_mess/$hostelId/coupon_history/doc/${DateTime.now().toIso8601String().split('T')[0]}',
              fromJson: (json) => MessTopupHistoryModel.fromJson(json),
              toJson: (model) => model.toJson());

      await messTopupModelRef.doc(transactionId).set(messTopupHistoryModel);
      couponTransactionHistoryList.insert(0, couponTransactionHistory);
      AppSnackBar.success("Payment Successful.");
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error("Failed to recharge: ${e.message}",
            errorCode: e.code);
      } else {
        AppSnackBar.error("An error occurred: ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void fetchMessMenuData() async {
    try {
      List days = [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ];
      for (String day in days) {
        final fetchMessMenuData =
            await MenuServices().fetchMenuMeal(hostelId, day);
        if (fetchMessMenuData != null) {
          messMenuModel.value[day] = fetchMessMenuData;
        } else {
          AppSnackBar.error("Mess Menu Not Found.");
        }
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  void fetchCoupnTransactionList() async {
    try {
      couponTransactionHistoryList.value =
          await StudentService().fetchCouponTransactionHistory(uid, hostelId);
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }
}
