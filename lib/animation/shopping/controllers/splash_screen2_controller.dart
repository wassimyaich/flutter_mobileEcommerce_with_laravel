import 'package:flutkit/animation/shopping/models/cart.dart';
import 'package:flutkit/animation/shopping/models/category.dart';
import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/animation/shopping/shopping_constants.dart';
import 'package:flutkit/animation/shopping/views/full_app.dart';
import 'package:get/get.dart';

class SplashScreen2Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToFullApp();
  }

  // goToFullApp() async {

  //   ShoppingCache.products = await Product.getDummyList();
  //   ShoppingCache.categories = await Category.getDummyList();
  //   ShoppingCache.carts = await Cart.getDummyList();
  //   await Future.delayed(Duration(seconds: 1));

  //   Get.off(FullApp()
  //       // PageRouteBuilder(
  //       //     transitionDuration: Duration(seconds: 2),
  //       //     pageBuilder: (_, __, ___) => FullApp()),
  //       );
  //   // Navigator.of(context, rootNavigator: true).pushReplacement(
  //   //   PageRouteBuilder(
  //   //       transitionDuration: Duration(seconds: 2),
  //   //       pageBuilder: (_, __, ___) => FullApp()),
  //   // );
  // }
  Future<void> goToFullApp() async {
    try {
      // Fetch data
      ShoppingCache.products = await Product.getDummyList();
      ShoppingCache.categories = await Category.getDummyList();
      ShoppingCache.carts = await Cart.getDummyList();
    } catch (e) {
      // Handle any errors during data fetching
      print('Error fetching data: $e');
      // You might want to show an error message or navigate to a different screen
    } finally {
      // Ensure navigation happens after data fetching
      await Future.delayed(Duration(seconds: 1));
      Get.off(FullApp());
    }
  }
}
