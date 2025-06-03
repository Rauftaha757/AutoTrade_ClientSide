import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/User_Provider.dart';

class ApiServices {
  // static String baseurl = "http://10.0.2.2:3000"; // ✅ Correct for emulator
  static String baseurl = "http://192.168.18.62:3000";

  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    final url = Uri.parse("$baseurl/api/signup");
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
        "message": jsonDecode(response.body)['message'] ?? "Signup failed"
      };
    }
  }

  Future<Map<String, dynamic>> signin(BuildContext context, String email, String password) async {
    final url = Uri.parse('$baseurl/api/signin');

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
      Provider.of<UserProvider>(context, listen: false).setUserFromJson(data);
      return data;
    } else {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'] ?? "Signing failed",
      };
    }
  }

}
