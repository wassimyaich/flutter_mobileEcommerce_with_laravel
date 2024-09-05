import 'package:flutkit/animation/shopping/views/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutkit/animation/shopping/views/login_screen.dart';

class ProfileController extends GetxController {
  bool showLoading = true, uiLoading = true;

  @override
  void onInit() {
    fetchData();

    super.onInit();
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }

  void goToSubscription() {
    Get.to(SubscriptionScreen());
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => SubscriptionScreen(),
    //   ),
    // );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will remove all stored preferences

    // Navigate to the LogInScreen and replace the current route
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LogInScreen()),
    );
  }
}
