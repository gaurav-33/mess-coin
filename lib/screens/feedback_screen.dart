import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messcoin/controllers/feedback_controller.dart';
import 'package:messcoin/widgets/rect_button.dart';
import '../controllers/home_controller.dart';
import '../res/app_colors.dart';
import '../widgets/header_widget.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  HomeController homeController = Get.find<HomeController>();
  FeedbackController feedbackController = Get.put(FeedbackController());

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
              "FeedBack",
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                children: [
                  _buildImageUi(context),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: feedbackController.inputController,
                    maxLength: 550,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Type Something...",
                    ),
                  )
                ],
              ),
            ),
            Obx(() => RectButton(
                name: 'Next',
                onTap: () async {
                  await feedbackController.uploadFeedback();
                  Get.back();
                },
                isLoading: feedbackController.isLoading.value))
          ],
        ),
      ),
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
                    child: feedbackController.imageFile.value != null
                        ? Image.file(
                            feedbackController.imageFile.value!,
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
                feedbackController.pickImageFromGallery();
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
                feedbackController.pickImageFromCamera();
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
}
