import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakwheels/AppScreens/Intro_Page.dart';
import 'package:pakwheels/services/Api_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'SignUp.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading=false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
ApiServices apiServices=ApiServices();
  void signin(BuildContext context, String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        setState(() {
          isloading = true;
        });
        var result = await apiServices.signin(context, email, password);

        setState(() {
          isloading = false;
        });

        if (result['error'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error in logging in")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Logged in successfully")));
        }
      }
    } catch (err) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())));
      print(err.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  bool obsess=false;
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
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroPage()));
            },
            child: Icon(
              Icons.arrow_back, // left arrow icon
              size: 30.sp,       // responsive size
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          child: Text("Welcome back!\nGlad to see you,\nAgain",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 30.sp),),
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
                  hintText: 'Enter your email',
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
                hintText: 'Enter your Password',
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
    Padding(
    
    padding:  EdgeInsets.only(right: 20.w,top: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Forget Password",style: TextStyle(color: Colors.black,fontSize:15.sp ))
      ],
    ),
    ),
    SizedBox(
    height: 50.h,
    ),
    Center(
    child: SizedBox(
      height: 55.h,
      width: 330.w,
   child:    ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF475C4B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
        onPressed: () {
          signin(context, emailController.text, passwordController.text);
        },
        child: isloading
            ? SpinKitWave(
          color: Colors.white,
          size: 25.0,
          itemCount: 4,
        )
            : Text("Login", style: TextStyle(color: Colors.white, fontSize: 20.sp)),
      ),
    
    ),
    ),
      SizedBox(
        height: 20.h,
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
            child: Text("Or Login with ",style: TextStyle(color: Colors.grey,fontSize:16.sp )),
          ),
          Container(
            height: 1.h,
            color: Colors.white,
            child: Text("-------------"),
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
