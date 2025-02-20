import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:messcoin/models/topup_request_model.dart';
import '../models/extra_meal_model.dart';
import '../models/mess_menu_model.dart';
import '../models/user_model.dart';
import '../services/firestore_ref_service.dart';
import '../services/hostel_mess_service.dart';
import '../services/menu_services.dart';
import '../services/student_service.dart';
import '../utils/toast_snack_bar.dart';
import '../routes/app_routes.dart';
import '../utils/logger_util.dart';

class HomeController extends GetxController {
  Rx<StudentModel?> studentModel = Rx<StudentModel?>(null);
  Rx<ExtraMealModel?> extraMealModel = Rx<ExtraMealModel?>(null);
  RxMap<String, MessMenuModel?> messMenuModel = <String, MessMenuModel?>{}.obs;
  RxList<CouponTransactionHistory> couponTransactionHistoryList =
      RxList<CouponTransactionHistory>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  RxBool isLoading = false.obs;

  late final String hostelId;

  FirestoreRefService firestoreRefService = FirestoreRefService();

  @override
  void onReady() async {
    super.onReady();
    AppLogger.i("HomeController initialized.");
    final args = Get.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      AppLogger.w("Invalid arguments received. Redirecting...");
      AppSnackBar.error("Invalid arguments. Redirecting...");
      Get.offAllNamed(AppRoutes.getSelectHostelRoute());
      return;
    }
    hostelId = args['hostel_id'];
    AppLogger.d("Hostel ID received: $hostelId");

    await fetchStudentData();

    if (studentModel.value == null) {
      await fetchTempStudentData();
      if (studentModel.value == null) {
        AppLogger.w("Student data is null. Redirecting...");

        Get.offAllNamed(AppRoutes.getSelectHostelRoute());
        return;
      }
    }

    fetchExtraMealData();
  }

  Future<void> fetchStudentData() async {
    try {
      AppLogger.d("Fetching student data...");
      final fetchedStudent = await StudentService().fetchStudent(uid, hostelId);

      if (fetchedStudent != null) {
        studentModel.value = fetchedStudent;
        AppLogger.i("Student data fetched successfully.");
      } else {
        AppLogger.w("User data not found.");
        // AppSnackBar.error("User Data Not Found.");
      }
    } catch (e) {
      AppLogger.e("Error fetching student data: $e");
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> fetchTempStudentData() async {
    try {
      AppLogger.d("Fetching temp student data...");
      final fetchedStudent = await StudentService().fetchTempStudent(uid);

      if (fetchedStudent != null) {
        studentModel.value = fetchedStudent;
        AppLogger.i("Student data fetched successfully.");
      } else {
        AppLogger.w("User data not found.");
        // AppSnackBar.error("User Data Not Found.");
      }
    } catch (e) {
      AppLogger.e("Error fetching student data: $e");
      AppSnackBar.error(e.toString());
    }
  }

  void fetchExtraMealData() async {
    try {
      AppLogger.d("Fetching extra meal data...");
      final fetchedExtraMeal = await MenuServices().fetchExtraMeal(hostelId);

      if (fetchedExtraMeal != null) {
        extraMealModel.value = fetchedExtraMeal;
        AppLogger.i("Extra meal data fetched successfully.");
      } else {
        AppLogger.w("Extra meal data not found.");
        AppSnackBar.error("Extra Meal Not Found.");
      }
    } catch (e) {
      AppLogger.e("Error fetching extra meal data: $e");
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> performTopupRequest(
      String amount, String transactionId, DateTime transactionTime) async {
    try {
      isLoading.value = true;
      AppLogger.d(
          "Processing payment request of ₹$amount with transaction ID: $transactionId");
      int paymentAmount = int.tryParse(amount) ?? 0;
      int prevAmount = studentModel.value?.currentBal ?? 0;

      TopupRequestModel topupRequestModel = TopupRequestModel(
          uid: uid,
          rollNo: studentModel.value?.rollNo,
          name: studentModel.value?.name,
          amount: paymentAmount,
          transactionId: transactionId,
          transactionTime: transactionTime.toIso8601String());
      await StudentService().addTopupRequest(hostelId, topupRequestModel);

      AppLogger.i("Payment Request successful.");
      AppSnackBar.success("Request Successful.");
    } catch (e) {
      AppLogger.e("Payment request failed: $e");
      AppSnackBar.error("An error occurred: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> performPayment(
      String amount, String transactionId, DateTime transactionTime) async {
    try {
      isLoading.value = true;
      AppLogger.d(
          "Processing payment of ₹$amount with transaction ID: $transactionId");
      int paymentAmount = int.tryParse(amount) ?? 0;
      int prevAmount = studentModel.value?.currentBal ?? 0;
      int currAmount = prevAmount - paymentAmount;
      CouponTransactionHistory couponTransactionHistory =
          CouponTransactionHistory(
              transactionId: transactionId,
              amount: paymentAmount,
              transactionTime: transactionTime.toIso8601String(),
              status: "completed");

      await StudentService().addCouponTransaction(hostelId, uid, paymentAmount,
          transactionTime, prevAmount, couponTransactionHistory);

      studentModel.value = studentModel.value?.copyWith(
        currentBal: currAmount,
      );
      await HostelMessService().addTransaction(
          isTopUp: false,
          hostelId: hostelId,
          name: "${studentModel.value?.name}",
          rollNo: "${studentModel.value?.rollNo}",
          rechargeAmount: paymentAmount,
          transactionId: transactionId,
          transactionTime: transactionTime.toIso8601String());

      couponTransactionHistoryList.insert(0, couponTransactionHistory);
      AppLogger.i("Payment successful. Remaining balance: ₹$currAmount");
      AppSnackBar.success("Payment Successful.");
    } catch (e) {
      AppLogger.e("Payment failed: $e");
      AppSnackBar.error("An error occurred: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchMessMenuData() async {
    try {
      AppLogger.d("Fetching mess menu data...");
      List<String> days = [
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
          messMenuModel.update(
            day,
            (_) => fetchMessMenuData,
            ifAbsent: () => fetchMessMenuData,
          );
          AppLogger.i("Fetched mess menu for $day.");
        } else {
          AppLogger.w("Mess menu not found for $day.");
          AppSnackBar.error("Mess Menu Not Found.");
        }
      }
    } catch (e) {
      AppLogger.e("Error fetching mess menu data: $e");
      AppSnackBar.error(e.toString());
    }
  }

  void fetchCouponTransactionList() async {
    try {
      AppLogger.d("Fetching coupon transaction history...");
      couponTransactionHistoryList.value =
          await StudentService().fetchCouponTransactionHistory(uid, hostelId);
      AppLogger.i(
          "Fetched ${couponTransactionHistoryList.length} transaction(s).");
    } catch (e) {
      AppLogger.e("Error fetching transaction history: $e");
      AppSnackBar.error(e.toString());
    }
  }
}
