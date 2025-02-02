import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/hostel_controller.dart';
import '../../routes/app_routes.dart';
import '../../shared/hostel_id_preferences.dart';
import '../../utils/toast_snack_bar.dart';
import '../../res/app_colors.dart';
import '../../widgets/rect_button.dart';

class SelectHostelScreen extends StatelessWidget {
  SelectHostelScreen({super.key});

  HostelController hostelController = Get.put(HostelController());
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
              "Choose Hostel",
              style: TextStyle(
                fontFamily: "Valorax",
                fontSize: width * 0.08,
                fontWeight: FontWeight.w500,
                color: AppColors.nightSky,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildHostelDropDownUI(),
            const SizedBox(
              height: 20,
            ),
            RectButton(child: Obx(() {
              return hostelController.isLoading.value
                  ? CircularProgressIndicator(
                      color: AppColors.aquaPastel,
                    )
                  : Text(
                      "Next",
                      style: TextStyle(
                          color: AppColors.aquaPastel,
                          fontSize: 20,
                          fontFamily: "Aquire"),
                    );
            }), onTap: () {
              if (hostelController.selectedHostelId.value == null) {
                AppSnackBar.error("Choose Hostel First.");
              } else {
                HostelIdPreferences.saveHostelId(
                    hostelController.selectedHostelId.value);
                Get.offAllNamed(AppRoutes.getHomeRoute(), arguments: {
                  'hostel_id': hostelController.selectedHostelId.value
                });
              }
            }),
          ],
        ),
      ),
    );
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
              if (hostelController.hostels.isEmpty) {
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
                value: hostelController.selectedHostelId.value.isEmpty
                    ? null
                    : hostelController.selectedHostelId.value,
                hint: const Text("Choose Mess"),
                items: hostelController.hostels.map((hostel) {
                  return DropdownMenuItem(
                      value: hostel['id'], child: Text(hostel['name'] ?? ''));
                }).toList(),
                onChanged: (selectedId) {
                  hostelController.selectedHostelId.value = selectedId!;
                },
              );
            }),
          ),
        ),
      ]),
    );
  }
}
