import 'package:get/get.dart';
import '../services/hostel_mess_service.dart';

class HostelController extends GetxController {
  RxList<Map<String, String>> hostels = <Map<String, String>>[].obs;
  RxString selectedHostelId = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getHostelList();
    super.onInit();
  }

  void getHostelList() async {
    isLoading.value = !isLoading.value;
    hostels.value = await HostelMessService().fetchHostel();
    isLoading.value = false;
  }
}
