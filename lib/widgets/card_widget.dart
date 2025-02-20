import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/app_colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      this.iconPath,
      required this.title,
      required this.onTap,
      this.isSelected,
      this.isEnabled});

  final String? iconPath;
  final String title;
  final VoidCallback onTap;
  final bool? isSelected;
  final bool? isEnabled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled != null
          ? isEnabled == false
              ? null
              : onTap
          : onTap,
      child: Container(
        height: Get.width * 0.25,
        width: Get.width * 0.25,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: isSelected != null
                ? isSelected == true
                    ? AppColors.selectedCardColor
                    : AppColors.cardColor
                : AppColors.cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: isEnabled != null
                    ? isEnabled == false
                        ? Colors.red
                        : AppColors.nightSky
                    : AppColors.nightSky, // Set border color
                width: 3.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: AppColors.grey,
                  spreadRadius: 1,
                  offset: Offset(1, 3)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconPath != null
                ? Image(
                    image: AssetImage(iconPath!),
                    width: Get.width * 0.1,
                    color: AppColors.nightSky,
                  )
                : SizedBox(),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize:Get.width *0.03,
                  color: AppColors.nightSky,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
