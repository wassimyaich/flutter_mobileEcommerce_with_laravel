import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutkit/animation/shopping_manager/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  var nameTE = TextEditingController().obs;
  var descriptionTE = TextEditingController().obs;
  var priceTE = TextEditingController().obs;
  var quantity = 1.obs;
  var selectedCategory = Rxn<Category>();
  var categories = <Category>[].obs;
  var agreementChecked = false.obs;
  File? selectedImage;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      var categoryList = await Category.getDummyList();
      categories.value = categoryList;
      if (categoryList.isNotEmpty) {
        selectedCategory.value =
            categoryList[0]; // Default to the first category
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void updateProductImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        update(); // Notify listeners about the image change
      } else {
        print('No image picked');
      }
    } catch (error) {
      print('Error picking image: $error');
    }
  }

  Future<void> addProduct() async {
    if (selectedImage == null || selectedCategory.value == null) {
      print('No image or category selected for upload');
      return;
    }

    // final url = 'http://192.168.1.5:8000/api/admin/products';
    final url = 'http://192.168.1.5:8000/api/admin/products';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields['name'] = nameTE.value.text
        ..fields['description'] = descriptionTE.value.text
        ..fields['price'] = priceTE.value.text
        ..fields['quantity'] = quantity.value.toString()
        ..fields['category_id'] =
            selectedCategory.value!.id.toString(); // Use the id here

      // Add the image file to the request
      request.files
          .add(await http.MultipartFile.fromPath('image', selectedImage!.path));

      print('Sending request to $url with product details');

      final response = await request.send();
      if (response.statusCode == 200) {
        print('Product added successfully');
        resetFields();
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Error adding product: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (error) {
      print('Error during product upload: $error');
    }
  }

  void resetFields() {
    nameTE.value.clear();
    descriptionTE.value.clear();
    priceTE.value.clear();
    quantity.value = 1;
    selectedImage = null; // Reset the selected image
    selectedCategory.value = null; // Reset selected category
    update(); // Notify listeners about the changes
  }

  void increaseQuan() {
    quantity.value++;
    update();
  }

  void decreaseQuan() {
    if (quantity.value > 1) {
      quantity.value--;
      update();
    }
  }

  bool isQuanDecreable() {
    return quantity.value > 1;
  }
}
