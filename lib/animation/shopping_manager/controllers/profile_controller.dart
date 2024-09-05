import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutkit/animation/shopping/views/login_screen.dart';

enum ShopStatus { close, open }

class ProfileController extends GetxController {
  late ShopStatus shopStatus;

  ProfileController() {
    shopStatus = ShopStatus.open;
  }

  void changeShopStatus(ShopStatus shopStatus) {
    this.shopStatus = shopStatus;
    update();
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
