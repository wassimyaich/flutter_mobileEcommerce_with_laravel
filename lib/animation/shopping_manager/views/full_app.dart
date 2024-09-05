import 'package:flutkit/animation/shopping_manager/controllers/full_app_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_tab_indicator_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingManagerFullApp extends StatefulWidget {
  const ShoppingManagerFullApp({Key? key}) : super(key: key);

  @override
  _ShoppingManagerFullAppState createState() => _ShoppingManagerFullAppState();
}

class _ShoppingManagerFullAppState extends State<ShoppingManagerFullApp>
    with SingleTickerProviderStateMixin {
  late FullAppController controller;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    controller = FullAppController(this);
    theme = AppTheme.shoppingManagerTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FullAppController>(
        init: controller,
        tag: 'full_app_controller',
        // theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                    child: TabBarView(
                  controller: controller.tabController,
                  children: controller.items,
                )),
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

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.navItems.length; i++) {
      bool selected = controller.currentIndex == i;
      tabs.add(Icon(controller.navItems[i].iconData,
          size: 20,
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground));
    }
    return tabs;
  }
}
