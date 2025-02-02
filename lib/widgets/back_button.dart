import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../routes/app_routes.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Get.until((route) => route.settings.name == AppRoutes.home);
      },
      child: Text(
        "Back",
        style: TextStyle(
            color: AppColors.nightSky, fontSize: 14, fontFamily: "Aquire"),
      ),
    );
  }
}
