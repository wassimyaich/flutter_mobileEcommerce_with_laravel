// import 'dart:convert';

// import 'package:flutkit/animation/shopping/models/product.dart';
// import 'package:flutkit/helpers/extensions/extensions.dart';
// import 'package:flutter/services.dart';

// class Cart {
//   Product product;
//   String selectedSize;
//   int quantity;
//   Color selectedColor;

//   Cart(this.product, this.selectedSize, this.quantity, this.selectedColor);

//   static Future<List<Cart>> getDummyList() async {
//     dynamic data = json.decode(await getData());
//     return getListFromJson(data);
//   }

//   static Future<Cart> getOne() async {
//     return (await getDummyList())[0];
//   }

//   static Future<Cart> fromJson(Map<String, dynamic> jsonObject) async {
//     Product product = Product.fromJson(jsonObject['product']);
//     String selectedSize = jsonObject['selectedSize'].toString();
//     int quantity = int.parse(jsonObject['quantity'].toString());
//     Color selectedColor = jsonObject['selectedColor'].toString().toColor;

//     return Cart(product, selectedSize, quantity, selectedColor);
//   }

//   static Future<List<Cart>> getListFromJson(List<dynamic> jsonArray) async {
//     List<Cart> list = [];
//     for (int i = 0; i < jsonArray.length; i++) {
//       list.add(await Cart.fromJson(jsonArray[i]));
//     }
//     return list;
//   }

//   static Future<String> getData() async {
//     return await rootBundle
//         .loadString('assets/full_apps/animations/shopping/data/cart.json');
//   }
// }
import 'dart:convert';
import 'dart:ui';
import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/helpers/extensions/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Cart {
  Product product;
  String selectedSize;
  int quantity;
  Color selectedColor;

  Cart(this.product, this.selectedSize, this.quantity, this.selectedColor);

  // Base URL for the API
  static const String apiUrl =
      // 'http://192.168.1.5:8000/api/carts'; // Update this URL if necessary
      'http://192.168.1.5:8000/api/carts'; // Update this URL if necessary

  static Future<List<Cart>> getDummyList() async {
    try {
      final response = await getData();
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        return getListFromJson(data);
      } else {
        throw Exception('Failed to load cart data');
      }
    } catch (e) {
      print('Error fetching cart data: $e'); // Print any errors that occur
      return [];
    }
  }

  static Future<Cart> getOne() async {
    return (await getDummyList())[0];
  }

  static Future<Cart> fromJson(Map<String, dynamic> jsonObject) async {
    Product product = Product.fromJson(jsonObject['product']);
    String selectedSize = jsonObject['selected_size'].toString();
    int quantity = int.parse(jsonObject['quantity'].toString());
    Color selectedColor = jsonObject['selected_color'].toString().toColor;

    return Cart(product, selectedSize, quantity, selectedColor);
  }

  static Future<List<Cart>> getListFromJson(List<dynamic> jsonArray) async {
    List<Cart> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(await Cart.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<http.Response> getData() async {
    // Retrieve the Bearer token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Set up headers
    final headers = {
      'Authorization': 'Bearer $token', // Include the Bearer token
      'Accept': 'application/json', // Specify the expected response format
    };

    // Make the GET request with the headers
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    return response;
  }
}
