import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messcoin/controllers/home_controller.dart';
import 'package:messcoin/models/extra_meal_model.dart';
import 'package:messcoin/routes/app_routes.dart';
import 'package:messcoin/widgets/card_widget.dart';
import 'package:messcoin/widgets/header_widget.dart';
import 'package:messcoin/widgets/name_divider_widget.dart';
import '../res/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;

    List<Widget> cardWidgetList = <Widget>[
      Obx(
        () => CardWidget(
          title: "Pay",
          iconPath: "assets/icons/transaction.png",
          onTap: () {
            Get.toNamed(AppRoutes.getPaymentRoute());
            
          },
          isEnabled: homeController.studentModel.value?.isVerified,
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Recharge",
          iconPath: "assets/icons/money.png",
          onTap: () {
            Get.toNamed(AppRoutes.getRechagreRoute());
          },
          isEnabled: homeController.studentModel.value?.isVerified,
        ),
      ),
      CardWidget(
        title: "History",
        iconPath: "assets/icons/transaction-history.png",
        onTap: () {
          Get.toNamed(AppRoutes.getHistoryRoute());
          homeController.couponTransactionHistoryList.isEmpty ? homeController.fetchCouponTransactionList() : null ;
          
        },
      ),
      CardWidget(
        title: "Menu",
        iconPath: "assets/icons/menu.png",
        onTap: () {
          Get.toNamed(AppRoutes.getMessMenuRoute());
          // homeController.uploadMenu();
        },
      ),
      CardWidget(
        title: "Mess Card",
        iconPath: "assets/icons/card.png",
        onTap: () {
          Get.toNamed(AppRoutes.getMessCardRoute());
        },
      ),
      CardWidget(
        title: "Profile",
        iconPath: "assets/icons/user.png",
        onTap: () {
          Get.toNamed(AppRoutes.getProfileRoute());
        },
      ),
    ];

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(
            homeController: homeController,
            isWelcomeText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                NameDividerWidget(name: "Quick Actions"),
                Obx(
                  () => SizedBox(
                    height: height * 0.33,
                    child: homeController.studentModel.value == null
                        ? Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: const CircularProgressIndicator()),
                          )
                        : GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: cardWidgetList,
                          ),
                  ),
                ),
                NameDividerWidget(name: "Today's Extra"),
                const SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Breakfast",
                      style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Poppins",
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => _buildExtraMenuItem(
                      homeController.extraMealModel.value?.breakfast),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lunch",
                      style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Poppins",
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => _buildExtraMenuItem(
                      homeController.extraMealModel.value?.lunch),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dinner",
                      style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Poppins",
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => _buildExtraMenuItem(
                      homeController.extraMealModel.value?.dinner),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  _buildExtraMenuItem(List<Meal>? extramealmodel) {
    if (extramealmodel == null || extramealmodel.isEmpty) {
      return const Text("Loading Data...");
    }
    return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColors.grey,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(1, 3))
        ], color: AppColors.nightSky, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: extramealmodel
              .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item.name}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.aquaPastel,
                          fontFamily: "Poppins",
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "₹ ${item.price}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.aquaPastel,
                          fontFamily: "Poppins",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )))
              .toList(),
        ));
  }
}
