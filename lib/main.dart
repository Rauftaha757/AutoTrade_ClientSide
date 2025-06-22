import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pakwheels/AppScreens/Intro_Page.dart';
import 'package:pakwheels/AppScreens/SignIn.dart';
import 'package:pakwheels/AppScreens/SignUp.dart';
import 'package:pakwheels/AppScreens/car_listing.dart';
import 'package:pakwheels/AppScreens/cardetails_page.dart';
import 'package:pakwheels/AppScreens/demo%20project.dart';
import 'package:pakwheels/providers/Car_ad_provider.dart';
import 'package:pakwheels/providers/User_Provider.dart';
import 'package:pakwheels/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CarAdProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          debugShowCheckedModeBanner: false,
          home: CarListingPage(),
        );
      },
    );
  }
}
