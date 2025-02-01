import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../res/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.homeController,
    this.isWelcomeText,
  });

  final HomeController homeController;
  final bool? isWelcomeText;

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    TextStyle valueTextStyle = TextStyle(
        color: AppColors.aquaPastel,
        fontFamily: "Poppins",
        fontSize: width * 0.035,
        fontWeight: FontWeight.w600);
    return Container(
      height: height * 0.31,
      width: width,
      padding: EdgeInsets.all(width * 0.045),
      decoration: BoxDecoration(
          color: AppColors.nightSky,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 9,
              spreadRadius: 1,
              offset: Offset(3, 6),
            )
          ],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(width * 0.2, width * 0.2))),
      child: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Mess Coin",
                style: TextStyle(
                  fontFamily: "Valorax",
                  fontSize: width * 0.08,
                  color: AppColors.aquaPastel,
                ),
              ),
              isWelcomeText != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome Back",
                        style: valueTextStyle,
                      ),
                    )
                  : const SizedBox(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${homeController.studentModel.value?.name}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.aquaPastel,
                      fontSize: width * 0.07,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Currnent Bal: ₹ ",
                          style: valueTextStyle,
                          children: [
                        TextSpan(
                          text:
                              "${homeController.studentModel.value?.currentBal}",
                          style: TextStyle(
                              color: AppColors.aquaPastel,
                              fontSize: width * 0.05,
                              fontFamily: "Poppins"),
                        )
                      ])),
                  RichText(
                      text: TextSpan(
                          text: "Credit Left: ₹ ",
                          style: valueTextStyle,
                          children: [
                        TextSpan(
                          text:
                              "${homeController.studentModel.value?.leftCredit}",
                          style: TextStyle(
                              color: AppColors.aquaPastel,
                              fontSize: width * 0.05,
                              fontFamily: "Poppins"),
                        )
                      ])),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${homeController.studentModel.value?.hostel?.name}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.aquaPastel,
                      fontSize: width * 0.035,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
