// import 'package:flutkit/animation/shopping/views/splash_screen2.dart';
// import 'package:flutkit/helpers/utils/my_string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ResetPasswordController extends GetxController {
//   TickerProvider ticker;
//   ResetPasswordController(this.ticker);
//   late TextEditingController confirmPasswordTE, passwordTE;
//   GlobalKey<FormState> formKey = GlobalKey();
//   late AnimationController arrowController,
//       passwordController,
//       resetPasswordController;
//   late Animation<Offset> arrowAnimation,
//       passwordAnimation,
//       resetPasswordAnimation;
//   int passwordCounter = 0;
//   int resetPasswordCounter = 0;
// // Method to reset the password using OTP
//   Future<void> resetPassword() async {
//     var response = await http.post(
//       Uri.parse('https://yourapi.com/api/password/reset'),
//       body: {
//         'email': emailTE.text,
//         'otp': otpTE.text,
//         'password': passwordTE.text,
//         'password_confirmation': confirmPasswordTE.text,
//       },
//     );

//     if (response.statusCode == 200) {
//       Get.snackbar('Success', 'Password reset successfully');
//       Get.offAll(LoginScreen());
//     } else {
//       Get.snackbar('Error', 'Failed to reset password');
//     }
//   }

//   @override
//   void onInit() {
//     confirmPasswordTE = TextEditingController(text: 'password123');
//     passwordTE = TextEditingController(text: 'password');
//     arrowController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));
//     passwordController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 50));
//     resetPasswordController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 50));

//     arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
//         .animate(CurvedAnimation(
//       parent: arrowController,
//       curve: Curves.easeIn,
//     ));
//     passwordAnimation =
//         Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
//             .animate(CurvedAnimation(
//       parent: passwordController,
//       curve: Curves.easeIn,
//     ));
//     resetPasswordAnimation =
//         Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
//             .animate(CurvedAnimation(
//       parent: resetPasswordController,
//       curve: Curves.easeIn,
//     ));

//     passwordController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         passwordController.reverse();
//       }
//       if (status == AnimationStatus.dismissed && passwordCounter < 2) {
//         passwordController.forward();
//         passwordCounter++;
//       }
//     });
//     resetPasswordController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         resetPasswordController.reverse();
//       }
//       if (status == AnimationStatus.dismissed && resetPasswordCounter < 2) {
//         resetPasswordController.forward();
//         resetPasswordCounter++;
//       }
//     });
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     arrowController.dispose();
//     passwordController.dispose();
//     resetPasswordController.dispose();
//     super.dispose();
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

//   String? validateConfirmPassword(String? text) {
//     if (text == null || text.isEmpty) {
//       resetPasswordController.forward();
//       return "Please enter password";
//     } else if (!MyStringUtils.validateStringRange(
//       text,
//     )) {
//       resetPasswordController.forward();
//       return "Password length must between 8 and 20";
//     } else if (passwordTE.text != text) {
//       resetPasswordController.forward();
//       return "Both passwords are not same";
//     }
//     return null;
//   }

//   Future<void> resetPassword() async {
//     resetPasswordCounter = 0;
//     if (formKey.currentState!.validate()) {
//       arrowController.forward();
//       await Future.delayed(Duration(milliseconds: 500));
//       Get.off(SplashScreen2());
//       // Navigator.of(context, rootNavigator: true).pushReplacement(
//       //   MaterialPageRoute(
//       //     builder: (context) => SplashScreen2(),
//       //   ),
//       // );
//     }
//   }
// }
////////////////////////////////////////////////////////

// import 'package:flutkit/animation/shopping/views/splash_screen2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class ResetPasswordController extends GetxController {
//   TickerProvider ticker;
//   ResetPasswordController(this.ticker);

//   GlobalKey<FormState> formKey = GlobalKey();
//   late TextEditingController otpTE, passwordTE, confirmPasswordTE;
//   late AnimationController arrowController, resetPasswordController;
//   late Animation<Offset> arrowAnimation, resetPasswordAnimation;
//   int resetPasswordCounter = 0;

//   @override
//   void onInit() {
//     otpTE = TextEditingController();
//     passwordTE = TextEditingController();
//     confirmPasswordTE = TextEditingController();

