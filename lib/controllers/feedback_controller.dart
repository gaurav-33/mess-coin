import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../models/feedback_model.dart';
import '../services/firestore_ref_service.dart';
import '../services/image_service.dart';
import '../utils/toast_snack_bar.dart';

class FeedbackController extends GetxController {
  var imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxBool isLoading = false.obs;
  TextEditingController inputController = TextEditingController();
  HomeController homeController = Get.find<HomeController>();

  Future<void> pickImageFromGallery() async {
    try {
      XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> uploadFeedback() async {
    try {
      String hostelId = homeController.hostelId;
      String hostelName = homeController.studentModel.value?.hostel?.name ?? "";
      String studentName = homeController.studentModel.value?.name ?? "";
      String studentRollNo = homeController.studentModel.value?.rollNo ?? "";
      isLoading.value = true;
      CollectionReference feedbackRef = FirestoreRefService().getCollectionRef<
              FeedBackModel>(
          basePath:
              'hmc/$hostelId/feedback/document/${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
          fromJson: (json) => FeedBackModel.fromJson(json),
          toJson: (data) => data.toJson());
      String? imageUrl = '';
      if (imageFile.value != null) {
        String extension = imageFile.value!.path.split('.').last;
        String newFileName =
            "feedback_${DateTime.now().millisecondsSinceEpoch}.$extension";
        imageUrl = await ImageService()
            .uploadImage(imageFile.value!.path, fileName: newFileName);
      }

      DateTime dateTime = DateTime.now();
      String rollNo =
          Get.find<HomeController>().studentModel.value?.rollNo ?? "";
      FeedBackModel feedBackModel = FeedBackModel(
          hostelId: hostelId,
          hostelName: hostelName,
          studentName: studentName,
          studentRollNo: studentRollNo,
          imageUrl: imageUrl ?? '',
          query: inputController.text.trim().toString(),
          createdAt: dateTime.toIso8601String());
      if (inputController.text.isNotEmpty) {
        await feedbackRef
            .doc("fd_${dateTime.microsecondsSinceEpoch}$rollNo")
            .set(feedBackModel);
        inputController.clear();
        imageFile.value = null;
        AppSnackBar.success("Feedback submitted Successfully.");
      }
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
