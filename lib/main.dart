/*
* File : Main File
* We are using our own package (FlutX) : https://pub.dev/packages/flutx
* Version : 13
* */
// import 'package:flutkit/shopping1/shopping_reset_screen.dart';

// import 'package:flutkit/shopping1/shopping_login_screen.dart';
import 'package:flutkit/animation/shopping/views/login_screen.dart';

import 'package:flutkit/helpers/localizations/app_localization_delegate.dart';
import 'package:flutkit/helpers/localizations/language.dart';
import 'package:flutkit/helpers/theme/app_notifier.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //You will need to initialize AppThemeNotifier class for theme changes.
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  AppTheme.init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        // home: ShoppingLoginScreen(),
        home: LogInScreen(),

        builder: (context, child) {
          return Directionality(
            textDirection: AppTheme.textDirection,
            child: child ?? Container(),
          );
        },
        localizationsDelegates: [
          AppLocalizationsDelegate(context),
          // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Language.getLocales(),
        // home: IntroScreen(),
        // home: CookifyShowcaseScreen(),
      );
    });
  }
}
