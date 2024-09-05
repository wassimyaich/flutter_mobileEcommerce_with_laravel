// import 'package:flutkit/shopping/cart_screen.dart';
// import 'package:flutkit/shopping/home_screen.dart';
// import 'package:flutkit/shopping/profile_screen.dart';
// import 'package:flutkit/shopping/search_screen.dart';
// import 'package:flutkit/helpers/theme/app_notifier.dart';
// import 'package:flutkit/helpers/theme/app_theme.dart';
// import 'package:flutkit/helpers/navigation/custom_bottom_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:provider/provider.dart';

// class ShoppingFullApp extends StatefulWidget {
//   @override
//   _ShoppingFullAppState createState() => _ShoppingFullAppState();
// }

// class _ShoppingFullAppState extends State<ShoppingFullApp> {
//   int _currentIndex = 1;
//   PageController? _pageController;

//   late NavigationTheme navigationTheme;

//   late ThemeData theme;

//   @override
//   void initState() {
//     super.initState();
//     theme = AppTheme.theme;
//     _pageController = PageController(initialPage: 1);
//     navigationTheme = NavigationTheme.getNavigationTheme();
//   }

//   @override
//   void dispose() {
//     _pageController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppNotifier>(
//       builder: (BuildContext context, AppNotifier value, Widget? child) {
//         return Theme(
//           data: theme.copyWith(
//               colorScheme: theme.colorScheme
//                   .copyWith(secondary: theme.primaryColor.withAlpha(10))),
//           child: MaterialApp(
//               debugShowCheckedModeBanner: false,
//               theme: theme,
//               home: Scaffold(
//                 body: SizedBox.expand(
//                   child: PageView(
//                     controller: _pageController,
//                     onPageChanged: (index) {
//                       setState(() => _currentIndex = index);
//                     },
//                     children: <Widget>[
//                       ShoppingHomeScreen(),
//                       ShoppingSearchScreen(),
//                       ShoppingCartScreen(),
//                       ShoppingProfileScreen(
//                         root: context,
//                       )
//                     ],
//                   ),
//                 ),
//                 bottomNavigationBar: CustomBottomNavigation(
//                   animationDuration: Duration(milliseconds: 350),
//                   selectedItemOverlayColor:
//                       navigationTheme.selectedOverlayColor,
//                   backgroundColor: navigationTheme.backgroundColor,
//                   selectedIndex: _currentIndex,
//                   onItemSelected: (index) {
//                     setState(() => _currentIndex = index);
//                     _pageController!.jumpToPage(index);
//                   },
//                   items: <CustomBottomNavigationBarItem>[
//                     CustomBottomNavigationBarItem(
//                         title: "Home",
//                         icon: Icon(Icons.storefront_outlined, size: 22),
//                         activeIcon: Icon(Icons.storefront, size: 22),
//                         activeColor: navigationTheme.selectedItemColor,
//                         inactiveColor: navigationTheme.unselectedItemColor),
//                     CustomBottomNavigationBarItem(
//                         title: "Search",
//                         icon: Icon(LucideIcons.search, size: 22),
//                         activeIcon: Icon(LucideIcons.search, size: 22),
//                         activeColor: navigationTheme.selectedItemColor,
//                         inactiveColor: navigationTheme.unselectedItemColor),
//                     CustomBottomNavigationBarItem(
//                         title: "Cart",
//                         icon: Icon(LucideIcons.shoppingCart, size: 22),
//                         activeIcon: Icon(LucideIcons.shoppingCart, size: 22),
//                         activeColor: navigationTheme.selectedItemColor,
//                         inactiveColor: navigationTheme.unselectedItemColor),
//                     CustomBottomNavigationBarItem(
//                         title: "Profile",
//                         icon: Icon(
//                           LucideIcons.user,
//                           size: 22,
//                         ),
//                         activeIcon: Icon(
//                           LucideIcons.user,
//                           size: 22,
//                         ),
//                         activeColor: navigationTheme.selectedItemColor,
//                         inactiveColor: navigationTheme.unselectedItemColor),
//                   ],
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
