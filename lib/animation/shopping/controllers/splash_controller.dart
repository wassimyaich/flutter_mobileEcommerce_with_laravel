import 'package:flutkit/animation/shopping/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  TickerProvider ticker;
  SplashController(this.ticker);
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: ticker,
    );
    animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
    super.onInit();
  }

  void goToLoginScreen() async {
    // animationController.forward();
    // await Future.delayed(Duration(milliseconds: 500));
    await Get.to(duration: Duration(microseconds: 500), LogInScreen());
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => LogInScreen(),
    //   ),
    // );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
