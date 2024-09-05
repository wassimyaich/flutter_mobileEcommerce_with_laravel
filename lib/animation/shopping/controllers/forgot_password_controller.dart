import 'package:flutkit/animation/shopping/views/register_screen.dart';
import 'package:flutkit/animation/shopping/views/reset_password_screen.dart';
import 'package:flutkit/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TickerProvider ticker;
  ForgotPasswordController(this.ticker);
  late TextEditingController emailTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController, emailController;
  late Animation<Offset> arrowAnimation, emailAnimation;
  int emailCounter = 0;

  @override
  void onInit() {
    emailTE = TextEditingController(text: 'flutkit@coderthemes.com');
    arrowController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));

    arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
        .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    emailController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    arrowController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Please enter email";
    } else if (!MyStringUtils.isEmail(text)) {
      emailController.forward();
      return "Please enter valid email";
    }
    return null;
  }

  Future<void> goToResetPasswordScreen() async {
    emailCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(Duration(milliseconds: 500));
      Get.off(ResetPasswordScreen());
      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => ResetPasswordScreen(),
      //   ),
      // );
    }
  }

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => RegisterScreen(),
    //   ),
    // );
  }
}
