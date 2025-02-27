import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/home_controller.dart';
import '../res/app_colors.dart';
import '../routes/app_routes.dart';

class MessCardScreen extends StatelessWidget {
  MessCardScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.darkBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _buildGlassContainer(),
                _buildCardCuts(),
                _buildMainContainer(),
                _buildProfileUI()
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () {
                Get.until((route) => route.settings.name == AppRoutes.home);
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
      ),
    );
  }

  Widget _buildGlassContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: Get.width * 0.9,
          height: Get.height * 0.615,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2, color: Colors.white.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }

  Widget _buildCardCuts() {
    return Positioned(
      top: 25,
      child: Container(
        height: 18,
        width: 85,
        decoration: BoxDecoration(
            color: AppColors.darkBlue, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildMainContainer() {
    final student = homeController.studentModel.value;

    return Positioned(
      bottom: 20,
      child: Container(
        height: Get.height * 0.525,
        width: Get.width * 0.82,
        decoration: BoxDecoration(
          color: AppColors.aquaPastel,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildHeaderUI(),
            SizedBox(height: Get.width * 0.21),
            _buildDetailRow("Name", student?.name ?? "N/A"),
            _buildDetailRow("Roll No", student?.rollNo ?? "N/A"),
            _buildDetailRow("Room No", student?.hostel?.roomNumber ?? "N/A"),
            const SizedBox(height: 5),
            _buildQRCode("${student?.uid}"),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderUI() {
    return Container(
      height: Get.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.nightSky,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          homeController.studentModel.value?.hostel?.name ?? "Hostel Name",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Get.width * 0.06,
            fontFamily: "Poppins",
            color: AppColors.aquaPastel,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileUI() {
    return Positioned(
      top: Get.height * 0.2,
      child: Container(
        width: Get.width * 0.3,
        height: Get.width * 0.3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: AppColors.aquaPastel),
          boxShadow: [
            BoxShadow(color: AppColors.grey, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            (homeController.studentModel.value?.profileUrl == "" ||
                    homeController.studentModel.value?.profileUrl == null)
                ? "https://i.pinimg.com/736x/c0/99/15/c099159849a5f3399e05335f2c56adca.jpg"
                : homeController.studentModel.value?.profileUrl ??
                    "https://i.pinimg.com/736x/c0/99/15/c099159849a5f3399e05335f2c56adca.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCode(String data) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: Get.width * 0.32,
    );
  }
}
