import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  // Success
  static void success(String msg) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    } else {
      Get.snackbar(
        "Success",
        msg,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  // Error with Firebase Authentication error handling
  static void error(String msg, {String? errorCode}) {
    String errorMessage;

    // Map specific error codes to user-friendly messages
    switch (errorCode) {
      case 'email-already-in-use':
        errorMessage =
            "The email address is already in use by another account.";
        break;
      case 'weak-password':
        errorMessage = "The password provided is too weak.";
        break;
      case 'user-not-found':
        errorMessage = "No user found with this email address.";
        break;
      case 'wrong-password':
        errorMessage = "Incorrect password. Please try again.";
        break;
      case 'invalid-email':
        errorMessage = "The email address is not valid.";
        break;
      case 'operation-not-allowed':
        errorMessage = "This operation is not allowed. Please contact support.";
        break;
      case 'network-request-failed':
        errorMessage =
            "A network error occurred. Please check your connection.";
        break;
      case 'too-many-requests':
        errorMessage = "Too many requests. Please wait a moment and try again.";
        break;
      default:
        errorMessage = msg;
        break;
    }

    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    } else {
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      });
    }
  }
}
