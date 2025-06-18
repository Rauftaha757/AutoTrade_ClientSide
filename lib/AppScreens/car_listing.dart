import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pakwheels/AppScreens/post_add_screen.dart';
import 'package:pakwheels/modelclasses/car_ad_model.dart';
import 'package:pakwheels/providers/Car_ad_provider.dart';
import 'package:provider/provider.dart';

import 'cardetails_page.dart';

class CarListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarListingPage();
  }
}

class _CarListingPage extends State<CarListingPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAds();
  }

  void fetchAds() async {
    await Provider.of<CarAdProvider>(context, listen: false).fetchAds(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final addlist = Provider.of<CarAdProvider>(context).ads;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),



    bottomNavigationBar: Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0), // ⬅ float it above bottom
    child: ClipRRect(
    borderRadius: BorderRadius.circular(25), // ⬅ rounded corners
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), //
    child: BottomAppBar(
    color: Colors.white.withOpacity(0.1), //
    shape: const CircularNotchedRectangle(), //
    notchMargin: 6.0,
    elevation: 0,
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Center(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      IconButton(
      icon: const Icon(Icons.home, color: Colors.white),
      onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>CarListingPage()));
      },
      ),
        Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishAdScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        )
      ,
        IconButton(
      icon: const Icon(Icons.person, color: Colors.white),
      onPressed: () {
      print("Profile clicked");
      },
      ),
      ],
      ),
    ),
    ),
    ),
    ),
    ),
    ),



      body: isLoading
              ? const Center(
            child: SpinKitWave(
              color: Colors.white,
              itemCount: 5,
              size: 35,
            ),
          )
              : addlist.isEmpty
              ? const Center(child: Text("No ads found"))
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: addlist.length,
              itemBuilder: (context, index) {
                final ad = addlist[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailspage(car: ad),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Container(
                      width: 350.w,
                      height: 350.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff1E1E1E),
                        borderRadius: BorderRadius.circular(21.r),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(21.r),
                              topLeft: Radius.circular(21.r),
                            ),
                            child: Container(
                              width: 350.w,
                              height: 200.h,
                              child: Image(
                                image: NetworkImage(ad.imageurl[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.only(top: 4.r, left: 10.r),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "${ad.company} ${ad.carname}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.sp,
                                  color: Color(0xFFF5F5F5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.r, left: 10.r),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "${ad.price}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Color(0xFFF5F5F5),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoTile(
                                  icon: Icons.add_road_outlined,
                                  text: "${ad.milage} Km",
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _buildInfoTile(
                                  icon: Icons.color_lens,
                                  text: ad.color.toUpperCase(),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _buildInfoTile(
                                  icon: Icons.speed,
                                  text: "${ad.enginecapacity}cc",
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

    );
  }

}
Widget _buildInfoTile({required IconData icon, required String text}) {
  return Container(
    height: 40.h,
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(21.r),
    ),
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 16.sp),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}
