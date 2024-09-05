import 'dart:convert';

import 'package:flutkit/helpers/extensions/extensions.dart';
import 'package:flutter/services.dart';

class Order {
  final int id;
  final String image, name;
  final double price;
  final int status;
  final DateTime date;

  Order(this.id, this.name, this.image, this.price, this.status, this.date);

  static Future<List<Order>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Order> getOne() async {
    return (await getDummyList())[0];
  }

  static Future<Order> fromJson(Map<String, dynamic> jsonObject) async {
    int id = jsonObject['id'].toString().toInt(0);
    String name = jsonObject['name'].toString();
    double price = jsonObject['price'].toString().toDouble(0);
    String image = jsonObject['image'].toString();
    int status = jsonObject['status'].toString().toInt(1);
    DateTime date = DateTime.parse(jsonObject['date'].toString());

    return Order(id, name, image, price, status, date);
  }

  static Future<List<String>> getImages(List<dynamic> jsonArray) async {
    List<String> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(jsonArray[i]);
    }
    return list;
  }

  static Future<List<Order>> getListFromJson(List<dynamic> jsonArray) async {
    List<Order> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(await Order.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString(
        'assets/full_apps/animations/shopping_manager/data/orders.json');
  }
}
