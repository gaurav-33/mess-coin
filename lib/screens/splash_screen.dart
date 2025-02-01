import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messcoin/res/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aquaPastel,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 0, 15, 111),
              const Color.fromARGB(255, 0, 9, 64),
              const Color.fromARGB(255, 0, 6, 43),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "MESS COIN",
                  style: TextStyle(
                    fontSize: Get.width * 0.11,
                    color: AppColors.aquaPastel,
                    fontFamily: "Valorax",
                    shadows: [
                      Shadow(
                          color: AppColors.grey,
                          blurRadius: 20,
                          offset: Offset(0, -135)),
                      Shadow(
                          color: AppColors.grey,
                          blurRadius: 15,
                          offset: Offset(0, -90)),
                      Shadow(
                          color: AppColors.grey,
                          blurRadius: 5,
                          offset: Offset(0, -45)),
                      Shadow(
                          color: AppColors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 45)),
                      Shadow(
                          color: AppColors.grey,
                          blurRadius: 15,
                          offset: Offset(0, 90)),
                      Shadow(
                          color: AppColors.grey,
                          blurRadius: 20,
                          offset: Offset(0, 135)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.aquaPastel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
