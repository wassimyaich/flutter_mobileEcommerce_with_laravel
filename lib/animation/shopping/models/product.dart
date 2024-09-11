import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutkit/helpers/extensions/string.dart'; // Import for your custom extensions
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  String name, image, description, category_name;
  double price, rating;
  int review, quantity, id;
  Color color;
  bool favorite;

  Product(
      this.id,
      this.name,
      this.image,
      this.description,
      this.rating,
      this.price,
      this.review,
      this.quantity,
      this.color,
      this.favorite,
      this.category_name);

// Base URL for images
  static const String baseUrls =
      'http://192.168.137.146:8000/storage/'; // Update this URL if necessary
  // Getter to construct the full URL for the image
  String get imageUrls => '$baseUrls$image';

  // Fetch a list of dummy products
  static Future<List<Product>> getDummyList() async {
    try {
      final response = await getData();
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        print('Decoded Data: $data'); // Print the decoded data
        return getListFromJson(data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e'); // Print any errors that occur
      return [];
    }
  }

  // Fetch a single product
  static Future<Product> getOne() async {
    return (await getDummyList())[0];
  }

  // Convert JSON object to Product instance
  static Product fromJson(Map<String, dynamic> jsonObject) {
    int id = _parseInt(jsonObject['id']);
    String name = jsonObject['name'].toString();
    String image = jsonObject['image'].toString();
    String description = jsonObject['description'].toString();

    double rating =
        jsonObject['rating'] != null ? _parseDouble(jsonObject['rating']) : 0.0;
    double price =
        jsonObject['price'] != null ? _parseDouble(jsonObject['price']) : 0.0;

    int review = _parseInt(jsonObject['review']);
    int quantity = _parseInt(jsonObject['quantity']);
    Color color = jsonObject['color'] != null
        ? jsonObject['color'].toString().toColor
        : Colors.grey; // Default color if not provided
    bool favorite = jsonObject['favorite'].toString().toBool();
    String category_name = jsonObject['category_name'].toString();

    return Product(id, name, image, description, rating, price, review,
        quantity, color, favorite, category_name);
  }

  // Helper to parse integers
  static int _parseInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) {
      return defaultValue;
    }
    try {
      return int.parse(value.toString());
    } catch (e) {
      print('Error parsing int: $value, Error: $e');
      return defaultValue;
    }
  }

  // Helper to parse doubles
  static double _parseDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value == null) {
      return defaultValue;
    }
    try {
      return double.parse(value.toString());
    } catch (e) {
      print('Error parsing double: $value, Error: $e');
      return defaultValue;
    }
  }

  // Helper to parse booleans
  static bool _parseBool(dynamic value) {
    return value.toString().toLowerCase() == 'true';
  }

  // Base URL for images
  static const String baseUrl =
      'http://192.168.137.146:8000/storage/'; // Update this URL if necessary

  // Getter to construct the full URL for the image
  String get imageUrl => '$baseUrl$image';

  // Convert JSON array to list of products
  static List<Product> getListFromJson(List<dynamic> jsonArray) {
    List<Product> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Product.fromJson(jsonArray[i]));
    }
    return list;
  }

  // Fetch product data from API
  static Future<http.Response> getData() async {
    final url =
        // 'http://192.168.137.146:8000/api/products'; // Replace with your API URL
        'http://192.168.137.146:8000/api/products'; // Replace with your API URL

    // Retrieve the Bearer token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Set up headers
    final headers = {
      'Authorization': 'Bearer $token', // Include the Bearer token
      'Accept': 'application/json', // Specify the expected response format
    };
    print('Request headers: $headers');

    // Make the GET request with the headers
    final response = await http.get(Uri.parse(url), headers: headers);
    print(
        'Response status: ${response.statusCode}'); // Print the response status
    return response;
  }
}
