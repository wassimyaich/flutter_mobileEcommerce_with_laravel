// import 'package:flutkit/animation/shopping/models/product.dart';
// import 'package:flutkit/animation/shopping/shopping_constants.dart';
// import 'package:flutkit/animation/shopping/views/single_product_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SingleProductController extends GetxController {
//   TickerProvider ticker;
//   SingleProductController(this.ticker, this.product) {
//     sizes = ['S', 'M', 'L', 'XL'];
//   }
//   bool showLoading = true, uiLoading = true;
//   int colorSelected = 1;
//   Product product;
//   late AnimationController animationController, cartController;
//   late Animation<Color?> colorAnimation;
//   late Animation<double?> sizeAnimation, cartAnimation, paddingAnimation;

//   bool isFav = false;
//   bool addCart = false;

//   late List<String> sizes;
//   String selectedSize = 'M';

//   List<Product>? products;

//   @override
//   void onInit() {
//     super.onInit();
//     // save = false;
//     fetchData();
//     animationController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));

//     cartController = AnimationController(
//         vsync: ticker, duration: Duration(milliseconds: 500));

//     colorAnimation =
//         ColorTween(begin: Colors.grey.shade400, end: Color(0xff1c8c8c))
//             .animate(animationController);

//     sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
//       TweenSequenceItem<double>(
//           tween: Tween<double>(begin: 24, end: 28), weight: 50),
//       TweenSequenceItem<double>(
//           tween: Tween<double>(begin: 28, end: 24), weight: 50)
//     ]).animate(animationController);

//     cartAnimation = TweenSequence(<TweenSequenceItem<double>>[
//       TweenSequenceItem<double>(
//           tween: Tween<double>(begin: 24, end: 28), weight: 50),
//       TweenSequenceItem<double>(
//           tween: Tween<double>(begin: 28, end: 24), weight: 50)
//     ]).animate(cartController);

//     paddingAnimation = TweenSequence(<TweenSequenceItem<double>>[
//       TweenSequenceItem<double>(
//           tween: Tween<double>(begin: 16, end: 14), weight: 50),
//       TweenSequenceItem<double>(
//           tween: Tween<double>(begin: 14, end: 16), weight: 50)
//     ]).animate(cartController);

//     animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         isFav = true;
//         update();
//       }
//       if (status == AnimationStatus.dismissed) {
//         isFav = false;
//         update();
//       }
//     });

//     cartController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         addCart = true;
//         update();
//       }
//       if (status == AnimationStatus.dismissed) {
//         addCart = false;
//         update();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     cartController.dispose();
//     super.dispose();
//   }

//   void toggleFavorite() {
//     product.favorite = !product.favorite;
//     update();
//   }

//   void goBack() {
//     Get.back();
//     // Navigator.pop(context);
//   }

//   void selectSize(String size) {
//     selectedSize = size;
//     update();
//   }

//   void fetchData() async {
//     products = ShoppingCache.products;
//   }

//   Future<void> goToCheckout() async {
//     /*Navigator.of(context, rootNavigator: true).push(
//       MaterialPageRoute(
//         builder: (context) => CheckOutScreen(),
//       ),
//     );*/
//   }

//   void goToSingleProduct(Product product) {
//     Get.to(SingleProductScreen(product));
//     // Navigator.of(context, rootNavigator: true).push(
//     //   MaterialPageRoute(
//     //     builder: (context) => SingleProductScreen(product),
//     //   ),
//     // );
//   }
// }
import 'dart:convert';

