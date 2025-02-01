import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:messcoin/models/user_model.dart';
import 'package:messcoin/services/student_service.dart';
import '../routes/app_routes.dart';
import '../services/firestore_ref_service.dart';
import '../services/hostel_mess_service.dart';
import '../utils/toast_snack_bar.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreRefService firestoreRefService = FirestoreRefService();

  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool canResendEmail = true.obs;
  Rx<User?> firebaseUser = Rx<User?>(null);

  RxList<Map<String, String>> hostels = <Map<String, String>>[].obs;
  RxString selectedHostelId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    getHostelList();
  }

  void getHostelList() async {
    hostels.value = await HostelMessService().fetchHostel();
  }

  Future<void> signup(
      String email, String password, String name, String roll) async {
    isLoading.value = true;
    try {
      if (!(email.length < 100 && email.split('@').last == 'nitp.ac.in')) {
        AppSnackBar.error("Use correct College Mail");
        return;
      }
      if (password.length < 6 || password.length > 100) {
        AppSnackBar.error("Password is too long or too short.(>6)");
        return;
      }
      if (name.length > 100) {
        AppSnackBar.error("Name is too large.");
        return;
      }
      if (roll.length > 12) {
        AppSnackBar.error("Roll is not correctly formatted.");
        return;
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value = userCredential.user;

      if (firebaseUser.value != null) {
        await firebaseUser.value?.sendEmailVerification();
        AppSnackBar.success(
            "Verification email sent. Please verify your email.");

        final isVerified = await _waitForEmailVerification();
        if (isVerified) {
          String uid = _auth.currentUser!.uid;
          await _createFirestoreUser(name, roll, email, uid);
          AppSnackBar.success("Account created successfully!");
          Get.offAllNamed(AppRoutes.getLoginRoute());
        } else {
          AppSnackBar.error("Email not verified. Registration incomplete.");
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createFirestoreUser(
      String name, String roll, String email, String uid) async {
    StudentModel studentModel = StudentModel(
        name: name.toString().camelCase,
        rollNo: roll,
        email: email,
        uid: uid,
        currentSem: 0,
        isVerified: false,
        status: "deactivated",
        totalCredit: 0,
        leftCredit: 0,
        currentBal: 0,
        hostel: Hostel(
            id: selectedHostelId.value,
            name: hostels
                .where((hostel) => hostel['id'] == selectedHostelId.value)
                .first['name'],
            roomNumber: ""),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
        createdBy: "user",
        updatedBy: "user",
        topupHistory: [],
        leaveHistory: []);

    await StudentService().addStudent(studentModel);
  }

  Future<bool> _waitForEmailVerification() async {
    final startTime = DateTime.now();
    while (!(firebaseUser.value?.emailVerified ?? false)) {
      await Future.delayed(const Duration(seconds: 3));
      await firebaseUser.value?.reload();
      firebaseUser.value = _auth.currentUser;
      if (DateTime.now().difference(startTime).inMinutes >= 5) {
        return false;
      }
    }
    return true;
  }

  Future<void> manualCheckVerification() async {
    try {
      await firebaseUser.value?.reload();
      firebaseUser.value = _auth.currentUser;
      if (firebaseUser.value?.emailVerified ?? false) {
        AppSnackBar.success("Email verified successfully.");
        Get.offAllNamed(AppRoutes.getLoginRoute());
      } else {
        AppSnackBar.error(
            "Email is not verified yet. Please check your email.");
      }
    } catch (e) {
      AppSnackBar.error(
          "An error occurred while checking verification status.");
    }
  }

  Future<void> resendVerificationEmail() async {
    if (firebaseUser.value != null) {
      try {
        await firebaseUser.value!.sendEmailVerification();
        AppSnackBar.success("Verification email sent successfully.");
        canResendEmail.value = false;
        Future.delayed(const Duration(seconds: 60), () {
          canResendEmail.value = true;
        });
      } catch (e) {
        AppSnackBar.error(
            "Failed to send verification email. Please try again.");
      }
    } else {
      AppSnackBar.error("No user is logged in to resend the email.");
    }
  }
}
