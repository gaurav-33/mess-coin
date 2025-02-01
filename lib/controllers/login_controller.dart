import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../utils/toast_snack_bar.dart';

class LoginController extends GetxController {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Loading state
  RxBool isLoading = false.obs;

  // Visibility State
  RxBool visible = false.obs;

  // Login method
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      String domain = email.split('@').last;
      if (domain != 'nitp.ac.in') {
        AppSnackBar.error("Use college email only.");
        return;
      }
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_auth.currentUser!.emailVerified) {
        AppSnackBar.success("Logged in successfully!");
        Get.offAllNamed(AppRoutes.getHomeRoute());
      } else {
        AppSnackBar.error("User is not verified. Please check your Email.");
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

  void sendResetLink(String email) async {
    try {
      String domain = email.split('@').last;
      if (domain != 'nitp.ac.in') {
        AppSnackBar.error("Use college email only.");
        return;
      }
      await _auth.sendPasswordResetEmail(email: email);
      AppSnackBar.success("Reset Link sent Successfully");
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    }
  }
}
