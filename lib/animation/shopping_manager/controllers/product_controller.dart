import 'package:flutkit/animation/shopping_manager/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:flutkit/animation/shopping_manager/views/products_screen.dart';
// import 'package:flutkit/animation/shopping_manager/views/full_app.dart';

class ProductController extends GetxController {
  final Product product;
  final TextEditingController nameTE = TextEditingController();
  final TextEditingController descriptionTE = TextEditingController();
  final TextEditingController priceTE = TextEditingController();
  int quantity = 0;
  bool agreementChecked = false;
  File? selectedImage;

  ProductController(this.product) {
    quantity = product.quantity;
  }

  @override
  void onInit() {
    super.onInit();
    nameTE.text = product.name;
    descriptionTE.text = product.description;
    priceTE.text = product.price.toString();
  }

  bool isQuanIncreasable() => true;

  bool isQuanDecreable() => quantity > 0;

  void increaseQuan() {
    quantity++;
    update();
  }

  void decreaseQuan() {
    if (isQuanDecreable()) {
      quantity--;
      update();
    }
  }

  void toggleAgreement() {
    agreementChecked = !agreementChecked;
    update();
  }

  void goBack() => Get.back();
  // void goBack() {
  //   Get.off(ProductsScreen());
  // }

  Future<void> updateProduct() async {
    final url = 'http://192.168.137.146:8000/api/admin/products/${product.id}';
    final body = {
      'name': nameTE.text,
      'description': descriptionTE.text,
      'price': priceTE.text,
      'quantity': quantity.toString(),
    };

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      if (selectedImage != null) {
        await uploadImage();
      }
      goBack();
      print('Product updated');
    } else {
      print('Error updating product: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> updateProductImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        update();
        await uploadImage();
      } else {
        print('No image picked');
      }
    } catch (error) {
      print('Error picking image: $error');
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage == null) {
      print('No image selected for upload');
      return;
    }

    final url =
        'http://192.168.137.146:8000/api/admin/products/${product.id}/image';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..files.add(
            await http.MultipartFile.fromPath('image', selectedImage!.path))
        ..headers.addAll(headers);

      print('Sending request to $url');

      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Error uploading image: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (error) {
      print('Error during upload: $error');
    }
  }
}
