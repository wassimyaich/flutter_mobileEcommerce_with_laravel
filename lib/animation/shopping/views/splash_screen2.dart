import 'package:flutkit/animation/shopping/controllers/splash_screen2_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  late ThemeData theme;

  late SplashScreen2Controller controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = SplashScreen2Controller();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreen2Controller>(
        init: controller,
        tag: 'splash_screen2_controller',
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "splash_username",
                    child: FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for SharedPreferences to load, show a loading indicator
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // Handle error case
                          return MyText.titleLarge(
                            "Error loading name",
                            fontWeight: 700,
                          );
                        } else {
                          // Retrieve the user's name from SharedPreferences
                          String userName =
                              snapshot.data?.getString('name') ?? 'User';
                          return MyText.titleLarge(
                            'Hey $userName,',
                            fontWeight: 700,
                          );
                        }
                      },
                    ),
                  ),
                  MyText.bodySmall(
                    "Wait here, we are fetching data",
                  ),
                ],
              ),
            ),
          );
        });
  }
}
