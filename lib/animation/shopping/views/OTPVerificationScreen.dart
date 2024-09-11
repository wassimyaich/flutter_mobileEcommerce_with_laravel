import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutkit/animation/shopping/controllers/otp_verification_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String email;
  final OTPVerificationController controller;

  OTPVerificationScreen({required this.email})
      : controller = Get.put(OTPVerificationController(email: email));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP code you received:',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Obx(() {
              return TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'OTP Code',
                  hintText: '123456',
                  errorText: controller.error.value,
                ),
                onChanged: (value) {
                  controller.otpCode.value = value;
                },
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.verifyOTP();
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
