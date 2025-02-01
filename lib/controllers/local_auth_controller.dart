import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:messcoin/utils/toast_snack_bar.dart';

import '../res/app_colors.dart';

class LocalAuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final RxBool canAuthenticate = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkAuthenticationSupport();
  }

  Future<void> _checkAuthenticationSupport() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();
    canAuthenticate.value = canCheckBiometrics || isDeviceSupported;
  }

  Future<bool> performAuthentication() async {
    try {
      return await auth.authenticate(
        localizedReason: "Please Authenticate to Perform Payment.",
        options: AuthenticationOptions(stickyAuth: true),
      );
    } on PlatformException catch (e) {
      AppSnackBar.error(e.message ?? "Authentication failed");
      return false;
    }
  }

  Future<bool> showConfirmDialog(
      BuildContext context, String title, String message) async {
    return await Get.dialog(
          AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false), // User cancels
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: AppColors.nightSky,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true), // User proceeds
                child: Text(
                  "Proceed",
                  style: TextStyle(
                      color: AppColors.nightSky,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
