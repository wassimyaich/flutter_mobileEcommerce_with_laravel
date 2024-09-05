import 'package:flutkit/animation/shopping/controllers/full_app_controller.dart';
import 'package:flutkit/animation/shopping/views/cart_screen.dart';
import 'package:flutkit/animation/shopping/views/home_screen.dart';
import 'package:flutkit/animation/shopping/views/profile_screen.dart';
import 'package:flutkit/animation/shopping/views/search_screen.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_tab_indicator_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullApp extends StatefulWidget {
  const FullApp({Key? key}) : super(key: key);

  @override
  _FullAppState createState() => _FullAppState();
}

class _FullAppState extends State<FullApp> with SingleTickerProviderStateMixin {
  late ThemeData theme;

  late FullAppController controller;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    controller = FullAppController(this);
  }

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.navItems.length; i++) {
      tabs.add(Icon(
        controller.navItems[i].iconData,
        size: 20,
        color: (controller.currentIndex == i)
            ? theme.colorScheme.primary
            : theme.colorScheme.onBackground,
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FullAppController>(
        init: controller,
        tag: 'full_app_controller',
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: const <Widget>[
                      HomeScreen(),
                      SearchScreen(),
                      CartScreen(),
                      ProfileScreen(),
                    ],
                  ),
                ),
                MyContainer(
                  bordered: true,
                  enableBorderRadius: false,
                  border: Border(
                      top: BorderSide(
                          color: theme.dividerColor,
                          width: 1,
                          style: BorderStyle.solid)),
                  padding: MySpacing.xy(12, 16),
                  color: theme.scaffoldBackgroundColor,
                  child: TabBar(
                    controller: controller.tabController,
                    indicator: MyTabIndicator(
                        indicatorColor: theme.colorScheme.primary,
                        indicatorHeight: 3,
                        radius: 3,
                        indicatorStyle: MyTabIndicatorStyle.rectangle,
                        yOffset: -18),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: theme.colorScheme.primary,
                    tabs: buildTab(),
                  ),
                )
              ],
            ),
          );
        });
  }
}
