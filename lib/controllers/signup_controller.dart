import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import '../services/image_service.dart';
import '../services/student_service.dart';
import '../routes/app_routes.dart';
import '../services/firestore_ref_service.dart';
import '../services/hostel_mess_service.dart';
import '../utils/toast_snack_bar.dart';
import '../utils/logger_util.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreRefService firestoreRefService = FirestoreRefService();

  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool canResendEmail = true.obs;
  Rx<User?> firebaseUser = Rx<User?>(null);

  RxList<Map<String, String>> hostels = <Map<String, String>>[].obs;
  RxString selectedHostelId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    getHostelList();
    AppLogger.i(
        "SignupController ready. Fetching hostel list."); // Log when the controller is ready
  }

  void getHostelList() async {
    hostels.value = await HostelMessService().fetchHostel();
    AppLogger.i(
        "Hostel list fetched: ${hostels.length} hostels available."); // Log fetched hostel list
  }

  Future<void> signup(
      String email, String password, String name, String roll) async {
    isLoading.value = true;
    try {
      AppLogger.i(
          "Signup attempt with email: $email"); // Log the signup attempt

      if (!(email.length < 100 && email.split('@').last == 'nitp.ac.in')) {
        AppSnackBar.error("Use correct College Mail");
        AppLogger.w(
            "Invalid email domain for signup: ${email.split('@').last}"); // Log invalid email domain
        return;
      }

      if (password.length < 6 || password.length > 100) {
        AppSnackBar.error("Password is too long or too short.(>6)");
        AppLogger.w(
            "Password length error: $password.length"); // Log password length error
        return;
      }

      if (name.length > 100) {
        AppSnackBar.error("Name is too large.");
        AppLogger.w("Name length error: $name.length"); // Log name length error
        return;
      }

      if (roll.length > 12) {
        AppSnackBar.error("Roll is not correctly formatted.");
        AppLogger.w("Roll length error: $roll.length"); // Log roll length error
        return;
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value = userCredential.user;
      AppLogger.i(
          "User created: ${firebaseUser.value?.email}"); // Log user creation

      if (firebaseUser.value != null) {
        await firebaseUser.value?.sendEmailVerification();
        AppSnackBar.success(
            "Verification email sent. Please verify your email.");
        AppLogger.i(
            "Verification email sent to ${firebaseUser.value?.email}"); // Log email sent

        final isVerified = await _waitForEmailVerification();
        if (isVerified) {
          String uid = _auth.currentUser!.uid;

          String? imageUrl = '';
          if (imageFile.value != null) {
            String extension = imageFile.value!.path.split('.').last;
            String newFileName = "img_${uid}_$roll.$extension";
            imageUrl = await ImageService()
                .uploadImage(imageFile.value!.path, fileName: newFileName);
          }
          await _createFirestoreUser(name, roll, email, uid, imageUrl);
          AppSnackBar.success("Account created successfully!");
          AppLogger.i(
              "Account created successfully for user: $uid"); // Log successful account creation
          Get.offAllNamed(AppRoutes.getLoginRoute());
        } else {
          AppSnackBar.error("Email not verified. Registration incomplete.");
          AppLogger.w(
              "Email not verified for user: ${firebaseUser.value?.email}"); // Log email verification failure
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
        AppLogger.e(
            "FirebaseAuthException during signup: ${e.message}, Code: ${e.code}"); // Log Firebase error
      } else {
        AppSnackBar.error("An unexpected error occurred.");
        AppLogger.e("Unexpected error during signup: $e"); // Log other errors
      }
    } finally {
      isLoading.value = false;
      AppLogger.i(
          "Signup process completed."); // Log completion of signup process
    }
  }

  Future<void> _createFirestoreUser(String name, String roll, String email,
      String uid, String? imageUrl) async {
    StudentModel studentModel = StudentModel(
        name: name.toString().capitalize,
        rollNo: roll,
        email: email,
        uid: uid,
        profileUrl: imageUrl,
        currentSem: 0,
        isVerified: false,
        status: "deactivated",
        totalCredit: 0,
        leftCredit: 0,
        leftOverCredit: 0,
        currentBal: 0,
        hostel: Hostel(
            id: selectedHostelId.value,
            name: hostels
                .where((hostel) => hostel['id'] == selectedHostelId.value)
                .first['name'],
            roomNumber: ""),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
        createdBy: "user",
        updatedBy: "user",
        topupHistory: [],
        leaveHistory: []);

    await StudentService().addStudent(studentModel);
    AppLogger.i(
        "Firestore user created for UID: $uid"); // Log firestore user creation
  }

  Future<bool> _waitForEmailVerification() async {
    final startTime = DateTime.now();
    while (!(firebaseUser.value?.emailVerified ?? false)) {
      await Future.delayed(const Duration(seconds: 3));
      await firebaseUser.value?.reload();
      firebaseUser.value = _auth.currentUser;
      if (DateTime.now().difference(startTime).inMinutes >= 5) {
        return false;
      }
    }
    AppLogger.i(
        "Email verified successfully within 5 minutes."); // Log email verification success
    return true;
  }

  var imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

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
}
