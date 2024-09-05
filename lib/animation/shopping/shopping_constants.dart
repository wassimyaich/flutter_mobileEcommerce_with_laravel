import 'package:flutkit/animation/shopping/models/cart.dart';
import 'package:flutkit/animation/shopping/models/category.dart';
import 'package:flutkit/animation/shopping/models/product.dart';

class ShoppingCache {
  static List<Category>? categories;
  static List<Product>? products;
  static List<Cart>? carts;

  static Future<void> initDummy() async {
    // ShoppingCache.products = await Product.getDummyList();
    ShoppingCache.products = await Product.getDummyList();
    ShoppingCache.carts = await Cart.getDummyList();
    ShoppingCache.categories = await Category.getDummyList();

    print(
        'Products initialized: ${ShoppingCache.products?.length}'); // Print the number of products initialized
  }

  static bool isFirstTime = true;
}
