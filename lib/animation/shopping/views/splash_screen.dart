import 'package:flutkit/animation/shopping/controllers/splash_controller.dart';
import 'package:flutkit/helpers/theme/app_notifier.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SplashController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    // FxControllerStore.resetStore();
    controller = SplashController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(
                  secondary: theme.colorScheme.primary.withAlpha(40))),
          builder: (context, child) {
            return Directionality(
                textDirection: AppTheme.textDirection, child: child!);
          },
          home: Scaffold(
            body: Padding(
              padding: MySpacing.fromLTRB(
                  20, MySpacing.safeAreaTop(context) + 20, 20, 20),
              child: Column(
                children: [
                  MyContainer(
                    padding: MySpacing.xy(48, 20),
                    color: theme.colorScheme.primaryContainer,
                    borderRadiusAll: 8,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      fit: BoxFit.fill,
                      height: 300,
                      image: AssetImage(Images.shoppingSplash),
                    ),
                  ),
                  MySpacing.height(40),
                  MyText.displaySmall(
                    'Find your next \nClothes here',
                    fontWeight: 700,
                    textAlign: TextAlign.center,
                  ),
                  MySpacing.height(20),
                  MyText.bodyMedium(
                    'Explore all the most trending clothes \nhere based on your interest and go \nshopping!',
                    xMuted: true,
                    textAlign: TextAlign.center,
                  ),
                  MySpacing.height(40),
                  MyButton.block(
                    onPressed: () {
                      controller.goToLoginScreen();
                    },
                    backgroundColor: theme.colorScheme.primary,
                    elevation: 0,
                    borderRadiusAll: 4,
                    padding: MySpacing.y(20),
                    child: MyText.labelLarge(
                      'Head on to explore !',
                      fontWeight: 600,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
