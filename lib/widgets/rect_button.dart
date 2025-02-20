import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {super.key,
      required this.name,
      required this.onTap,
      required this.isLoading});

  final String name;
  final VoidCallback onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.055,
      width: Get.width * 0.6,
      decoration: BoxDecoration(
        color: AppColors.nightSky,
        borderRadius: BorderRadius.circular(15),
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.aquaPastel,
              ),
            )
          : TextButton(
              onPressed: onTap,
              child: Text(
                name,
                style: TextStyle(
                    color: AppColors.aquaPastel,
                    fontFamily: "Aquire",
                    fontSize: 18),
              ),
            ),
    );
  }
}
