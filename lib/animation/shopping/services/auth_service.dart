import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  final String baseUrl =
      // 'http://192.168.137.146:8000/api'; // Replace with your Laravel API URL

      'http://192.168.137.146:8000/api'; // Replace with your Laravel API URL

  Future<Map<String, dynamic>?> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return {
        'user': User.fromJson(data['user']),
        'token': data['token'], // Include the token in the response
      };
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Email: $email');
      print('Password: $password');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to login');
    }
  }
}
