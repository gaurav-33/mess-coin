import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:messcoin/shared/hostel_id_preferences.dart';

import '../routes/app_routes.dart';
import '../utils/logger_util.dart';

class SplashController extends GetxController {
  late final String? hostelId;

  @override
  void onInit() async {
    super.onInit();
    AppLogger.i("SplashController initialized.");
    hostelId = await isHostelStored();
    AppLogger.i("Hostel ID fetched: $hostelId");
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    AppLogger.i("Navigating to the next screen after delay.");
    await Future.delayed(const Duration(milliseconds: 1500));

    if (isLogin()) {
      if (hostelId != null && hostelId != '') {
        AppLogger.i("User is logged in, redirecting to home screen.");
        Get.offNamed(AppRoutes.getHomeRoute(),
            arguments: {'hostel_id': hostelId});
      } else {
        AppLogger.i(
            "User is logged in but no hostel ID found, redirecting to select hostel screen.");
        Get.offNamed(AppRoutes.getSelectHostelRoute());
      }
    } else {
      AppLogger.i("User is not logged in, redirecting to login screen.");
      Get.offNamed(AppRoutes.getLoginRoute());
    }
  }

  bool isLogin() {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    AppLogger.i("User login status: $isLoggedIn");
    return isLoggedIn;
  }

  Future<String?> isHostelStored() async {
    String? hostelId = await HostelIdPreferences.getHostelId();
    AppLogger.i("Stored hostel ID: $hostelId");
    return hostelId;
  }
}
