import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../models/user_model.dart';
import '../res/app_colors.dart';
import '../widgets/header_widget.dart';
import '../widgets/name_divider_widget.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final double width = Get.width;
    final double height = Get.height;

    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(
            homeController: homeController,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Leave History",
            style: TextStyle(
              fontFamily: "Aquire",
              fontSize: width * 0.06,
              fontWeight: FontWeight.w500,
              color: AppColors.nightSky,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status: ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Obx(() {
                      final leaveHistory =
                          homeController.studentModel.value?.leaveHistory;

                      if (leaveHistory == null || leaveHistory.isEmpty) {
                        return Text("Not On Leave");
                      }

                      final lastLeave = leaveHistory.reversed.first;

                      final startDate = DateFormat('dd-MM-yyyy')
                          .parse(lastLeave.startDate ?? '');
                      final endDate = DateFormat('dd-MM-yyyy')
                          .parse(lastLeave.endDate ?? '');
                      final today = DateTime.now();

                      bool isOnLeave =
                          today.isAfter(startDate) && today.isBefore(endDate) ||
                              today.isAtSameMomentAs(startDate);

                      return Text(
                        isOnLeave ? "On Leave" : "Not On Leave",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.nightSky,
                        ),
                      );
                    }),
                  ],
                ),
                NameDividerWidget(name: "Leave"),
                SizedBox(
                    height: height * 0.5,
                    child: Obx(
                      () => homeController.studentModel.value == null
                          ? Center(child: const CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: homeController
                                  .studentModel.value?.leaveHistory.length,
                              itemBuilder: (context, index) {
                                LeaveHistory? leaveHistory = homeController
                                    .studentModel.value?.leaveHistory.reversed
                                    .toList()[index];
                                return _buildCardUI(context, height, width,
                                    leaveHistory, index);
                              }),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildCardUI(BuildContext context, double height, double width,
      LeaveHistory? leaveHistory, int index) {
    return Card(
      elevation: 10,
      color: AppColors.aquaPastel,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          height: height * 0.12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Id: ${leaveHistory?.leaveId}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          "${DateFormat('dd-MM-yyyy').parse(leaveHistory?.endDate ?? '').difference(DateFormat('dd-MM-yyyy').parse(leaveHistory?.startDate ?? '')).inDays}",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.08,
                          color: AppColors.nightSky),
                      children: [
                        TextSpan(
                          text: " Day(s)",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                              color: AppColors.nightSky),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Start"),
                      Text(
                        "${leaveHistory?.startDate}",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("End"),
                      Text(
                        "${leaveHistory?.endDate}",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
