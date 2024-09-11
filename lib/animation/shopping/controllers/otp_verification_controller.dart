import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutkit/animation/shopping/views/reset_password_screen.dart';

class OTPVerificationController extends GetxController {
  final String email;
  var otpCode = ''.obs;
  var error = ''.obs;

  OTPVerificationController({required this.email});
  // Method to verify OTP
  Future<void> verifyOTP() async {
    // Clear previous error
    error.value = '';

    // Check if OTP is provided
    if (otpCode.value.isEmpty) {
      error.value = 'Please enter the OTP code';
      return;
    }

    // Replace with your API URL
    final url = 'http://192.168.137.146:8000/api/verify-otp';

    try {
      // Make a POST request to verify OTP
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email, 'otp': otpCode.value},
      );

      if (response.statusCode == 200) {
        // OTP verified successfully
        Get.snackbar('Success', 'OTP verified successfully');
        Get.to(() => ResetPasswordScreen(email: email, otp: otpCode.value));

        // Navigate to the next screen or perform another action
      } else {
        // Handle error from server
        error.value = 'Invalid OTP code';
      }
    } catch (e) {
      // Handle network or other errors
      error.value = 'An error occurred. Please try again.';
    }
  }
}
