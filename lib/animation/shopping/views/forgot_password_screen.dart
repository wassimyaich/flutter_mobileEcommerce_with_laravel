import 'package:flutkit/animation/shopping/controllers/forgot_password_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ForgotPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = ForgotPasswordController(this);
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: controller,
        tag: 'forgot_password_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      body: ListView(
        padding:
            MySpacing.fromLTRB(20, MySpacing.safeAreaTop(context) + 48, 20, 20),
        children: [
          MyText.displaySmall(
            'Forgot Password?',
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(20),
          MyText.bodyMedium(
            'Welcome to change password!!',
            muted: true,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(32),
          Form(
            key: controller.formKey,
            child: SlideTransition(
              position: controller.emailAnimation,
              child: TextFormField(
                style: MyTextStyle.bodyMedium(),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    fillColor: theme.cardTheme.color,
                    prefixIcon: Icon(
                      LucideIcons.mail,
                      color: theme.colorScheme.onBackground,
                    ),
                    hintText: "Email Address",
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: MySpacing.all(16),
                    hintStyle: MyTextStyle.bodyMedium(),
                    isCollapsed: true),
                maxLines: 1,
                controller: controller.emailTE,
                validator: controller.validateEmail,
                cursorColor: theme.colorScheme.onBackground,
              ),
            ),
          ),
          MySpacing.height(20),
          MyButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            padding: MySpacing.y(20),
            onPressed: () {
              controller.goToResetPasswordScreen();
            },
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText.labelLarge(
                  "Submit",
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
          MySpacing.height(16),
          Center(
            child: MyButton.text(
              onPressed: () {
                controller.goToRegisterScreen();
              },
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: MyText.labelLarge("I haven't an account",
                  decoration: TextDecoration.underline,
                  color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
