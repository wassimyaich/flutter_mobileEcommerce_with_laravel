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
  List<Product> filteredProducts = [];
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
    // selectedChoices.clear(); // Clear selections initially (no default filters)

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
    filteredProducts = products!;

    // Initialize visible products with the first set of products
    currentPage = 1; // Start with the first page
    _paginateProducts(); // Display initial products
    update();
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
    applyFilters(''); // Apply filters with updated price range
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
    applyFilters(query); // Update the UI with the new product list
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
    applyFilters('');
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

  // List<Product>? products; // All products fetched from cache
  List<Product> visibleProducts = []; // Products displayed on the UI
  int itemsPerPage = 10; // Number of items to load per page
  int currentPage = 1;

  void _paginateProducts() {
    int endIndex = currentPage * itemsPerPage;
    // Use filteredProducts for pagination
    visibleProducts = filteredProducts.take(endIndex).toList();
    update(); // Notify the UI
  }

  void loadMore() {
    currentPage++;
    _paginateProducts();
  }

  // Call this method if filters are applied or changed
  void applyFilters(String query) {
    filteredProducts = ShoppingCache.products!.where((product) {
      final matchesQuery =
          product.name.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = selectedChoices.isEmpty ||
          selectedChoices.contains(product.category_name);
      final withinPriceRange = product.price >= selectedRange.start &&
          product.price <= selectedRange.end;
      return matchesQuery && matchesCategory && withinPriceRange;
    }).toList();

    // Reset pagination after filtering
    currentPage = 1;
    _paginateProducts();
  }
}
////////////////////////