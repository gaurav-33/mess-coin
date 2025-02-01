import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:messcoin/shared/hostel_id_preferences.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController {
  late final String? hostelId;

  @override
  void onInit() async {
    super.onInit();
    hostelId = await isHostelStored();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isLogin()) {
      if (hostelId != null && hostelId != '' ) {
        Get.offNamed(AppRoutes.getHomeRoute(),
            arguments: {'hostel_id': hostelId});
      } else {
        Get.offNamed(AppRoutes.getSelectHostelRoute());
      }

    } else {
      Get.offNamed(AppRoutes.getLoginRoute());
    }
  }

  bool isLogin() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<String?> isHostelStored() async {
    String? hostelId = await HostelIdPreferences.getHostelId();
    return hostelId;
  }
}
