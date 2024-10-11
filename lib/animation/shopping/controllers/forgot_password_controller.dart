
import 'package:flutkit/animation/shopping/views/OTPVerificationScreen.dart';
import 'package:flutkit/animation/shopping/controllers/MyStringUtils.dart';
// import 'package:flutkit/animation/shopping/views/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutkit/animation/shopping/views/register_screen.dart';

class ForgotPasswordController extends GetxController {
  TickerProvider ticker;
  ForgotPasswordController(this.ticker);

  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController emailTE;
  late AnimationController arrowController, emailController;
  late Animation<Offset> arrowAnimation, emailAnimation;
  int emailCounter = 0;

  @override
  void onInit() {
    emailTE = TextEditingController();
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

  // Method to send reset code (OTP)
  Future<void> sendResetCode() async {
    if (formKey.currentState!.validate()) {
      var response = await http.post(
        Uri.parse('http://192.168.1.5:8000/api/forgot-password/email'),
        body: {'email': emailTE.text},
      );

      if (response.statusCode == 200) {
        // Pass the email to OTPVerificationScreen
        Get.to(() => OTPVerificationScreen(email: emailTE.text));
      } else {
        Get.snackbar('Error', 'Failed to send reset code');
      }
    }
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Please enter email";
    }
    // Assuming MyStringUtils.isEmail checks for valid email
    else if (!MyStringUtils.isEmail(text)) {
      emailController.forward();
      return "Please enter a valid email";
    }
    return null;
  }

  @override
  void dispose() {
    arrowController.dispose();
    emailController.dispose();
    emailTE.dispose();
    super.dispose();
  }

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
  }

  Future<void> goToResetPasswordScreen() async {
    // if (formKey.currentState!.validate()) {
    //   Get.to(() => ResetPasswordScreen(email: emailTE.text));
    // }
  }
}
