import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/local_auth_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/back_button.dart';
import '../widgets/header_widget.dart';
import '../widgets/rect_button.dart';

import '../res/app_colors.dart';
import '../utils/toast_snack_bar.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  HomeController homeController = Get.find<HomeController>();
  LocalAuthController localAuthController = Get.put(LocalAuthController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => homeController.fetchStudentData(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderWidget(homeController: homeController),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Pay",
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 6),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Amount is required";
                            }
                            if (int.tryParse(value) == null) {
                              return "Enter a valid number";
                            }
                            if (int.parse(value) <= 0) {
                              return "Amount must be greater than 0";
                            }
                            if (int.parse(value) >
                                homeController
                                    .studentModel.value!.currentBal!) {
                              return "Amount must be less than ${homeController.studentModel.value!.currentBal!}";
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
                  name: "Pay",
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
                      await homeController.performPayment(
                        amountController.text.trim(),
                        transactionId,
                        transactionTime,
                      );
                      showPaymentSuccessDialog(context, transactionId);
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
      ),
    );
  }

  void showPaymentSuccessDialog(BuildContext context, String transactionId) {
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
            "Payment Successful",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: AppColors.nightSky),
          ),
          content: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                "₹ ${amountController.text}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: AppColors.nightSky),
              ),
              Text(
                "Roll No: ${homeController.studentModel.value?.rollNo}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: AppColors.nightSky),
              ),
              Text(
                "Your payment for ₹ ${amountController.text} was successful!",
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
