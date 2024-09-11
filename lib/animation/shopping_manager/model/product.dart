import 'dart:convert';

import 'package:flutkit/helpers/extensions/extensions.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final String name, image, description;
  final double price, rating;
  final int ratingCount, quantity, id;

  Product(this.id, this.name, this.description, this.image, this.price,
      this.rating, this.ratingCount, this.quantity);
// Base URL for images
  static const String baseUrl =
      'http://192.168.137.146:8000/storage/'; // Update this URL if necessary
  // Getter to construct the full URL for the image
  String get imageUrl => '$baseUrl$image';
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

  static Future<Product> getOne() async {
    return (await getDummyList())[0];
  }

  static Future<Product> fromJson(Map<String, dynamic> jsonObject) async {
    int id = jsonObject['id'] as int; // Extract the id from the JSON
    String name = jsonObject['name'].toString();
    String image = jsonObject['image'].toString();
    String description = jsonObject['description'].toString();

    double price = jsonObject['price'].toString().toDouble(0);
    double rating = jsonObject['rating'].toString().toDouble(0);

    int ratingCount = jsonObject['rating_count'].toString().toInt(0);
    int quantity = jsonObject['quantity'].toString().toInt(0);

    return Product(
        id, name, description, image, price, rating, ratingCount, quantity);
  }

  static Future<List<String>> getImages(List<dynamic> jsonArray) async {
    List<String> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(jsonArray[i]);
    }
    return list;
  }

  static Future<List<Product>> getListFromJson(List<dynamic> jsonArray) async {
    List<Product> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      print('Creating Product from: ${jsonArray[i]}');
      list.add(await Product.fromJson(jsonArray[i]));
    }
    print('Total Products Created: ${list.length}');
    return list;
  }

  static Future<http.Response> getData() async {
    final url =
        'http://192.168.137.146:8000/api/admin/products'; // Replace with your API URL

    // Retrieve the Bearer token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Set up headers
    final headers = {
      'Authorization': 'Bearer $token', // Include the Bearer token
      'Accept':
          'application/json', // Optional: specify the expected response format
    };
    print('Request headers: $headers');
    // Make the GET request with the headers
    final response = await http.get(Uri.parse(url), headers: headers);
    print(
        'Response status: ${response.statusCode}'); // Print the response status
    return response;
  }
}