//     arrowController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));
//     resetPasswordController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 50));

//     arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
//         .animate(CurvedAnimation(
//       parent: arrowController,
//       curve: Curves.easeIn,
//     ));
//     resetPasswordAnimation =
//         Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
//             .animate(CurvedAnimation(
//       parent: resetPasswordController,
//       curve: Curves.easeIn,
//     ));
//     super.onInit();
//   }

//   // Method to reset the password using OTP
//   Future<void> resetPassword() async {
//     var response = await http.post(
//       Uri.parse('https://yourapi.com/api/password/reset'),
//       body: {
//         'email':
//             emailTE.text, // Use the email from the ForgotPasswordController
//         'otp': otpTE.text, // OTP from the user input
//         'password': passwordTE.text,
//         'password_confirmation': confirmPasswordTE.text,
//       },
//     );

//     if (response.statusCode == 200) {
//       Get.snackbar('Success', 'Password reset successfully');
//       Get.offAll(SplashScreen2()); // Navigate to the home or login screen
//     } else {
//       Get.snackbar('Error', 'Failed to reset password');
//     }
//   }

//   String? validatePassword(String? text) {
//     if (text == null || text.isEmpty) {
//       return "Please enter a password";
//     } else if (text.length < 8) {
//       return "Password must be at least 8 characters";
//     }
//     return null;
//   }

//   String? validateConfirmPassword(String? text) {
//     if (text == null || text.isEmpty) {
//       return "Please confirm your password";
//     } else if (passwordTE.text != text) {
//       return "Passwords do not match";
//     }
//     return null;
//   }

//   @override
//   void dispose() {
//     arrowController.dispose();
//     resetPasswordController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutkit/animation/shopping/views/splash_screen2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class ResetPasswordController extends GetxController {
//   // TickerProvider is required for animations
//   TickerProvider ticker;
//   String email; // Add email to store passed value
//   ResetPasswordController(
//       this.ticker, this.email); // Modify constructor to accept email

//   // Constructor for initializing the ticker
//   // ResetPasswordController(this.ticker);

//   // Form key for form validation
//   GlobalKey<FormState> formKey = GlobalKey();

//   // Text Editing Controllers for OTP, Password, and Confirm Password fields
//   late TextEditingController otpTE, passwordTE, confirmPasswordTE;

//   // Animation Controllers for handling transitions
//   late AnimationController arrowController, resetPasswordController;

//   // Animations for arrow and reset password fields
//   late Animation<Offset> arrowAnimation,
//       resetPasswordAnimation,
//       passwordAnimation;

//   // Counter for reset password animation
//   int resetPasswordCounter = 0;

//   @override
//   void onInit() {
//     // Initializing the TextEditingControllers
//     otpTE = TextEditingController();
//     passwordTE = TextEditingController();
//     confirmPasswordTE = TextEditingController();

//     // Initializing AnimationControllers
//     arrowController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));
//     resetPasswordController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 50));

//     // Defining arrow animation
//     arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
//         .animate(CurvedAnimation(
//       parent: arrowController,
//       curve: Curves.easeIn,
//     ));

//     // Defining reset password animation
//     resetPasswordAnimation =
//         Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
//             .animate(CurvedAnimation(
//       parent: resetPasswordController,
//       curve: Curves.easeIn,
//     ));

//     super.onInit();
//   }

//   // Method to reset the password using OTP
//   Future<void> resetPassword() async {
//     // Sending HTTP POST request to reset password API
//     var response = await http.post(
//       Uri.parse('http://192.168.1.5:8000/api/password/reset'),
//       body: {
//         'email':
//             email, // Use the email from the ForgotPasswordController (not defined here)
//         'otp': otpTE.text, // OTP from the user input
//         'password': passwordTE.text, // New password entered by the user
//         'password_confirmation': confirmPasswordTE
//             .text, // Confirmation of the new password entered by the user
//       },
//     );

//     // Handling the response from the server
//     if (response.statusCode == 200) {
//       // Showing success message and navigating to a new screen
//       Get.snackbar('Success', 'Password reset successfully');
//       Get.offAll(SplashScreen2()); // Navigate to home or login screen
//     } else {
//       // Showing error message in case of failure
//       Get.snackbar('Error', 'Failed to reset password');
//     }
//   }