import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/animation/shopping/shopping_constants.dart';
import 'package:flutkit/animation/shopping/views/single_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleProductController extends GetxController {
  TickerProvider ticker;
  SingleProductController(this.ticker, this.product) {
    sizes = ['S', 'M', 'L', 'XL'];
  }

  bool showLoading = true, uiLoading = true;
  int colorSelected = 1;
  Product product;
  late AnimationController animationController, cartController;
  late Animation<Color?> colorAnimation;
  late Animation<double?> sizeAnimation, cartAnimation, paddingAnimation;

  bool isFav = false;
  bool addCart = false;

  late List<String> sizes;
  String selectedSize = 'M';

  List<Product>? products;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));

    cartController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));

    colorAnimation =
        ColorTween(begin: Colors.grey.shade400, end: Color(0xff1c8c8c))
            .animate(animationController);

    sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 24), weight: 50)
    ]).animate(animationController);

    cartAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 24), weight: 50)
    ]).animate(cartController);

    paddingAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 16, end: 14), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 14, end: 16), weight: 50)
    ]).animate(cartController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isFav = true;
        update();
      }
      if (status == AnimationStatus.dismissed) {
        isFav = false;
        update();
      }
    });

    cartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        addCart = true;
        update();
      }
      if (status == AnimationStatus.dismissed) {
        addCart = false;
        update();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    cartController.dispose();
    super.dispose();
  }

  void toggleFavorite() {
    product.favorite = !product.favorite;
    update();
  }

  void goBack() {
    Get.back();
  }

  void selectSize(String size) {
    selectedSize = size;
    update();
  }

  void fetchData() async {
    products = ShoppingCache.products;
  }

  Future<void> goToCheckout() async {
    // Implementation for going to checkout
  }

  void goToSingleProduct(Product product) {
    Get.to(SingleProductScreen(product));
  }

  // Future<void> addToCart() async {
  //   try {
  //     final url =
  //         'http://192.168.1.5:8000/api/carts'; // Replace with your API URL

  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('token');

  //     final headers = {
  //       'Authorization': 'Bearer $token',
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //     };

  //     final body = json.encode({
  //       'product_id': product.id,
  //       'selected_size': selectedSize,
  //       'quantity': 1, // You can adjust this value as needed
  //       'selected_color': '#FFA07A', // Adjust this if needed
  //     });

  //     final response =
  //         await http.post(Uri.parse(url), headers: headers, body: body);

  //     if (response.statusCode == 201) {
  //       // Successfully added to cart, animate the cart icon
  //       if (addCart) {
  //         cartController.reverse();
  //       } else {
  //         cartController.forward();
  //       }
  //       addCart = !addCart;
  //       Get.snackbar('Success', 'Product added to cart');
  //     } else {
  //       // Handle failure response
  //       Get.snackbar('Error', 'Failed to add product to cart');
  //     }
  //   } catch (e) {
  //     print('Error adding product to cart: $e');
  //     Get.snackbar('Error', 'Failed to add product to cart');
  //   }
  // }
  Future<void> addToCart() async {
    try {
      final url =
          // 'http://192.168.1.5:8000/api/carts'; // Replace with your API URL
          'http://192.168.137.63:8000/api/carts'; // Replace with your API URL

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      // First, check if the product is already in the cart
      final checkResponse = await http.get(
        Uri.parse(
            '$url/check?product_id=${product.id}&selected_size=$selectedSize'),
        headers: headers,
      );

      if (checkResponse.statusCode == 200) {
        final isProductInCart = json.decode(checkResponse.body)['in_cart'];

        if (isProductInCart) {
          // If the product is already in the cart, remove it
          final removeResponse = await http.delete(
            Uri.parse('$url/${product.id}'),
            headers: headers,
          );

          if (removeResponse.statusCode == 200) {
            addCart = false;
            cartController.reverse();
            Get.snackbar('Success', 'Product removed from cart');
          } else {
            Get.snackbar('Error', 'Failed to remove product from cart');
          }
        } else {
          // If the product is not in the cart, add it
          final body = json.encode({
            'product_id': product.id,
            'selected_size': selectedSize,
            'quantity': 1, // You can adjust this value as needed
            'selected_color': '#FFA07A', // Adjust this if needed
          });

          final response =
              await http.post(Uri.parse(url), headers: headers, body: body);

          if (response.statusCode == 201) {
            addCart = true;
            cartController.forward();
            Get.snackbar('Success', 'Product added to cart');
          } else {
            Get.snackbar('Error', 'Failed to add product to cart');
          }
        }
      } else {
        Get.snackbar('Error', 'Failed to check cart status');
      }
    } catch (e) {
      print('Error managing product in cart: $e');
      Get.snackbar('Error', 'Failed to manage product in cart');
    }
  }
}
