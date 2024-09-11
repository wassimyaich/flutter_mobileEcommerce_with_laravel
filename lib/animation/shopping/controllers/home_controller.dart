import 'dart:async';

import 'package:flutkit/animation/shopping/models/category.dart';
import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/animation/shopping/shopping_constants.dart';
import 'package:flutkit/animation/shopping/views/notification_screen.dart';
import 'package:flutkit/animation/shopping/views/single_product_screen.dart';
import 'package:flutkit/animation/shopping/views/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TickerProvider ticker;
  HomeController(this.ticker);
  List<Category>? categories;

  List<Product> products = [];
  List<Product> filteredProducts = [];
  late Category selectedCategory;
  late AnimationController animationController;
  late AnimationController bellController;
  late Animation<double> scaleAnimation,
      slideAnimation,
      fadeAnimation,
      bellAnimation;
  late Tween<Offset> offset;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Widget> newCategories = [];
  late Intro intro;
  @override
  void onInit() {
    fetchData();
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: ticker,
    );
    bellController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    bellAnimation = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(
        parent: bellController,
        curve: Curves.linear,
      ),
    );

    offset = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));

    animationController.forward();
    bellController.repeat(reverse: true);

    intro = Intro(
      stepCount: 3,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {},
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Get your notifications from here',
          'Get latest & trending products here',
          'Get category wise products here',
        ],
        buttonTextBuilder: (currPage, totalPage) {
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );

    intro.setStepConfig(0, borderRadius: BorderRadius.circular(64));

    Timer(
      Duration(milliseconds: 2000),
      () {
        if (ShoppingCache.isFirstTime) {
          // intro.start(Get.context!);
          ShoppingCache.isFirstTime = false;
        }
      },
    );
    super.onInit();
  }

  startIntro() {
    intro.start(Get.context!);
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    IntroStatus introStatus = intro.getStatus();
    if (introStatus.isOpen) {
      intro.dispose();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    bellController.dispose();
    super.dispose();
  }

  void fetchData() {
    categories = ShoppingCache.categories;
    // products = ShoppingCache.products;
    _initProducts();
    selectedCategory = categories!.first;
  }

  void _initProducts() async {
    await ShoppingCache.initDummy(); // Ensure products are initialized
    products = ShoppingCache.products?.toList() ?? [];
    // for (var product in products) {
    //   print('Image path: ${product.imageUrl}');
    // }
    totalProductCount = products.length;
    filteredProducts = products.sublist(0, productsPerPage);
    update();
  }

  void changeSelectedCategory(Category category) {
    selectedCategory = category;
    currentPage = 1; // Reset current page for new category
    _filterProductsByCategory();
    print(selectedCategory.name);
    update();
  }

  void _filterProductsByCategory() {
    filteredProducts = products
        .where((product) => product.category_name == selectedCategory.name)
        .toList();
    totalProductCount =
        filteredProducts.length; // Update total count for category
    currentPage = 1; // Reset current page for the new category
    hasMoreProducts = true; // Reset has more products
    isLoading = false; // Reset loading state

    // Load initial products
    filteredProducts = filteredProducts.sublist(
        0,
        productsPerPage > filteredProducts.length
            ? filteredProducts.length
            : productsPerPage);

    print(
        'Products initialized: ${filteredProducts.length}'); // Print the number of products initialized // Print the number of products initialized
  }

  void goToSingleProduct(Product product) {
    Get.to(SingleProductScreen(product), duration: Duration(milliseconds: 500));
  }

  void goToSubscription() {
    Get.to(SubscriptionScreen());
  }

  void goToNotification() {
    Get.to(NotificationScreen());
  }

  // Pagination variables
  // Pagination variables
  int totalProductCount = 0;
  int productsPerPage = 10; // Set products per page
  int currentPage = 1; // Current page

  final int itemsPerPage = 10;
  bool isLoading = false;
  bool hasMoreProducts = true;

  void loadMoreProducts() async {
    if (isLoading || !hasMoreProducts) return;

    isLoading = true;
    update();

    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    // Calculate the next set of products from the full list
    int startIndex = currentPage * productsPerPage; // Start from the next page
    int endIndex = startIndex + productsPerPage;

    // Ensure endIndex doesn't exceed the length of products
    endIndex = endIndex > products.length ? products.length : endIndex;

    // Get new products based on category filtering
    List<Product> newProducts = products
        .where((product) => product.category_name == selectedCategory.name)
        .skip(startIndex)
        .take(productsPerPage)
        .toList();

    // If no new products are fetched, stop loading more
    if (newProducts.isEmpty) {
      hasMoreProducts = false;
    } else {
      // Add only new products if they are not already in the filteredProducts list
      for (var product in newProducts) {
        if (!filteredProducts.contains(product)) {
          filteredProducts.add(product);
        }
      }
      currentPage++; // Move to next page
    }

    isLoading = false;
    update();
  }
}
