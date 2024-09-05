import 'package:flutkit/animation/shopping/models/cart.dart';
import 'package:flutkit/animation/shopping/shopping_constants.dart';
import 'package:flutkit/animation/shopping/views/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  TickerProvider ticker;

  CartController(this.ticker);

  bool showLoading = true, uiLoading = true;
  List<Cart> carts = [];
  List<Cart> filtredCarts = [];

  late double order, tax = 30, offer = 50, total;
  late AnimationController animationController, fadeController;
  late Animation<Offset> animation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    fetchData();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: ticker,
    );
    fadeController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: ticker,
    );
    animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(15, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );
    fadeController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  bool increaseAble(Cart cart) {
    return cart.quantity < cart.product.quantity;
  }

  bool decreaseAble(Cart cart) {
    return cart.quantity > 1;
  }

  void increment(Cart cart) {
    if (!increaseAble(cart)) return;
    cart.quantity++;
    calculateBilling();
    update();
  }

  void decrement(Cart cart) {
    if (!decreaseAble(cart)) return;
    cart.quantity--;
    calculateBilling();
    update();
  }

  void _initCarts() async {
    await ShoppingCache.initDummy(); // Ensure products are initialized
    carts = ShoppingCache.carts?.toList() ?? [];
    // for (var product in products) {
    //   print('Image path: ${product.imageUrl}');
    // }
    filtredCarts = carts;
    calculateBilling();

    update();
  }

  void fetchData() async {
    _initCarts();
    calculateBilling();
    showLoading = false;
    uiLoading = false;
    update();
  }

  void calculateBilling() {
    order = 0;
    for (Cart cart in carts) {
      order = order + (cart.product.price * cart.quantity);
    }
    total = order + tax - offer;
  }

  Future<void> goToCheckout() async {
    animationController.forward();
    await Future.delayed(Duration(seconds: 1));
    Get.to(CheckOutScreen());
  }
}
