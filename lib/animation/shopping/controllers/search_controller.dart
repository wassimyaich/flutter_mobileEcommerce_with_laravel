// import 'package:flutkit/animation/shopping/models/product.dart';
// import 'package:flutkit/animation/shopping/models/category.dart';

// import 'package:flutkit/animation/shopping/shopping_constants.dart';
// import 'package:flutkit/animation/shopping/views/single_product_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SearchController extends GetxController {
//   TickerProvider ticker;
//   SearchController(this.ticker);
//   List<Product>? products;
//   bool showLoading = true, uiLoading = true;
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   List<String> selectedChoices = [];
//   RangeValues selectedRange = RangeValues(200, 800);
//   late AnimationController animationController;
//   late Animation<double> fadeAnimation;

//   // List<String> categoryList = [
//   //   "T-Shirt",
//   //   "Shirts",
//   //   "Jeans",
//   //   "Pants",
//   //   "Men's wear",
//   //   "Women's wear",
//   //   "Nightdress",
//   //   "Underwear",
//   //   "Food",
//   //   "Electronics",
//   //   "Tech",
//   //   "Other",
//   // ];
//   List<String> categoryList = []; // Empty initially
//   List<Category> categories = [];
//   List<Category> filteredCategories = [];

//   void _initCategories() async {
//     await ShoppingCache.initDummy();
//     categories = ShoppingCache.categories?.toList() ?? [];
//     _populateCategoryList();
//     filteredCategories = categories;
//     update(); // Notify listeners to update UI
//   }

//   void _populateCategoryList() {
//     categoryList = categories.map((category) => category.name).toList();
//     print('Category List: $categoryList'); // Debugging print statement
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     _initCategories();
//     fetchData();
//     animationController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: ticker,
//     );
//     fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.easeIn,
//       ),
//     );
//     animationController.forward();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   double findAspectRatio() {
//     double width = Get.width;
//     // double width = MediaQuery.of(context).size.width;
//     return ((width - 58) / 2) / (250);
//   }

//   void goToProductScreen(Product product) {
//     Get.to(
//       SingleProductScreen(product),
//       duration: Duration(seconds: 1),
//     );
//   }

//   void fetchData() async {
//     products = ShoppingCache.products;
//   }

//   void openEndDrawer() {
//     scaffoldKey.currentState?.openEndDrawer();
//   }

//   void closeEndDrawer() {
//     scaffoldKey.currentState?.openDrawer();
//   }

//   void addChoice(String item) {
//     selectedChoices.add(item);
//     filterProductsByType(); // Apply filter

//     update();
//   }

//   void removeChoice(String item) {
//     selectedChoices.remove(item);
//     filterProductsByType(); // Apply filter

//     update();
//   }

//   void onChangePriceRange(RangeValues newRange) {
//     selectedRange = newRange;
//     print('add range');
//     searchProducts(''); // Reapply filtering based on the new price range
//     update();
//   }

//   // void searchProducts(String query) {
//   //   if (query.isEmpty) {
//   //     // Reset to all products if query is empty
//   //     products = ShoppingCache.products;
//   //   } else {
//   //     products = ShoppingCache.products!.where((product) {
//   //       return product.name.toLowerCase().contains(query.toLowerCase());
//   //     }).toList();
//   //   }
//   //   update(); // Update the UI with the new product list
//   // }
//   void searchProducts(String query) {
//     if (query.isEmpty && selectedChoices.isEmpty) {
//       // Reset to all products if query is empty and no categories selected
//       products = ShoppingCache.products!.where((product) {
//         return product.price >= selectedRange.start &&
//             product.price <= selectedRange.end;
//       }).toList();
//     } else {
//       products = ShoppingCache.products!.where((product) {
//         final matchesQuery =
//             product.name.toLowerCase().contains(query.toLowerCase());
//         final matchesCategory = selectedChoices.isEmpty ||
//             selectedChoices.contains(product.category_name);
//         final withinPriceRange = product.price >= selectedRange.start &&
//             product.price <= selectedRange.end;
//         return matchesQuery && matchesCategory && withinPriceRange;
//       }).toList();
//     }
//     update(); // Update the UI with the new product list
//   }

