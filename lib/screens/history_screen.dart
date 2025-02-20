import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../models/user_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/name_divider_widget.dart';

import '../res/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderWidget(homeController: homeController),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Transactions",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    NameDividerWidget(name: "Recharge History"),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => _buildHistoryUI<TopupHistory>(
                        (homeController
                            .studentModel.value?.topupHistory.reversed
                            .toList()),
                        (item) => item.amount.toString(),
                        (item) => item.transactionTime,
                        (item) => item.transactionId.toString())),
                    const SizedBox(
                      height: 10,
                    ),
                    NameDividerWidget(name: "Coupon History"),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => _buildHistoryUI<CouponTransactionHistory>(
                        (homeController.couponTransactionHistoryList),
                        (item) => item.amount.toString(),
                        (item) => item.transactionTime,
                        (item) => item.transactionId.toString())),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryUI<T>(List<T>? history, String Function(T) getAmount,
      String? Function(T) getTime, String Function(T) getTransactionId) {
    if (history == null || history.isEmpty) {
      return const Text("Not Found");
    }

    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.nightSky,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(1, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: history.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${getAmount(item)}",
                      style: TextStyle(
                        color: AppColors.aquaPastel,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMEd().add_jm().format(
                          DateTime.tryParse(getTime(item)!) ?? DateTime.now()),
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "Poppins",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SelectableText(
                  getTransactionId(item),
                  style: TextStyle(
                    color: AppColors.aquaPastel,
                    fontFamily: "Poppins",
                    fontSize: 14,
                  ),
                ),
                const Divider(thickness: 0.5),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
