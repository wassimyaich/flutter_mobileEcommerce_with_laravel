import 'package:flutkit/animation/shopping_manager/views/dashboard_screen.dart';
import 'package:flutkit/animation/shopping_manager/views/orders_screen.dart';
import 'package:flutkit/animation/shopping_manager/views/products_screen.dart';
import 'package:flutkit/animation/shopping_manager/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavItem {
  final String title;
  final IconData iconData;

  NavItem(this.title, this.iconData);
}

class FullAppController extends GetxController {
  int currentIndex = 0;
  int pages = 4;
  late TabController tabController;

  final TickerProvider tickerProvider;

  late List<NavItem> navItems;
  late List<Widget> items;

  FullAppController(this.tickerProvider) {
    tabController =
        TabController(length: pages, vsync: tickerProvider, initialIndex: 0);

    navItems = [
      NavItem('Dashboard', LucideIcons.airplay),
      NavItem('Products', LucideIcons.server),
      NavItem('Orders', LucideIcons.truck),
      NavItem('Profile', LucideIcons.user),
    ];

    items = [
      DashboardScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen(),
    ];
  }

  @override
  void onInit() {
    tabController.addListener(handleTabSelection);
    tabController.animation!.addListener(() {
      final aniValue = tabController.animation!.value;
      if (aniValue - currentIndex > 0.5) {
        currentIndex++;
        update();
      } else if (aniValue - currentIndex < -0.5) {
        currentIndex--;
        update();
      }
    });
    super.onInit();
  }

  handleTabSelection() {
    currentIndex = tabController.index;
    update();
  }
}
