import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messcoin/utils/toast_snack_bar.dart';
import '../../controllers/signup_controller.dart';
import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/rect_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final SignupController signupController = Get.put(SignupController());

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
              "Register",
              style: TextStyle(
                fontFamily: "Valorax",
                fontSize: width * 0.09,
                fontWeight: FontWeight.w500,
                color: AppColors.nightSky,
              ),
            ),
            const SizedBox(height: 8,),
            _buildImageUi(context),
            _buidInputField(
                title: "Name",
                hintText: "Enter Name",
                textInputType: TextInputType.text,
                controller: nameController),
            _buidInputField(
                title: "Roll No.",
                hintText: "Enter Roll No.",
                textInputType: TextInputType.number,
                controller: rollController),
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
                obscure: true),
            _buildHostelDropDownUI(),
            const SizedBox(
              height: 20,
            ),
            Obx(() => RectButton(
                name: "Create Account",
                onTap: () {
                  signupController.signup(
                      emailController.text.trim().toString(),
                      passwordController.text.toString().trim(),
                      nameController.text.toString().trim(),
                      rollController.text.toString().trim());

                  _buildEmailVerificationUI(name: nameController.text);
                },
                isLoading: signupController.isLoading.value)),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: "Already have an account?  ",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.nightSky,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAllNamed(AppRoutes.getLoginRoute());
                        },
                    )
                  ]),
            )
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
                    hintText: hintText),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildEmailVerificationUI({String? name}) {
    Get.bottomSheet(
        elevation: 10,
        isDismissible: false,
        persistent: true,
        Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          decoration: BoxDecoration(
            color: AppColors.aquaPastel,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text("Hello ${name ?? "User"}",
                  style: TextStyle(
                      fontSize: 22,
                      color: AppColors.nightSky,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify),
              Text(
                  "We have just sent email verification link on your email. Please check your email and click on that link to verify your email address.",
                  style: TextStyle(fontSize: 20, color: AppColors.nightSky),
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              Text("Redirects automatically ones email is verified.",
                  style: TextStyle(fontSize: 15, color: AppColors.grey),
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  color: AppColors.nightSky,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                    _launchGmail();
                  },
                  child: Text(
                    "Open Mail",
                    style: TextStyle(
                        color: AppColors.aquaPastel,
                        fontSize: 18,
                        fontFamily: "Aquire"),
                  ),
                ),
              ),
            ],
          ),
        ));
    Future.delayed(const Duration(seconds: 10), () {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    });
  }

  _buildHostelDropDownUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Mess:",
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
            child: Obx(() {
              if (signupController.hostels.isEmpty) {
                return Center(
                  child: SizedBox(
                      child: CircularProgressIndicator(
                    strokeWidth: 3,
                  )),
                );
              }
              return DropdownButton<String>(
                underline: SizedBox(),
                padding: EdgeInsets.only(left: 10),
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.nightSky,
                ),
                borderRadius: BorderRadius.circular(15),
                elevation: 8,
                dropdownColor: AppColors.aquaPastel,
                value: signupController.selectedHostelId.value.isEmpty
                    ? null
                    : signupController.selectedHostelId.value,
                hint: const Text("Choose Mess"),
                items: signupController.hostels.map((hostel) {
                  return DropdownMenuItem(
                      value: hostel['id'], child: Text(hostel['name'] ?? ''));
                }).toList(),
                onChanged: (selectedId) {
                  signupController.selectedHostelId.value = selectedId!;
                },
              );
            }),
          ),
        ),
      ]),
    );
  }

  _buildImageUi(BuildContext context) {
    final theme = Theme.of(context);
    final width = Get.width * 1.3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: width * 0.5,
            width: width * 0.4,
            child: Obx(() {
              return Card(
                  color: theme.colorScheme.primaryContainer,
                  elevation: 10,
                  child: Center(
                    child: signupController.imageFile.value != null
                        ? Image.file(
                            signupController.imageFile.value!,
                            fit: BoxFit.cover,
                          )
                        : Text("Add Image"),
                  ));
            })),
        Column(
          children: [
            ElevatedButton.icon(
              label: Text(
                "From Gallery",
                style: TextStyle(color: AppColors.nightSky),
              ),
              onPressed: () {
                signupController.pickImageFromGallery();
              },
              icon: Icon(
                Icons.photo_album,
                color: AppColors.nightSky,
              ),
            ),
            ElevatedButton.icon(
              label: Text(
                "From Camera",
                style: TextStyle(color: AppColors.nightSky),
              ),
              onPressed: () {
                signupController.pickImageFromCamera();
              },
              icon: Icon(
                Icons.photo_camera,
                color: AppColors.nightSky,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _launchGmail() async {
    if (Platform.isAndroid) {
      final Uri gmailUri = Uri.parse("intent://com.google.android.gm/#Intent;scheme=android-app;end;");
      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(gmailUri);
      } else {
        AppSnackBar.error('Could not launch Gmail');
        // throw 'Could not launch Gmail';
      }
    } else if (Platform.isIOS) {
      final Uri gmailUri = Uri.parse("googlegmail://");
      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(gmailUri);
      } else {
        AppSnackBar.error('Could not launch Gmail');
        // throw 'Could not launch Gmail';
      }
    } else {
      throw 'Unsupported platform';
    }
  }
}
