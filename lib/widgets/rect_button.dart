import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';

class RectButton extends StatelessWidget {
  const RectButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.055,
      width: Get.width * 0.6,
      decoration: BoxDecoration(
        color: AppColors.nightSky,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(onPressed: onTap, child: child),
    );
  }
}
