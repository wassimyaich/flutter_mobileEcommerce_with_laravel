// import 'package:flutkit/animation/shopping/controllers/reset_password_controller.dart';
// import 'package:flutkit/helpers/theme/app_theme.dart';
// import 'package:flutkit/helpers/widgets/my_button.dart';
// import 'package:flutkit/helpers/widgets/my_spacing.dart';
// import 'package:flutkit/helpers/widgets/my_text.dart';
// import 'package:flutkit/helpers/widgets/my_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   const ResetPasswordScreen({Key? key}) : super(key: key);

//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen>
//     with TickerProviderStateMixin {
//   late ThemeData theme;
//   late ResetPasswordController controller;
//   late OutlineInputBorder outlineInputBorder;

//   @override
//   void initState() {
//     super.initState();
//     theme = AppTheme.shoppingTheme;

//     controller = ResetPasswordController(this);
//     outlineInputBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4)),
//       borderSide: BorderSide(
//         color: Colors.transparent,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ResetPasswordController>(
//         init: controller,
//         tag: 'reset_password_controller',
//         builder: (controller) {
//           return Theme(
//             data: theme.copyWith(
//                 colorScheme: theme.colorScheme.copyWith(
//                     secondary: theme.colorScheme.primary.withAlpha(40))),
//             child: _buildBody(),
//           );
//         });
//   }

//   Widget _buildBody() {
//     return Scaffold(
//       body: ListView(
//         padding:
//             MySpacing.fromLTRB(20, MySpacing.safeAreaTop(context) + 48, 20, 20),
//         children: [
//           MyText.displaySmall(
//             'Reset Password',
//             fontWeight: 700,
//             textAlign: TextAlign.center,
//           ),
//           MySpacing.height(20),
//           MyText.bodyMedium(
//             'Don\'t worry! \nNow you can reset your password easily',
//             muted: true,
//             textAlign: TextAlign.center,
//           ),
//           MySpacing.height(32),
//           Form(
//             key: controller.formKey,
//             child: Column(
//               children: [
//                 SlideTransition(
//                   position: controller.passwordAnimation,
//                   child: TextFormField(
//                     style: MyTextStyle.bodyMedium(),
//                     decoration: InputDecoration(
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         filled: true,
//                         isDense: true,
//                         fillColor: theme.cardTheme.color,
//                         prefixIcon: Icon(
//                           LucideIcons.lock,
//                           color: theme.colorScheme.onBackground,
//                         ),
//                         hintText: "Password",
//                         enabledBorder: outlineInputBorder,
//                         focusedBorder: outlineInputBorder,
//                         border: outlineInputBorder,
//                         contentPadding: MySpacing.all(16),
//                         hintStyle: MyTextStyle.bodyMedium(),
//                         isCollapsed: true),
//                     maxLines: 1,
//                     controller: controller.passwordTE,
//                     validator: controller.validatePassword,
//                     cursorColor: theme.colorScheme.onBackground,
//                   ),
//                 ),
//                 MySpacing.height(20),
//                 SlideTransition(
//                   position: controller.resetPasswordAnimation,
//                   child: TextFormField(
//                     style: MyTextStyle.bodyMedium(),
//                     decoration: InputDecoration(
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         filled: true,
//                         isDense: true,
//                         fillColor: theme.cardTheme.color,
//                         prefixIcon: Icon(
//                           LucideIcons.lock,
//                           color: theme.colorScheme.onBackground,
//                         ),
//                         hintText: "Confirm Password",
//                         enabledBorder: outlineInputBorder,
//                         focusedBorder: outlineInputBorder,
//                         border: outlineInputBorder,
//                         contentPadding: MySpacing.all(16),
//                         hintStyle: MyTextStyle.bodyMedium(),
//                         isCollapsed: true),
//                     maxLines: 1,
//                     controller: controller.confirmPasswordTE,
//                     validator: controller.validateConfirmPassword,
//                     cursorColor: theme.colorScheme.onBackground,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           MySpacing.height(20),
//           MyButton.block(
//             elevation: 0,
//             borderRadiusAll: 4,
//             onPressed: () {
//               controller.resetPassword();
//             },
//             splashColor: theme.colorScheme.onPrimary.withAlpha(30),
//             backgroundColor: theme.colorScheme.primary,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MyText.labelLarge(
//                   "Reset Password",
//                   fontWeight: 600,
//                   color: theme.colorScheme.onPrimary,
//                   letterSpacing: 0.4,
//                 ),
//                 MySpacing.width(8),
//                 SlideTransition(
//                     position: controller.arrowAnimation,
//                     child: Icon(
//                       LucideIcons.arrowRight,
//                       color: theme.colorScheme.onPrimary,
//                       size: 20,
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutkit/animation/shopping/controllers/reset_password_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email; // Add the email parameter here
  final String otp;

  const ResetPasswordScreen({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key); // Required email in constructor

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late ResetPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = ResetPasswordController(this, widget.email, widget.otp);
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
        init: controller,
        tag: 'reset_password_controller',
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                    secondary: theme.colorScheme.primary.withAlpha(40))),
            child: _buildBody(),
          );
        });
  }

  Widget _buildBody() {
    return Scaffold(
      body: ListView(
        padding:
            MySpacing.fromLTRB(20, MySpacing.safeAreaTop(context) + 48, 20, 20),
        children: [
          MyText.displaySmall(
            'Reset Password',
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(20),
          MyText.bodyMedium(
            'Reset your password for the account registered with the email: ${widget.email}', // Use the email here
            muted: true,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(32),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                SlideTransition(
                  position: controller.passwordAnimation,
                  child: TextFormField(
                    style: MyTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: theme.cardTheme.color,
                        prefixIcon: Icon(
                          LucideIcons.lock,
                          color: theme.colorScheme.onBackground,
                        ),
                        hintText: "Password",
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        contentPadding: MySpacing.all(16),
                        hintStyle: MyTextStyle.bodyMedium(),
                        isCollapsed: true),
                    maxLines: 1,
                    controller: controller.passwordTE,
                    validator: controller.validatePassword,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                MySpacing.height(20),
                SlideTransition(
                  position: controller.resetPasswordAnimation,
                  child: TextFormField(
                    style: MyTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: theme.cardTheme.color,
                        prefixIcon: Icon(
                          LucideIcons.lock,
                          color: theme.colorScheme.onBackground,
                        ),
                        hintText: "Confirm Password",
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        contentPadding: MySpacing.all(16),
                        hintStyle: MyTextStyle.bodyMedium(),
                        isCollapsed: true),
                    maxLines: 1,
                    controller: controller.confirmPasswordTE,
                    validator: controller.validateConfirmPassword,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
          MySpacing.height(20),
          MyButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            onPressed: () {
              controller.resetPassword();
            },
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText.labelLarge(
                  "Reset Password",
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                  letterSpacing: 0.4,
                ),
                MySpacing.width(8),
                SlideTransition(
                    position: controller.arrowAnimation,
                    child: Icon(
                      LucideIcons.arrowRight,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
