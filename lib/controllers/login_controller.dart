import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../utils/logger_util.dart';
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
      AppLogger.i("Login attempt for email: $email");

      if (domain != 'nitp.ac.in') {
        AppSnackBar.error("Use college email only.");
        AppLogger.w("Invalid email domain: $domain");
        return;
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppLogger.i(
          "User logged in successfully: ${_auth.currentUser?.email}"); // Log successful login

      if (_auth.currentUser!.emailVerified) {
        AppSnackBar.success("Logged in successfully!");
        Get.offAllNamed(AppRoutes.getHomeRoute());
      } else {
        AppSnackBar.error("User is not verified. Please check your Email.");
        AppLogger.w(
            "User is not verified: ${_auth.currentUser?.email}"); // Log unverified user
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
        AppLogger.e(
            "FirebaseAuthException: ${e.message}, Code: ${e.code}"); // Log FirebaseAuthException
      } else {
        AppSnackBar.error("An unexpected error occurred.");
        AppLogger.e("Unexpected error: $e"); // Log other errors
      }
    } finally {
      isLoading.value = false;
      AppLogger.i(
          "Login process completed."); // Log completion of login process
    }
  }

  void sendResetLink(String email) async {
    try {
      String domain = email.split('@').last;
      AppLogger.i(
          "Password reset link request for email: $email"); // Log reset request

      if (domain != 'nitp.ac.in') {
        AppSnackBar.error("Use college email only.");
        AppLogger.w(
            "Invalid email domain for reset: $domain"); // Log invalid domain
        return;
      }

      await _auth.sendPasswordResetEmail(email: email);
      AppSnackBar.success("Reset Link sent Successfully");
      AppLogger.i(
          "Password reset link sent to: $email"); // Log successful reset link sent
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
        AppLogger.e(
            "FirebaseAuthException: ${e.message}, Code: ${e.code}"); // Log FirebaseAuthException
      } else {
        AppSnackBar.error("An unexpected error occurred.");
        AppLogger.e("Unexpected error: $e"); // Log other errors
      }
    }
  }
}
