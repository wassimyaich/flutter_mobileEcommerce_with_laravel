import 'package:flutkit/animation/shopping/controllers/register_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/helpers/widgets/my_text_style.dart';
import 'package:flutkit/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late RegisterController controller;

  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = RegisterController(this);

    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: controller,
        tag: 'register_controller',
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
            'Register',
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(20),
          MyText.bodyMedium(
            'Sign up to get started!',
            muted: true,
            textAlign: TextAlign.center,
          ),
          MySpacing.height(32),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                SlideTransition(
                  position: controller.nameAnimation,
                  child: TextFormField(
                    style: MyTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: theme.cardTheme.color,
                        prefixIcon: Icon(
                          LucideIcons.user,
                          color: theme.colorScheme.onBackground,
                        ),
                        hintText: "Name",
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        contentPadding: MySpacing.all(16),
                        hintStyle: MyTextStyle.bodyMedium(),
                        isCollapsed: true),
                    maxLines: 1,
                    controller: controller.nameTE,
                    validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                MySpacing.height(20),
                SlideTransition(
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
                MySpacing.height(20),
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
              ],
            ),
          ),
          MySpacing.height(20),
          MyButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            onPressed: () {
              controller.register();
            },
            padding: MySpacing.y(20),
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText.labelLarge(
                  "Create Account",
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
                  ),
                ),
              ],
            ),
          ),
          MySpacing.height(20),
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: MySpacing.x(20),
                child: MyText.bodySmall(
                  'Continue with',
                  muted: true,
                  fontWeight: 600,
                  fontSize: 10,
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
          MySpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyContainer.bordered(
                padding: MySpacing.all(16),
                borderRadiusAll: 8,
                child: Image(
                  height: 24,
                  width: 24,
                  image: AssetImage(Images.google),
                ),
              ),
              MyContainer.bordered(
                padding: MySpacing.all(16),
                borderRadiusAll: 8,
                child: Image(
                  height: 24,
                  width: 24,
                  image: AssetImage(Images.apple),
                ),
              ),
              MyContainer.bordered(
                padding: MySpacing.all(16),
                borderRadiusAll: 8,
                child: Image(
                  height: 24,
                  width: 24,
                  image: AssetImage(Images.facebook),
                ),
              ),
            ],
          ),
          MySpacing.height(20),
          Center(
            child: MyButton.text(
              onPressed: () {
                controller.goToLogInScreen();
              },
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: MyText.labelLarge("I have an Account",
                  decoration: TextDecoration.underline,
                  color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
