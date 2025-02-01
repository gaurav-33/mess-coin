import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messcoin/controllers/home_controller.dart';
import 'package:messcoin/widgets/header_widget.dart';

import '../res/app_colors.dart';
import '../widgets/back_button.dart';
import '../widgets/card_widget.dart';

class MessMenuScreen extends StatelessWidget {
  MessMenuScreen({super.key});
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final double width = Get.width;
    final double height = Get.height;
    String day = DateFormat.EEEE().format(DateTime.now()).toLowerCase();
    RxString selectedDay = day.obs;

    List<Obx> cardWidgetList = <Obx>[
      Obx(
        () => CardWidget(
          title: "Sun",
          isSelected: selectedDay.value == 'sunday',
          onTap: () {
            selectedDay.value = 'sunday';
          },
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Mon",
          isSelected: selectedDay.value == "monday",
          onTap: () {
            selectedDay.value = 'monday';
          },
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Tue",
          isSelected: selectedDay.value == "tuesday",
          onTap: () {
            selectedDay.value = 'tuesday';
          },
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Wed",
          isSelected: selectedDay.value == "wednesday",
          onTap: () {
            selectedDay.value = 'wednesday';
          },
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Thur",
          isSelected: selectedDay.value == "thursday",
          onTap: () {
            selectedDay.value = 'thursday';
          },
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Fri",
          isSelected: selectedDay.value == "friday",
          onTap: () {
            selectedDay.value = 'friday';
          },
        ),
      ),
      Obx(
        () => CardWidget(
          title: "Sat",
          isSelected: selectedDay.value == "saturday",
          onTap: () {
            selectedDay.value = 'saturday';
          },
        ),
      )
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(homeController: homeController),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Menu",
              style: TextStyle(
                fontFamily: "Aquire",
                fontSize: width * 0.06,
                fontWeight: FontWeight.w500,
                color: AppColors.nightSky,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16, left: 8, right: 8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.75,
                        width: width * 0.2,
                        child: GridView.count(
                          crossAxisCount: 1,
                          children: cardWidgetList,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Breakfast:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => _buildMenuItem(homeController
                                  .messMenuModel.value[selectedDay]?.breakfast),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Lunch:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => _buildMenuItem(homeController
                                  .messMenuModel.value[selectedDay]?.lunch),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Snacks:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => _buildMenuItem(homeController
                                  .messMenuModel.value?[selectedDay]?.snacks),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Dinner:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => _buildMenuItem(homeController
                                  .messMenuModel.value?[selectedDay]?.dinner),
                            ),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                  BackButtonWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildMenuItem(List<String>? menuList) {
    if (menuList == null || menuList.isEmpty) {
      return const Text("Loading Data...");
    }
    final double width = Get.width;
    return Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColors.grey,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(1, 3))
        ], color: AppColors.nightSky, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menuList
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      item,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColors.aquaPastel,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}
