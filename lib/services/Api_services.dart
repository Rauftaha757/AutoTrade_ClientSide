import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/User_Provider.dart';

class ApiServices {
  final storage = FlutterSecureStorage();
  static final baseurl = "https://autotradeserverside-production-2eba.up.railway.app";
  /// Signup API
  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    final url = Uri.parse("$baseurl/api/signup");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": true,
          "message": jsonDecode(response.body)['message'] ?? "Signup failed",
        };
      }
    } catch (e) {
      return {
        "error": true,
        "message": "Network or server error",
      };
    }
  }

  /// Signin API
  Future<Map<String, dynamic>> signin(BuildContext context, String email, String password) async {
    final url = Uri.parse('$baseurl/api/signin');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // Save JWT token securely
        await storage.write(key: "jwt_key", value: token);
        
        // Save user data securely for persistence
        await storage.write(key: "user_data", value: jsonEncode(data));

        // Save user in provider
        Provider.of<UserProvider>(context, listen: false).setUserFromJson(data);

        return data;
      } else {
        return {
          "error": true,
          "message": jsonDecode(response.body)['message'] ?? "Signin failed",
        };
      }
    } catch (e) {
      return {
        "error": true,
        "message": "Network or server error",
      };
    }
  }

  /// Check if user is logged in (without server verification)
  Future<bool> isLoggedIn(BuildContext context) async {
    final token = await storage.read(key: "jwt_key");
    if (token == null) return false;

    // If token exists, consider user logged in
    // You can add basic token validation here if needed
    try {
      // Basic check - if token exists and is not empty
      if (token.isNotEmpty) {
        return true;
      } else {
        await logout();
        return false;
      }
    } catch (e) {
      await logout();
      return false;
    }
  }

  /// Logout - clears secure token and user data
  Future<void> logout() async {
    await storage.delete(key: "jwt_key");
    await storage.delete(key: "user_data");
  }
}
