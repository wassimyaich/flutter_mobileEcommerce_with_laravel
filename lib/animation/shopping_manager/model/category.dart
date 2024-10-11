import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Category {
  final int id;
  final String name;
  final String? photo; // Nullable field
  final String icon;
  final String? description; // Nullable field
  final int productCount;

  Category({
    required this.id,
    required this.name,
    this.photo,
    required this.icon,
    this.description,
    required this.productCount,
  });

  // Fetch category data from API
  static Future<List<Category>> getDummyList() async {
    final response = await getData();

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return getListFromJson(data);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<http.Response> getData() async {
    final url =
        'http://192.168.1.5:8000/api/categories'; // Replace with your API URL
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    // Debugging: Print the response body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  static Category fromJson(Map<String, dynamic> jsonObject) {
    return Category(
      id: jsonObject['id'],
      name: jsonObject['name'],
      photo: jsonObject['photo'],
      icon: jsonObject['icon'],
      description: jsonObject['description'],
      productCount: jsonObject['product_count'],
    );
  }

  static List<Category> getListFromJson(List<dynamic> jsonArray) {
    return jsonArray.map((json) => Category.fromJson(json)).toList();
  }
}
