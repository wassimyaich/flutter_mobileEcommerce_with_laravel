// import 'package:flutter/material.dart';
// import 'package:flutkit/helpers/extensions/extensions.dart';

// class Category {
//   String name;
//   IconData icon;

//   Category(this.name, this.icon);

//   static List<Category> categoryList() {
//     List<Category> list = [];
//     list.add(Category("see_all".tr(), Icons.grid_view));
//     list.add(Category("furniture".tr(), Icons.chair));
//     list.add(Category("electricity".tr(), Icons.bolt));
//     list.add(Category("promo".tr(), Icons.local_offer));
//     list.add(Category("automotive".tr(), Icons.local_taxi));
//     list.add(Category("wallet".tr(), Icons.account_balance_wallet));
//     list.add(Category("gadget".tr(), Icons.devices_other));
//     list.add(Category("travel".tr(), Icons.flight));
//     return list;
//   }
// }
// import 'dart:convert';

// import 'package:flutter/services.dart';

// class Category {
//   String name, icon;

//   Category(this.name, this.icon);

//   static Future<List<Category>> getDummyList() async {
//     dynamic data = json.decode(await getData());
//     return getListFromJson(data);
//   }

//   static Future<Category> getOne() async {
//     return (await getDummyList())[0];
//   }

//   static Category fromJson(Map<String, dynamic> jsonObject) {
//     String name = jsonObject['name'].toString();
//     String icon = jsonObject['icon'].toString();

//     return Category(name, icon);
//   }

//   static List<Category> getListFromJson(List<dynamic> jsonArray) {
//     List<Category> list = [];
//     for (int i = 0; i < jsonArray.length; i++) {
//       list.add(Category.fromJson(jsonArray[i]));
//     }
//     return list;
//   }

//   static Future<String> getData() async {
//     return await rootBundle.loadString(
//         'assets/full_apps/animations/shopping/data/categories.json');
//   }
// }

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
