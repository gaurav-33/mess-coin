import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messcoin/controllers/login_controller.dart';
import 'package:messcoin/res/app_colors.dart';
import 'package:messcoin/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.31,
              width: width,
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
                      bottomRight:
                          Radius.elliptical(width * 0.2, width * 0.2))),
              child: Center(
                  child: Text(
                "Mess Coin",
                style: TextStyle(
                  fontFamily: "Valorax",
                  fontSize: width * 0.12,
                  color: AppColors.aquaPastel,
                ),
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Login",
              style: TextStyle(
                fontFamily: "Valorax",
                fontSize: width * 0.09,
                fontWeight: FontWeight.w500,
                color: AppColors.nightSky,
              ),
            ),
            _buidInputField(
                title: "Email",
                hintText: "Enter College Email",
                textInputType: TextInputType.emailAddress,
                controller: emailController),
            _buidInputField(
              title: "Password",
              hintText: "Enter Password",
              textInputType: TextInputType.text,
              controller: passwordController,
              obscure: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.055,
              width: width * 0.6,
              decoration: BoxDecoration(
                color: AppColors.nightSky,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () {
                  loginController.login(emailController.text.toString().trim(),
                      passwordController.text.toString().trim());
                },
                child: Obx(() {
                  return loginController.isLoading.value
                      ? CircularProgressIndicator(
                          color: AppColors.aquaPastel,
                        )
                      : Text(
                          "Login",
                          style: TextStyle(
                              color: AppColors.aquaPastel,
                              fontSize: 20,
                              fontFamily: "Aquire"),
                        );
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account?  ",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.nightSky,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAllNamed(AppRoutes.getSignupRoute());
                        },
                    )
                  ]),
            ),
            TextButton(
              onPressed: () {
                _buildForgetPasswordUI();
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.nightSky,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buidInputField(
      {required String title,
      required hintText,
      required textInputType,
      required TextEditingController controller,
      bool? obscure}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title:",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.nightSky),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.nightSky.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: TextField(
                keyboardType: textInputType,
                obscureText: obscure ?? false,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: hintText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildForgetPasswordUI() {
    if (Get.isBottomSheetOpen == true) {
      Get.back();
    }
    Get.bottomSheet(Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.aquaPastel,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(15)),
      ),
      child: Column(
        children: [
          Text(
            "Reset",
            style: TextStyle(
              fontFamily: "Valorax",
              fontSize: Get.width * 0.09,
              fontWeight: FontWeight.w500,
              color: AppColors.nightSky,
            ),
          ),
          _buidInputField(
              title: "Email",
              hintText: "Enter College Email",
              textInputType: TextInputType.emailAddress,
              controller: emailController),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: Get.height * 0.055,
            width: Get.width * 0.6,
            decoration: BoxDecoration(
              color: AppColors.nightSky,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
                onPressed: () {
                  Get.back();
                  loginController
                      .sendResetLink(emailController.text.toString().trim());
                },
                child: Text(
                  "Reset",
                  style: TextStyle(
                      color: AppColors.aquaPastel,
                      fontSize: 20,
                      fontFamily: "Aquire"),
                )),
          ),
        ],
      ),
    ));
  }
}
