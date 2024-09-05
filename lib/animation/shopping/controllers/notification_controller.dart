import 'package:get/get.dart';

class NotificationController extends GetxController {
  bool showLoading = true, uiLoading = true;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }
}
