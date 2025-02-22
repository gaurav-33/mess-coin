import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/back_button.dart';
import '../widgets/header_widget.dart';
import '../widgets/rect_button.dart';
import '../controllers/local_auth_controller.dart';
import '../res/app_colors.dart';
import '../utils/toast_snack_bar.dart';

class RechargeScreen extends StatelessWidget {
  RechargeScreen({super.key});
  HomeController homeController = Get.find<HomeController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  LocalAuthController localAuthController = Get.put(LocalAuthController());

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
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
              "Recharge Wallet",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.currency_rupee_rounded,
                  size: width * 0.1,
                  color: AppColors.nightSky,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                        controller: amountController,
                        style: TextStyle(
                          fontFamily: "Aquire",
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w500,
                          color: AppColors.nightSky,
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 4,
                        decoration: InputDecoration(
                          hintText: "Enter amount",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.nightSky.withOpacity(0.7),
                              fontFamily: "Poppins"),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Amount is required";
                          }
                          if (int.tryParse(value) == null) {
                            return "Not valid";
                          }
                          if (int.parse(value) < 500 &&
                              homeController.studentModel.value!.leftCredit! >=
                                  500) {
                            return "Min. ₹500";
                          }
                          if (int.parse(value) >
                              homeController.studentModel.value!.leftCredit!) {
                            return "*Less than ${homeController.studentModel.value!.leftCredit!}";
                          }
                          return null;
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.2,
            ),
            Obx(() => RectButton(
                name: "Request",
                onTap: () async {
                  if (_formKey.currentState!.validate() &&
                      homeController.isLoading.value == false) {
                    DateTime transactionTime = DateTime.now();
                    String transactionId =
                        "txn_${transactionTime.microsecondsSinceEpoch}${homeController.studentModel.value?.rollNo}";

                    if (localAuthController.canAuthenticate.value) {
                      bool isAuthenticated =
                          await localAuthController.performAuthentication();

                      if (!isAuthenticated) {
                        AppSnackBar.error(
                            "Authentication failed. Payment not processed.");
                        return;
                      }
                    }
                    await homeController.performTopupRequest(
                        amountController.text.trim().toString(),
                        transactionId,
                        transactionTime);
                    showRechargeSuccessDialog(context, transactionId);
                  }
                },
                isLoading: homeController.isLoading.value)),
            const SizedBox(
              height: 20,
            ),
            BackButtonWidget()
          ],
        ),
      ),
    );
  }

  void showRechargeSuccessDialog(BuildContext context, String transactionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          icon: Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green[800],
            size: 80,
          ),
          title: const Text(
            "Request Successful",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: AppColors.nightSky),
          ),
          content: SizedBox(
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Text(
                  "Your Request was successful!.",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                ),
                SelectableText(
                  "TxnId: $transactionId",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                amountController.clear();
                Get.back();
                Get.until((route) => route.settings.name == AppRoutes.home);
              },
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
