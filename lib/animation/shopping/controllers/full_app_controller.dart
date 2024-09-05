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

  FullAppController(this.tickerProvider) {
    tabController =
        TabController(length: pages, vsync: tickerProvider, initialIndex: 0);

    navItems = [
      NavItem('Home', LucideIcons.home),
      NavItem('Search', LucideIcons.search),
      NavItem('Cart', LucideIcons.shoppingCart),
      NavItem('Profile', LucideIcons.user),
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
