import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/header_widget.dart';
import '../res/app_colors.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    String usedCredit =
        (((homeController.studentModel.value?.totalCredit ?? 0) -
                    (homeController.studentModel.value?.leftCredit ?? 0)) *
                100 /
                (homeController.studentModel.value?.totalCredit ?? 0))
            .toStringAsFixed(2);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderWidget(homeController: homeController),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Profile",
              style: TextStyle(
                fontFamily: "Aquire",
                fontSize: width * 0.06,
                fontWeight: FontWeight.w500,
                color: AppColors.nightSky,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width,
              height: height * 0.68,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.nightSky,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey,
                    blurRadius: 9,
                    spreadRadius: 1,
                    offset: Offset(-3, -6),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(width * 0.2, width * 0.2),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: height * 0.15,
                    width: height * 0.12,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: AppColors.aquaPastel),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image(
                      image: NetworkImage(
                          "https://i.pinimg.com/736x/c0/99/15/c099159849a5f3399e05335f2c56adca.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildFieldUI(
                      "Name", "${homeController.studentModel.value?.name}"),
                  _buildFieldUI(
                      "Roll", "${homeController.studentModel.value?.rollNo}"),
                  _buildFieldUI(
                      "Email", "${homeController.studentModel.value?.email}"),
                  _buildFieldUI("Semester",
                      "${homeController.studentModel.value?.currentSem}"),
                  _buildFieldUI("Hostel",
                      "${homeController.studentModel.value?.hostel?.name}"),
                  _buildFieldUI("Room no.",
                      "${homeController.studentModel.value?.hostel?.roomNumber}"),
                  _buildFieldUI(
                      "Status", "${homeController.studentModel.value?.status}"),
                  _buildFieldUI("IsVerified",
                      "${homeController.studentModel.value?.isVerified}"),
                  _buildFieldUI("Credit Utilization", "$usedCredit %"),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(children: [
                    Container(
                      height: 7,
                      width: width * 0.75,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      height: 7,
                      width: width *
                          0.75 *
                          (((homeController.studentModel.value?.totalCredit ??
                                      0) -
                                  (homeController
                                          .studentModel.value?.leftCredit ??
                                      0)) /
                              (homeController.studentModel.value?.totalCredit ??
                                  0)),
                      decoration: BoxDecoration(
                        color: AppColors.aquaPastel,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.until(
                          (route) => route.settings.name == AppRoutes.home);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                          color: AppColors.aquaPastel,
                          fontSize: 14,
                          fontFamily: "Aquire"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildFieldUI(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      width: Get.width * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$key: ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.aquaPastel,
                fontFamily: "Poppins",
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColors.aquaPastel,
                fontFamily: "Poppins",
                fontSize: Get.width * 0.037,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
