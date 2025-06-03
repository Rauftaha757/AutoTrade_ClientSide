import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pakwheels/services/CarAd_api.dart';
import 'package:permission_handler/permission_handler.dart';
import '../modelclasses/car_ad_model.dart';

class PublishAdScreen extends StatefulWidget {
  @override
  State<PublishAdScreen> createState() => _PublishAdScreenState();
}

class _PublishAdScreenState extends State<PublishAdScreen> {
  CarAd_apiservice ad_apiservice = CarAd_apiservice();
  bool isloading=false;

  final TextEditingController price = TextEditingController();
  final TextEditingController _carnameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _milageController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _engineCapacityController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  String transmition = 'Automatic';
  String registration = 'Registered';
  String assembly = 'Local';

  List<XFile> pickedImages = [];
  List<String> imageUrls = [];

  Future<void> pickImagesAndUpload() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      for (var image in images) {
        try {
          final ref = FirebaseStorage.instance
              .ref()
              .child('car_ads/${DateTime.now().millisecondsSinceEpoch}_${image.name}');

          if (kIsWeb) {
            final bytes = await image.readAsBytes();
            await ref.putData(bytes);
          } else {
            final file = File(image.path);
            await ref.putFile(file);
          }

          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        } catch (e) {
          print('Upload failed for ${image.name}: $e');
        }
      }
    } else {
      print('No images selected');
    }
  }

  void handleSubmit() async {

    await Permission.photos.request();
    if (imageUrls.isEmpty) {
      print('Image upload failed. Aborting post.');
      return;
    }
    final carAd = CarAd_model(
      price: price.text,
      imageurl: imageUrls,
      transmition: transmition,
      milage: int.parse(_milageController.text),
      model: int.parse(_modelController.text),
      registration: registration,
      carname: _carnameController.text,
      company: _companyController.text,
      enginecapacity: int.parse(_engineCapacityController.text),
      city: _cityController.text,
      color: _colorController.text,
      assembly: assembly,
      createdAt: DateTime.now(),
      contact: _contactController.text,
    );
    setState(() {

      isloading=true;
    });
    await CarAd_apiservice.publishad(context, carAd);
    setState(() {
      isloading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      "Create Ad",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Image Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 350.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21.r),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(21.r),
                          child: Image.asset(
                            "assets/images/cr.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8.w,
                        bottom: 8.h,
                        child: GestureDetector(
                          onTap: pickImagesAndUpload,
                          child: CircleAvatar(
                            radius: 22.r,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22.r),
                              child: Image.asset(
                                "assets/images/cam2.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Car Name
                Text(
                  "Car name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    controller: _carnameController,
                    style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: " eg: 116d Sport Line",
                      hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    ),
                    cursorColor: const Color(0xFFF5F5F5),
                  ),
                ),
                SizedBox(height: 12.h),

                // Final Price & Engine Capacity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Final Price", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: price,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "! cr 20 lac",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Engine Capacity(cc)", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _engineCapacityController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "2200",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Company & Contact
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Company name", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _companyController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "Toyota",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contact", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _contactController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "03123456789",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Mileage & Color
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mileage", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _milageController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "300000",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Color", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _colorController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "Black",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Model & City
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Model", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _modelController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "2021",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("City", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _cityController,
                              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
                              decoration: InputDecoration(
                                hintText: "Lahore",
                                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                              ),
                              cursorColor: const Color(0xFFF5F5F5),
                            ),
                          ),


                        ],

                      ),
                    ),
                  ],
                ),


                // Assembly Dropdown
                Text(
                  "Assembly",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1E1E1E),
                      value: assembly,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: TextStyle(
                        color: const Color(0xFFF5F5F5),
                        fontSize: 14.sp,
                      ),
                      items: ['Local', 'Imported']
                          .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          assembly = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                Text(
                  "Registration",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1E1E1E),
                      value: registration,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: TextStyle(
                        color: const Color(0xFFF5F5F5),
                        fontSize: 14.sp,
                      ),
                      items: ['Registered', 'Unregistered']
                          .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          registration = newValue!;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 6.h),
                Text(
                  "Transmition",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1E1E1E),
                      value: transmition,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: TextStyle(
                        color: const Color(0xFFF5F5F5),
                        fontSize: 14.sp,
                      ),
                      items: ['Automatic', 'Manual']
                          .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          transmition = newValue!;
                        });
                      },
                    ),
                  ),
                ),


                SizedBox(height: 25.h),

                // Publish Button
                GestureDetector(
                  onTap: (){
handleSubmit();
                  },
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: 55.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.yellow,
                      ),
                      child: Center(
                        child: isloading ? SpinKitWave(
                          color: Colors.black,
                          itemCount: 5,
                          size: 30,
                        ) : Text(
                          "Publish ad  >>",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