//   void filterProductsByType() {
//     if (selectedChoices.isEmpty) {
//       products = ShoppingCache.products;
//     } else {
//       print('add category');

//       products = ShoppingCache.products!.where((product) {
//         return selectedChoices.contains(product.category_name);
//       }).toList();
//     }
//     update();
//   }
// }
import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/animation/shopping/models/category.dart';

import 'package:flutkit/animation/shopping/shopping_constants.dart';
import 'package:flutkit/animation/shopping/views/single_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TickerProvider ticker;
  SearchController(this.ticker);

  List<Product>? products;
  bool showLoading = true, uiLoading = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedChoices = [];
  RangeValues selectedRange = RangeValues(200, 800);

  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  List<String> categoryList = []; // Empty initially
  List<Category> categories = [];
  List<Category> filteredCategories = [];

  @override
  void onInit() {
    super.onInit();
    _initCategories();
    fetchData();

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _initCategories() async {
    await ShoppingCache.initDummy();
    categories = ShoppingCache.categories?.toList() ?? [];
    _populateCategoryList();
    filteredCategories = categories;
    update(); // Notify listeners to update UI
  }

  void _populateCategoryList() {
    categoryList = categories.map((category) => category.name).toList();
    selectedChoices = List.from(categoryList);
    print('Category List: $categoryList'); // Debugging print statement
  }

  double findAspectRatio() {
    double width = Get.width;
    return ((width - 58) / 2) / 250;
  }

  void goToProductScreen(Product product) {
    Get.to(
      SingleProductScreen(product),
      duration: Duration(seconds: 1),
    );
  }

  void fetchData() async {
    products = ShoppingCache.products;
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void addChoice(String item) {
    selectedChoices.add(item);
    updatePriceRange(item); // Update price range based on selected category
    filterProductsByType(); // Apply filter
    update();
  }

  void removeChoice(String item) {
    selectedChoices.remove(item);
    updatePriceRange(null); // Update price range after removing a category
    filterProductsByType(); // Apply filter
    update();
  }

  void onChangePriceRange(RangeValues newRange) {
    selectedRange = newRange;
    searchProducts(''); // Reapply filtering based on the new price range
    update();
  }

  void searchProducts(String query) {
    if (query.isEmpty && selectedChoices.isEmpty) {
      // Reset to all products if query is empty and no categories selected
      products = ShoppingCache.products!.where((product) {
        return product.price >= selectedRange.start &&
            product.price <= selectedRange.end;
      }).toList();
    } else {
      products = ShoppingCache.products!.where((product) {
        final matchesQuery =
            product.name.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = selectedChoices.isEmpty ||
            selectedChoices.contains(product.category_name);
        final withinPriceRange = product.price >= selectedRange.start &&
            product.price <= selectedRange.end;
        return matchesQuery && matchesCategory && withinPriceRange;
      }).toList();
    }
    update(); // Update the UI with the new product list
  }

  void filterProductsByType() {
    if (selectedChoices.isEmpty) {
      products = ShoppingCache.products;
    } else {
      print('add category');

      products = ShoppingCache.products!.where((product) {
        return selectedChoices.contains(product.category_name);
      }).toList();
    }
    update();
  }

  void updatePriceRange(String? category) {
    if (category == null || selectedChoices.isEmpty) {
      // Reset to default range if no category is selected
      selectedRange = RangeValues(200, 800);
    } else {
      // Filter products by selected category and find min/max price
      List<Product> filteredProducts = ShoppingCache.products!
          .where((product) => selectedChoices.contains(product.category_name))
          .toList();

      if (filteredProducts.isNotEmpty) {
        double minPrice = filteredProducts
            .map((p) => p.price)
            .reduce((a, b) => a < b ? a : b);
        double maxPrice = filteredProducts
            .map((p) => p.price)
            .reduce((a, b) => a > b ? a : b);

        selectedRange = RangeValues(minPrice, maxPrice);
      } else {
        selectedRange =
            RangeValues(0, 10000); // Default range if no products in category
      }
    }
  }
}
