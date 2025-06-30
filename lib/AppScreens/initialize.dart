import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pakwheels/AppScreens/SignIn.dart';
import 'package:pakwheels/AppScreens/car_listing.dart';
import 'package:provider/provider.dart';
import '../services/Api_services.dart';
import '../providers/User_Provider.dart';
import '../utils/page_routes.dart';
import 'dart:convert';

class InitialWrapper extends StatefulWidget {
  @override
  State<InitialWrapper> createState() => _InitialWrapperState();
}

class _InitialWrapperState extends State<InitialWrapper> {
  final storage = FlutterSecureStorage();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final api = ApiServices();
      final isLoggedIn = await api.isLoggedIn(context);

      if (!mounted) return;

      if (isLoggedIn) {
        // Try to restore user data from storage if available
        try {
          final userData = await storage.read(key: "user_data");
          if (userData != null) {
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.setUserFromJson(jsonDecode(userData));
          }
        } catch (e) {
          print('Error restoring user data: $e');
        }

        Navigator.pushReplacement(
          context,
          FadeRoute(page: CarListingPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          FadeRoute(page: LoginPage()),
        );
      }
    } catch (e) {
      print('Error checking login status: $e');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        FadeRoute(page: LoginPage()),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _loading 
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
                SizedBox(height: 16),
                Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          : Container(),
      ),
    );
  }
} 