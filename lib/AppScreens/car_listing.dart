import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pakwheels/modelclasses/car_ad_model.dart';
import 'package:pakwheels/providers/Car_ad_provider.dart';
import 'package:provider/provider.dart';

import 'cardetails page.dart';

class CarListingPage extends StatefulWidget{
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
  Widget build(BuildContext context) {
    final addlist = Provider.of<CarAdProvider>(context).ads;

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: isLoading
          ? Center(child: SpinKitWave(
        color: Colors.white,
        itemCount: 5,
        size: 35,
      ))
          : addlist.isEmpty
          ? Center(child: Text("No ads found"))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemCount: addlist.length,itemBuilder: (context,index){
          final ad= addlist[index];
          return   GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detailspage(car: ad),
                ),
              );
            },
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
                          child: Image(image: NetworkImage(ad.imageurl[0]),   fit: BoxFit.cover,)
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
                          child: Text("${ad.company} ${ad.carname}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22.sp,color: Color(0xFFF5F5F5),
                          ),)),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4.r,left: 10.r),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("${ad.price}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Color(0xFFF5F5F5),
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
                              Text("${ad.milage}Km",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
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
                              Text("${ad.color.toUpperCase()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),

                        //
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
                              Text("${ad.enginecapacity}cc",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.white)),
                            ],
                          ),
                        ),
                      ],)




                  ],
                )
            ),
          );
        }),
      ),
    );
  }
}
