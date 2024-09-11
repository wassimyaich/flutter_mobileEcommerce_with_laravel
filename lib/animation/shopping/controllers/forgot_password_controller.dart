// import 'package:flutkit/animation/shopping/views/register_screen.dart';
// import 'package:flutkit/animation/shopping/views/reset_password_screen.dart';
// import 'package:flutkit/helpers/utils/my_string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class ForgotPasswordController extends GetxController {
//   TickerProvider ticker;
//   ForgotPasswordController(this.ticker);
//   // late TextEditingController emailTE;
//   GlobalKey<FormState> formKey = GlobalKey();
//   late AnimationController arrowController, emailController;
//   late Animation<Offset> arrowAnimation, emailAnimation;
//   int emailCounter = 0;

// ////////////////////////////////////////
//   late TextEditingController emailTE, otpTE, passwordTE, confirmPasswordTE;

//   // Method to send reset code to email
//   Future<void> sendResetCode() async {
//     if (formKey.currentState!.validate()) {
//       // Make API call to Laravel to send the OTP
//       var response = await http.post(
//         Uri.parse('https://yourapi.com/api/forgot-password/email'),
//         body: {'email': emailTE.text},
//       );

//       if (response.statusCode == 200) {
//         Get.to(OTPVerificationScreen());
//       } else {
//         Get.snackbar('Error', 'Failed to send reset code');
//       }
//     }
//   }

// ///////////////////////////////////////
//   @override
//   void onInit() {
//     emailTE = TextEditingController(text: 'flutkit@coderthemes.com');
//     arrowController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));
//     emailController = AnimationController(
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
//     emailController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         emailController.reverse();
//       }
//       if (status == AnimationStatus.dismissed && emailCounter < 2) {
//         emailController.forward();
//         emailCounter++;
//       }
//     });
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     arrowController.dispose();
//     emailController.dispose();
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

//   Future<void> goToResetPasswordScreen() async {
//     emailCounter = 0;
//     if (formKey.currentState!.validate()) {
//       arrowController.forward();
//       await Future.delayed(Duration(milliseconds: 500));
//       Get.off(ResetPasswordScreen());
//       // Navigator.of(context, rootNavigator: true).pushReplacement(
//       //   MaterialPageRoute(
//       //     builder: (context) => ResetPasswordScreen(),
//       //   ),
//       // );
//     }
//   }

//   void goToRegisterScreen() {
//     Get.off(RegisterScreen());
//     // Navigator.of(context, rootNavigator: true).pushReplacement(
//     //   MaterialPageRoute(
//     //     builder: (context) => RegisterScreen(),
//     //   ),
//     // );
//   }
// }
// import 'package:flutkit/animation/shopping/views/OTPVerificationScreen.dart';
// import 'package:flutkit/animation/shopping/controllers/MyStringUtils.dart';
// import 'package:flutkit/animation/shopping/views/reset_password_screen.dart';
// // import 'package:flutkit/helpers/utils/my_string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // C:\flutter\src\newapp\flutkit\lib\animation\shopping\controllers\
// import 'package:http/http.dart' as http;
// import 'package:flutkit/animation/shopping/views/register_screen.dart';

// class ForgotPasswordController extends GetxController {
//   TickerProvider ticker;
//   ForgotPasswordController(this.ticker);

//   GlobalKey<FormState> formKey = GlobalKey();
//   late TextEditingController emailTE;
//   late AnimationController arrowController, emailController;
//   late Animation<Offset> arrowAnimation, emailAnimation;
//   int emailCounter = 0;

//   @override
//   void onInit() {
//     emailTE = TextEditingController();
//     arrowController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));
//     emailController = AnimationController(
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
//     emailController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         emailController.reverse();
//       }
//       if (status == AnimationStatus.dismissed && emailCounter < 2) {
//         emailController.forward();
//         emailCounter++;
//       }
//     });
//     super.onInit();
//   }

//   // Method to send reset code (OTP)
//   Future<void> sendResetCode() async {
//     if (formKey.currentState!.validate()) {
//       var response = await http.post(
//         Uri.parse('https://yourapi.com/api/forgot-password/email'),
//         body: {'email': emailTE.text},
//       );

//       if (response.statusCode == 200) {
//         Get.to(() => OTPVerificationScreen()); // Navigate to OTP screen
//       } else {
//         Get.snackbar('Error', 'Failed to send reset code');
//       }
//     }
//   }

//   String? validateEmail(String? text) {
//     if (text == null || text.isEmpty) {
//       emailController.forward();
//       return "Please enter email";
//     }
//     // Assuming MyStringUtils.isEmail checks for valid email
//     else if (!MyStringUtils.isEmail(text)) {
//       emailController.forward();
//       return "Please enter valid email";
//     }
//     return null;
//   }

//   @override
//   void dispose() {
//     arrowController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   void goToRegisterScreen() {
//     Get.off(RegisterScreen());
//     // Navigator.of(context, rootNavigator: true).pushReplacement(
//     //   MaterialPageRoute(
//     //     builder: (context) => RegisterScreen(),
//     //   ),
//     // );
//   }

//   Future<void> goToResetPasswordScreen() async {
//     emailCounter = 0;
//     if (formKey.currentState!.validate()) {
//       arrowController.forward();
//       await Future.delayed(Duration(milliseconds: 500));
//       // Get.off(ResetPasswordScreen());
//       Get.to(() => ResetPasswordScreen(email: emailTE.text));

//       // Navigator.of(context, rootNavigator: true).pushReplacement(
//       //   MaterialPageRoute(
//       //     builder: (context) => ResetPasswordScreen(),
//       //   ),
//       // );
//     }
//   }
// }

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
