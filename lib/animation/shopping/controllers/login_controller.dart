// import 'package:flutkit/animation/shopping/views/forgot_password_screen.dart';
// import 'package:flutkit/animation/shopping/views/register_screen.dart';
// import 'package:flutkit/animation/shopping/views/splash_screen2.dart';
// import 'package:flutkit/helpers/utils/my_string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:http/http.dart' as http;
// import '../models/user.dart';

// class LogInController extends GetxController {
//   TickerProvider ticker;
//   LogInController(this.ticker);
//   late TextEditingController emailTE, passwordTE;
//   GlobalKey<FormState> formKey = GlobalKey();
//   late AnimationController arrowController, emailController, passwordController;
//   late Animation<Offset> arrowAnimation, emailAnimation, passwordAnimation;
//   int emailCounter = 0;
//   int passwordCounter = 0;

//   @override
//   void onInit() {
//     emailTE = TextEditingController(text: 'flutkit@coderthemes.com');
//     passwordTE = TextEditingController(text: 'password');
//     arrowController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));
//     emailController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 50));
//     passwordController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 50));

//     arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
//         .animate(CurvedAnimation(
//       parent: arrowController,
//       curve: Curves.easeIn,
//     ));
//     emailAnimation =
//         Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
//             .animate(CurvedAnimation(
//       parent: emailController,
//       curve: Curves.easeIn,
//     ));
//     passwordAnimation =
//         Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
//             .animate(CurvedAnimation(
//       parent: passwordController,
//       curve: Curves.easeIn,
//     ));

//     emailController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         emailController.reverse();
//       }
//       if (status == AnimationStatus.dismissed && emailCounter < 2) {
//         emailController.forward();
//         emailCounter++;
//       }
//     });

//     passwordController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         passwordController.reverse();
//       }
//       if (status == AnimationStatus.dismissed && passwordCounter < 2) {
//         passwordController.forward();
//         passwordCounter++;
//       }
//     });
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     arrowController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   String? validateEmail(String? text) {
//     if (text == null || text.isEmpty) {
//       emailController.forward();
//       return "Please enter email";
//     } else if (!MyStringUtils.isEmail(text)) {
//       emailController.forward();
//       return "Please enter valid email";
//     }
//     return null;
//   }

//   String? validatePassword(String? text) {
//     if (text == null || text.isEmpty) {
//       passwordController.forward();

//       return "Please enter password";
//     } else if (!MyStringUtils.validateStringRange(
//       text,
//     )) {
//       passwordController.forward();
//       return "Password length must between 8 and 20";
//     }
//     return null;
//   }

//   void goToForgotPasswordScreen() {
//     Get.off(ForgotPasswordScreen());
//   }

//   Future<void> login() async {
//     emailCounter = 0;
//     passwordCounter = 0;
//     if (formKey.currentState!.validate()) {
//       arrowController.forward();
//       await Future.delayed(Duration(milliseconds: 1000));
//       Get.off(SplashScreen2());
//     }
//   }

//   void goToRegisterScreen() {
//     Get.off(RegisterScreen());
//   }
// }
// import 'dart:convert';
import 'package:flutkit/animation/shopping/views/forgot_password_screen.dart';
import 'package:flutkit/animation/shopping/views/register_screen.dart';
import 'package:flutkit/animation/shopping/views/splash_screen2.dart';
import 'package:flutkit/helpers/utils/my_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart'; // Import the AuthService
import 'package:flutkit/animation/shopping_manager/views/full_app.dart';

class LogInController extends GetxController {
  TickerProvider ticker;
  LogInController(this.ticker);
  late TextEditingController emailTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController, emailController, passwordController;
  late Animation<Offset> arrowAnimation, emailAnimation, passwordAnimation;
  int emailCounter = 0;
  int passwordCounter = 0;

  final AuthService authService =
      AuthService(); // Create an instance of AuthService

  @override
  void onInit() {
    emailTE = TextEditingController(text: 'test@gmail.com');
    passwordTE = TextEditingController(text: '123456789');
    arrowController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));
    passwordController = AnimationController(
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
    passwordAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
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

  @override
  void dispose() {
    arrowController.dispose();
    emailController.dispose();
    passwordController.dispose();
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

  void goToForgotPasswordScreen() {
    Get.off(ForgotPasswordScreen());
  }

  // Future<void> login() async {
  //   emailCounter = 0;
  //   passwordCounter = 0;
  //   if (formKey.currentState!.validate()) {
  //     arrowController.forward();
  //     await Future.delayed(Duration(milliseconds: 1000));

  //     try {
  //       // Call the login method from AuthService
  //       final response = await authService.login(emailTE.text, passwordTE.text);

  //       // Handle successful login
  //       if (response != null) {
  //         print('User: ${response['user']}');
  //         print('Token: ${response['token']}');
  //         SharedPreferences preferences = await SharedPreferences.getInstance();
  //         await preferences.setInt('user_id', response['user']['id']);
  //         await preferences.setString('name', response['user']['name']);
  //         await preferences.setString('email', response['user']['email']);
  //         await preferences.setString('token', response['token']);
  //         // Navigate to the splash screen or wherever you want to go after login
  //         Get.off(SplashScreen2());
  //       }
  //     } catch (e) {
  //       // Handle login failure (e.g., show a dialog or a snackbar)
  //       Get.snackbar('Login Failed', e.toString(),
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   }
  // }
  Future<void> login() async {
    emailCounter = 0;
    passwordCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(Duration(milliseconds: 1000));

      try {
        // Call the login method from AuthService
        final response = await authService.login(emailTE.text, passwordTE.text);

        // Handle successful login
        if (response != null) {
          print('User: ${response['user']}');
          print('Token: ${response['token']}');
          print('role: ${response['role']}');

          print('Role: ${response['user']['role']}');

          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setInt('user_id', response['user']['id']);
          await preferences.setString('name', response['user']['name']);
          await preferences.setString('email', response['user']['email']);
          await preferences.setString('token', response['token']);
          await preferences.setString('roletest', response['role']);

          // Check the user's role and navigate accordingly
          String userRole = response['role'];
          if (userRole == 'user') {
            // Regular user
            Get.off(SplashScreen2());
          } else if (userRole == 'admin') {
            // Admin
            Get.off(ShoppingManagerFullApp());
          } else {
            // Handle unexpected role
            Get.snackbar('Login Failed', 'Unexpected user role',
                snackPosition: SnackPosition.BOTTOM);
          }
        }
      } catch (e) {
        // Handle login failure (e.g., show a dialog or a snackbar)
        Get.snackbar('Login Failed', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
  }
}
