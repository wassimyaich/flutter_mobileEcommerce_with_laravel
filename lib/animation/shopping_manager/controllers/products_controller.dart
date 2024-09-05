import 'package:flutkit/animation/shopping_manager/model/product.dart';
import 'package:flutkit/animation/shopping_manager/shopping_cache.dart';
import 'package:flutkit/animation/shopping_manager/views/product_screen.dart';
import 'package:get/get.dart';

enum ProductViewType { grid, list }

class ProductsController extends GetxController {
  late ProductViewType viewType;
  List<Product> products = [];
  List<Product> filteredProducts = [];
  ProductsController() {
    viewType = ProductViewType.grid;
    // products = ShoppingCache.products!;
    // products = ShoppingCache.products?.toList() ?? [];
    _initProducts();
  }
  void _initProducts() async {
    await ShoppingCache.initDummy(); // Ensure products are initialized
    products = ShoppingCache.products?.toList() ?? [];
    // for (var product in products) {
    //   print('Image path: ${product.imageUrl}');
    // }
    filteredProducts = products;
    update();
  }

  void changeProductView(ProductViewType viewType) {
    this.viewType = viewType;
    update();
  }

// Added: Method to filter products based on search query
  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    update();
  }

  void goToProduct(Product product) {
    Get.to(ProductScreen(product));
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => ProductScreen(product),
    //   ),
    // );
  }
}
