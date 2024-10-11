import 'dart:developer';

import 'package:flutkit/animation/shopping/views/login_screen.dart';
import 'package:flutkit/animation/shopping/views/splash_screen2.dart';
import 'package:flutkit/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart'; // Import your AuthService
// import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  TickerProvider ticker;
  RegisterController(this.ticker);
  late TextEditingController nameTE, emailTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController,
      nameController,
      emailController,
      passwordController;
  late Animation<Offset> arrowAnimation,
      nameAnimation,
      emailAnimation,
      passwordAnimation;
  int nameCounter = 0;
  int emailCounter = 0;
  int passwordCounter = 0;
  final AuthService authService =
      AuthService(); // Create an instance of AuthService
  @override
  void onInit() {
    nameTE = TextEditingController();
    emailTE = TextEditingController();
    passwordTE = TextEditingController();

    arrowController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));
    nameController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));
    emailController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));
    passwordController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));

    arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
        .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    nameAnimation = Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
        .animate(CurvedAnimation(
      parent: nameController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    passwordAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
      curve: Curves.easeIn,
    ));

    nameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        nameController.reverse();
      }
      if (status == AnimationStatus.dismissed && nameCounter < 2) {
        nameController.forward();
        nameCounter++;
      }
    });
    emailController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
    passwordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        passwordController.reverse();
      }
      if (status == AnimationStatus.dismissed && passwordCounter < 2) {
        passwordController.forward();
        passwordCounter++;
      }
    });
    super.onInit();
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

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      passwordController.forward();

      return "Please enter password";
    } else if (!MyStringUtils.validateStringRange(
      text,
    )) {
      passwordController.forward();

      return "Password length must between 8 and 20";
    }
    return null;
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      nameController.forward();
      return "Please enter name";
    } else if (!MyStringUtils.validateStringRange(text, 4, 20)) {
      nameController.forward();
      return "Password length must between 4 and 20";
    }
    return null;
  }

  @override
  void dispose() {
    arrowController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    passwordCounter = 0;
    nameCounter = 0;
    emailCounter = 0;

    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(Duration(milliseconds: 500));

      try {
        // Call the AuthService register method
        final response = await authService.register(
          nameTE.text,
          emailTE.text,
          passwordTE.text,
        );

        // Check if the response is not null
        if (response != null) {
          // Registration successful, navigate to the splash screen
          print(
              'User: ${response['user'].name}'); // Accessing user name correctly
          print('Token: ${response['token']}'); // Accessing token correctly

          SharedPreferences preferences = await SharedPreferences.getInstance();

          // Store user data and token in SharedPreferences
          await preferences.setString('name', response['user'].name);
          await preferences.setString('email', response['user'].email);
          await preferences.setString(
              'token', response['token']); // Store the token

          Get.off(SplashScreen2());
        } else {
          // Handle registration failure (optional)
          Get.snackbar('Registration Failed', 'Please try again.');
        }
      } catch (e) {
        // Handle exceptions and show error message
        Get.snackbar('Error', e.toString());
      }
    }
  }

  void goToLogInScreen() {
    Get.off(LogInScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => LogInScreen(),
    //   ),
    // );
  }
}
