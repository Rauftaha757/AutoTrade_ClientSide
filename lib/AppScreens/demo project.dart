

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black,
      body: ListView(
        children: [
          Center(
            child: Container(
                width: 350.w,
                height: 350.h,
                decoration: BoxDecoration(
                  color: Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(21.r),
                ),
                child:Column(
                  children: [

                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(21.r),topLeft: Radius.circular(21.r)),
                        child: Container(
                          width: 350.w,
                          height: 200.h,
                          child: Image.asset(
                            "assets/images/cr.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Honda Vessel",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("1cr 20 lacs",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(21.r)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_road_outlined,color: Colors.white,),
                              Text("354km",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),




                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(21.r)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.color_lens, color: Colors.white),
                              Text("Black",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),


                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(21.r)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.speed, color: Colors.white),
                              Text("1200cc",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),
                      ],)




                  ],
                )
            ),
          ),
          Center(
            child: Container(
                width: 350.w,
                height: 350.h,
                decoration: BoxDecoration(
                  color: Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(21.r),
                ),
                child:Column(
                  children: [

                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(21.r),topLeft: Radius.circular(21.r)),
                        child: Container(
                          width: 350.w,
                          height: 200.h,
                          child: Image.asset(
                            "assets/images/cr.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Honda Vessel",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("1cr 20 lacs",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(8.r),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(
                            height: 40.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(21.r)
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add_road_outlined,color: Colors.white,),
                                Text("354km",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                              ],
                            ),
                          ),




                          Container(
                            height: 40.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(21.r)
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.color_lens, color: Colors.white),
                                Text("Black",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                              ],
                            ),
                          ),


                          Container(
                            height: 40.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(21.r)
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.speed, color: Colors.white),
                                Text("1200cc",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                              ],
                            ),
                          ),
                        ],),
                    )




                  ],
                )
            ),
          ),



          Center(
            child: Container(
                width: 350.w,
                height: 350.h,
                decoration: BoxDecoration(
                  color: Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(21.r),
                ),
                child:Column(
                  children: [

                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(21.r),topLeft: Radius.circular(21.r)),
                        child: Container(
                          width: 350.w,
                          height: 200.h,
                          child: Image.asset(
                            "assets/images/cr.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Honda Vessel",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("1cr 20 lacs",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(21.r)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_road_outlined,color: Colors.white,),
                              Text("354km",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),




                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(21.r)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.color_lens, color: Colors.white),
                              Text("Black",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),


                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(21.r)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.speed, color: Colors.white),
                              Text("1200cc",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),
                      ],)




                  ],
                )
            ),
          ),
        ],
      )
    );
  }
}
