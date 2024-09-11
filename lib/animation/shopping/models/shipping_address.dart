////////////////////////////////
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutkit/animation/shopping/models/cart.dart';

class ShippingAddress {
  int id;
  String name;
  String phone;
  String email;
  String address;
  String paymentMethod;
  List<Map<String, dynamic>> items;
  bool isDefault;
  ShippingAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.paymentMethod,
    required this.items,
    required this.isDefault,
  });
/////////////////////////////////////

/////////////////////

  // Fetch shipping addresses from the API
  static Future<List<ShippingAddress>> fetchShippingAddresses() async {
    final response =
        await http.get(Uri.parse('http://your-api-url/api/shipping-addresses'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<ShippingAddress> addresses = [];

      // Map API data to ShippingAddress objects
      for (var data in jsonResponse) {
        addresses.add(ShippingAddress(
          id: data['id'],
          name: data['name'],
          phone: data['phone'],
          email: data['email'],
          address: data['address'],
          paymentMethod: data['payment_method'],
          isDefault: true,
          items: [],
        ));
      }
      return addresses;
    } else {
      throw Exception('Failed to load shipping addresses');
    }
  }

  static Future<ShippingAddress> createShippingAddress(
    String phone,
    String address,
    String paymentMethod,
  ) async {
    // Retrieve user information from Shared Preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userName = preferences.getString('name') ?? 'Unknown';
    String? userEmail = preferences.getString('email') ?? 'unknown@example.com';
    String? token = preferences.getString('token') ?? '';
    List<Map<String, dynamic>> items = await Cart.getCartItems();
    print("Items to be sent with shipping address: $items"); // Debugging print

    final response = await http.post(
      Uri.parse('http://192.168.137.146:8000/api/shipping-addresses'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': userName,
        'phone': phone,
        'email': userEmail,
        'address': address,
        'payment_method': paymentMethod,
        'items': items,
      }),
    );
    print(
        "Create shipping address response: ${response.body}"); // Debugging print

    if (response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      return ShippingAddress(
        id: data['id'],
        name: data['name'],
        phone: data['phone'],
        email: data['email'],
        address: data['address'],
        paymentMethod: data['payment_method'],
        isDefault: true,
        items: items,
      );
    } else {
      throw Exception('Failed to create shipping address');
    }
  }

  // Update an existing shipping address using name and email from Shared Preferences
  Future<void> updateShippingAddress({
    String? phone,
    String? address,
    String? paymentMethod,
  }) async {
    // Retrieve user information from Shared Preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userName = preferences.getString('name') ?? 'Unknown';
    String? userEmail = preferences.getString('email') ?? 'unknown@example.com';

    final response = await http.put(
      Uri.parse('http://your-api-url/api/shipping-addresses/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': userName,
        'phone': phone,
        'email': userEmail,
        'address': address,
        'payment_method': paymentMethod,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update shipping address');
    }
  }

  // Delete a shipping address
  Future<void> deleteShippingAddress() async {
    final response = await http.delete(
      Uri.parse('http://your-api-url/api/shipping-addresses/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete shipping address');
    }
  }
}
