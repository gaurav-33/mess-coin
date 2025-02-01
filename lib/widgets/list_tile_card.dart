import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';

class ListTileCard extends StatelessWidget {
  const ListTileCard(
      {super.key, required this.title, required this.trailing, this.subtitle, this.height});

  final String title;
  final String trailing;
  final String? subtitle;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.width * 0.1,
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: AppColors.nightSky, // Set border color
            width: 0.5),
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              color: AppColors.grey.withOpacity(0.5),
              spreadRadius: 1,
              offset: Offset(1, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppColors.nightSky,
                    fontFamily: "Poppins",
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                trailing,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.nightSky,
                    fontFamily: "Poppins",
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          subtitle != null
              ? Text(
                  subtitle!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.nightSky,
                      fontFamily: "Poppins",
                      fontSize: Get.width * 0.025,
                      fontWeight: FontWeight.w600),
                )
              : Container(),

              
        ],
      ),
    );
    ;
  }
}
