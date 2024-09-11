import 'package:flutkit/animation/shopping/models/cart.dart';
import 'package:flutkit/animation/shopping/shopping_constants.dart';
import 'package:flutkit/animation/shopping/views/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:flutkit/animation/shopping/models/cart.dart';
import 'dart:convert';

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
    // Ensure all cart quantities are saved before proceeding to checkout
    for (Cart cart in carts) {
      await updateCartQuantity(cart); // Save each updated cart item
    }
    animationController.forward();
    await Future.delayed(Duration(seconds: 1));
    Get.to(CheckOutScreen());
  }

  Future<void> updateCartQuantity(Cart cart) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token') ?? '';
      var response = await http.post(
        Uri.parse('http://192.168.137.146:8000/api/updatecarts'),
        headers: {
          'Authorization': 'Bearer $token', // Include the auth token if needed
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'cart_id': cart.id,
          'quantity': cart.quantity,
        }),
      );

      if (response.statusCode == 200) {
        print('Cart quantity updated successfully');
      } else {
        print('Failed to update cart quantity');
      }
    } catch (e) {
      print('Error updating cart: $e');
    }
  }

  Future<void> removeProductFromCart(int cartId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse('http://192.168.137.146:8000/api/carts/delete/$cartId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Product removed from cart');
    } else if (response.statusCode == 404) {
      print('Product not found in cart');
    } else {
      throw Exception('Failed to remove product from cart');
    }
  }
}