//   // Validator for Password field
//   String? validatePassword(String? text) {
//     if (text == null || text.isEmpty) {
//       // Trigger validation if the field is empty
//       return "Please enter a password";
//     } else if (text.length < 8) {
//       // Ensure password length is at least 8 characters
//       return "Password must be at least 8 characters";
//     }
//     return null; // Return null if validation passes
//   }

//   // Validator for Confirm Password field
//   String? validateConfirmPassword(String? text) {
//     if (text == null || text.isEmpty) {
//       // Trigger validation if the field is empty
//       return "Please confirm your password";
//     } else if (passwordTE.text != text) {
//       // Ensure both passwords match
//       return "Passwords do not match";
//     }
//     return null; // Return null if validation passes
//   }

//   // Dispose controllers when they are no longer needed to free up resources
//   @override
//   void dispose() {
//     arrowController.dispose();
//     resetPasswordController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutkit/animation/shopping/views/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  final String otp;

  // TickerProvider is required for animations
  TickerProvider ticker;
  String email; // Add email to store passed value
  ResetPasswordController(this.ticker, this.email, this.otp);

  // Form key for form validation
  GlobalKey<FormState> formKey = GlobalKey();

  // Text Editing Controllers for OTP, Password, and Confirm Password fields
  late TextEditingController otpTE, passwordTE, confirmPasswordTE;

  // Animation Controllers for handling transitions
  late AnimationController arrowController,
      passwordController,
      resetPasswordController;

  // Animations for arrow, password, and reset password fields
  late Animation<Offset> arrowAnimation,
      passwordAnimation,
      resetPasswordAnimation;

  // Counter for reset password animation
  int resetPasswordCounter = 0;

  @override
  void onInit() {
    // Initializing the TextEditingControllers
    otpTE = TextEditingController();
    passwordTE = TextEditingController();
    confirmPasswordTE = TextEditingController();

    // Initializing AnimationControllers
    arrowController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));
    passwordController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));
    resetPasswordController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));

    // Defining arrow animation
    arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
        .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));

    // Defining password animation
    passwordAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
      curve: Curves.easeIn,
    ));

    // Defining reset password animation
    resetPasswordAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: resetPasswordController,
      curve: Curves.easeIn,
    ));

    super.onInit();
  }

  // Method to reset the password using OTP
  Future<void> resetPassword() async {
    // Sending HTTP POST request to reset password API
    var response = await http.post(
      Uri.parse('http://192.168.1.5:8000/api/password/reset'),
      body: {
        'email':
            email, // Use the email from the ForgotPasswordController (not defined here)
        'otp': otp, // OTP from the user input
        'password': passwordTE.text, // New password entered by the user
        'password_confirmation': confirmPasswordTE
            .text, // Confirmation of the new password entered by the user
      },
    );

    // Handling the response from the server
    if (response.statusCode == 200) {
      // Showing success message and navigating to a new screen
      Get.snackbar('Success', 'Password reset successfully');
      Get.offAll(LogInScreen()); // Navigate to home or login screen
    } else {
      // Showing error message in case of failure
      Get.snackbar('Error', 'Failed to reset password');
    }
  }

  // Validator for Password field
  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      // Trigger validation if the field is empty
      return "Please enter a password";
    } else if (text.length < 8) {
      // Ensure password length is at least 8 characters
      return "Password must be at least 8 characters";
    }
    return null; // Return null if validation passes
  }

  // Validator for Confirm Password field
  String? validateConfirmPassword(String? text) {
    if (text == null || text.isEmpty) {
      // Trigger validation if the field is empty
      return "Please confirm your password";
    } else if (passwordTE.text != text) {
      // Ensure both passwords match
      return "Passwords do not match";
    }
    return null; // Return null if validation passes
  }

  // Dispose controllers when they are no longer needed to free up resources
  @override
  void dispose() {
    arrowController.dispose();
    passwordController.dispose();
    resetPasswordController.dispose();
    super.dispose();
  }
}
