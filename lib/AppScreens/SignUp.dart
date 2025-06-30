import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakwheels/AppScreens/SignIn.dart';
import 'package:pakwheels/services/Api_services.dart';
import 'package:pakwheels/utils/page_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isloading=false;
  bool obsess=false;
  ApiServices apiServices =ApiServices();
  void signup(String email, String password, String name) async {

    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
     setState(() {
       isloading=true;
     });
     final result = await apiServices.signup(name, email, password);

setState(() {
  isloading=false;
});

      if (result['error'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign up successfully")),
        );
     Navigator.push(context, SlideRightRoute(page: LoginPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Signup failed")),
        );
      }
    } else {
      print("Validation failed");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
    }
  }


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient:LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFFD8D6CF), // Darker top color
                    Color(0xFFCFCBC4), // Darker bottom color
                  ],
                )
            ),
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                    child: Icon(
                      Icons.arrow_back, // left arrow icon
                      size: 30.sp,       // responsive size
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                    child: Text("Hello! Register to get\nStarted",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 30.sp),),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(

                    padding:  EdgeInsets.all(8.h),
                    child:Center(
                      child: SizedBox(
                        width: 330.w,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(	Icons.person),
                            hintText: 'Name',
                            filled: true,
                            fillColor: Color(0xFFEDEDED), // dusky white
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide.none, // remove border
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide.none
                            ),
                          ),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),

                  ),

                  Padding(

                    padding:  EdgeInsets.all(8.h),
                    child:Center(
                      child: SizedBox(
                        width: 330.w,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            filled: true,
                            fillColor: Color(0xFFEDEDED), // dusky white
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide.none, // remove border
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide.none
                            ),
                          ),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: SizedBox(
                      width: 330.w,
                      child: TextField(
                        controller: passwordController,
                        obscuringCharacter: '*',
                        obscureText: obsess,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  obsess=!obsess;
                                });
                              },
                              child: Icon(Icons.visibility_sharp)),
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Color(0xFFEDEDED), // dusky white
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: BorderSide.none, // remove border
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide.none
                          ),
                        ),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: SizedBox(
                      height: 55.h,
                      width: 330.w,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF475C4B),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)
                          )
                      ),
                          onPressed: (){
                        signup(emailController.text, passwordController.text, nameController.text);
                          }, child: isloading
                            ? Transform.rotate(
                          angle: 0, // no rotation
                          child: SpinKitWave(
                            color: Colors.white,
                            size: 25.0,
                            itemCount: 4,
                          ),
                        )
                            : Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 20.sp)),

                      ),

                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 1.h,
                        color: Colors.white,
                        child: Text("-------------"),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.w),
                        child: Text("Or Register with ",style: TextStyle(color: Colors.grey,fontSize:16.sp )),
                      ),
                      Container(
                        height: 1.h,
                        color: Colors.white,
                        child: Text("--------"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color:  Color(0xFFEDEDED),
                        ),
                        child: Center(child: FaIcon(FontAwesomeIcons.google,size: 50,color: Colors.red,)),
                      ),

                      Container(
                        width: 100.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color:  Color(0xFFEDEDED),
                        ),
                        child: Center(child: FaIcon(FontAwesomeIcons.facebookSquare,size: 50,color: Colors.blue,)),
                      ),

                      Container(
                        width: 100.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color:  Color(0xFFEDEDED),
                        ),
                        child: Center(child: FaIcon(FontAwesomeIcons.apple,size:50,)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
