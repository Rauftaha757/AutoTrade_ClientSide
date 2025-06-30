import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pakwheels/AppScreens/post_add_screen.dart';
import 'package:pakwheels/modelclasses/car_ad_model.dart';
import 'package:pakwheels/providers/Car_ad_provider.dart';
import 'package:provider/provider.dart';
import 'package:pakwheels/services/CarAd_api.dart';
import 'package:pakwheels/services/Api_services.dart';
import 'package:pakwheels/AppScreens/SignIn.dart';
import 'package:pakwheels/utils/page_routes.dart';

import 'cardetails_page.dart';

class CarListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarListingPage();
  }
}

class _CarListingPage extends State<CarListingPage> {
  bool isLoading = true;
  bool isSearching = false;
  bool hasSearched = false;
  
  // Search controllers
  final TextEditingController _searchController = TextEditingController();
  String? selectedCompany;
  String? selectedCity;
  
  // Hardcoded lists
  final List<String> companies = [
    'Toyota', 'Honda', 'Suzuki', 'BMW', 'Mercedes', 'Audi', 
    'Nissan', 'Mitsubishi', 'Hyundai', 'Kia', 'Ford', 'Chevrolet'
  ];
  
  final List<String> cities = [
    'Karachi', 'Lahore', 'Islamabad', 'Rawalpindi', 'Faisalabad',
    'Multan', 'Peshawar', 'Quetta', 'Sialkot', 'Gujranwala'
  ];

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

  Future<void> performSearch() async {
    print("Search function called"); // Debug print
    print("Search text: ${_searchController.text}"); // Debug print
    print("Selected company: $selectedCompany"); // Debug print
    print("Selected city: $selectedCity"); // Debug print
    
    if (_searchController.text.isEmpty && selectedCompany == null && selectedCity == null) {
      print("No search criteria provided"); // Debug print
      return;
    }

    setState(() {
      isSearching = true;
      hasSearched = true;
    });

    try {
      print("Calling API with parameters:"); // Debug print
      print("name: ${_searchController.text.trim()}"); // Debug print
      print("company: $selectedCompany"); // Debug print
      print("city: $selectedCity"); // Debug print
      
      final results = await CarAd_apiservice.getcarbysearch(
        name: _searchController.text.trim(),
        company: selectedCompany,
        city: selectedCity,
        enginecapacity: null,
        context: context,
      );

      print("Search results count: ${results.length}"); // Debug print

      // Update the provider with search results
      Provider.of<CarAdProvider>(context, listen: false).setAds(results);
    } catch (e) {
      print("Search error: $e"); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isSearching = false;
      });
    }
  }

  void clearSearch() {
    _searchController.clear();
    setState(() {
      selectedCompany = null;
      selectedCity = null;
      hasSearched = false;
    });
    fetchAds(); // Reload all ads
  }

  @override
  Widget build(BuildContext context) {
    final addlist = Provider.of<CarAdProvider>(context).ads;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Column(
          children: [
            // Header Section with Logo, Back Arrow, and Person Info
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              color: Color(0xFF1E1E1E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Arrow
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                  ),
                  SizedBox(width: 12.w),
                  
                  // Logo Container
                  Container(
                    width: 200.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.asset(
                        'assets/images/logocar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  
                  // App Title
                  
                  // Person Info Icon
                  IconButton(
                    onPressed: () async {
                      // Show logout confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF2A2A2A),
                            title: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              "Are you sure you want to logout?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  // Perform logout
                                  final api = ApiServices();
                                  await api.logout();
                                  // Navigate to login page
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    FadeRoute(page: LoginPage()),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.person, color: Colors.white, size: 24.sp),
                  ),
                ],
              ),
            ),
            
            // Search Bar Section
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              color: Color(0xFF1E1E1E),
              child: Column(
                children: [
                  // Search Input
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Search car name...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      ),
                      onChanged: (value) {
                        print("Search text changed: $value"); // Debug print
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  
                  // Dropdowns Row
                  Row(
                    children: [
                      // Company Dropdown
                      Expanded(
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCompany,
                              hint: Text("    Company", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                              dropdownColor: Color(0xFF2A2A2A),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              items: companies.map((String company) {
                                return DropdownMenuItem<String>(
                                  value: company,
                                  child: Text(company),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCompany = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      
                      // City Dropdown
                      Expanded(
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCity,
                              hint: Text("   City", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                              dropdownColor: Color(0xFF2A2A2A),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              items: cities.map((String city) {
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(city),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCity = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  
                  // Search and Clear Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isSearching ? null : performSearch,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: isSearching
                              ? SizedBox(
                                  height: 16.h,
                                  width: 16.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      if (hasSearched)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: clearSearch,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[700],
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Car List Section
            Expanded(
              child: isLoading
                  ? Center(child: SpinKitWave(
                      color: Colors.white,
                      itemCount: 5,
                      size: 35,
                    ))
                  : addlist.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, color: Colors.grey, size: 64),
                              SizedBox(height: 16.h),
                              Text(
                                hasSearched ? "No cars found" : "No ads found",
                                style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 20.h),
                            itemCount: addlist.length,
                            itemBuilder: (context, index) {
                              final ad = addlist[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      ScaleRoute(page: Detailspage(car: ad)),
                                    );
                                  },
                                  child: Container(
                                    width: 350.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xff1E1E1E),
                                      borderRadius: BorderRadius.circular(21.r),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(21.r),
                                              topLeft: Radius.circular(21.r)
                                            ),
                                            child: Container(
                                              width: 350.w,
                                              height: 200.h,
                                              child: Image(
                                                image: NetworkImage(ad.imageurl[0]),
                                                fit: BoxFit.cover,
                                              )
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
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
                                        SizedBox(height: 16.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 8.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 40.h,
                                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius: BorderRadius.circular(21.r),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.add_road_outlined, color: Colors.white, size: 16.sp),
                                                      SizedBox(width: 4.w),
                                                      Expanded(
                                                        child: Text(
                                                          "${ad.milage}Km",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 40.h,
                                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius: BorderRadius.circular(21.r),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.color_lens, color: Colors.white, size: 16.sp),
                                                      SizedBox(width: 4.w),
                                                      Expanded(
                                                        child: Text(
                                                          "${ad.color.toUpperCase()}",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 40.h,
                                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius: BorderRadius.circular(21.r),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.speed, color: Colors.white, size: 16.sp),
                                                      SizedBox(width: 4.w),
                                                      Expanded(
                                                        child: Text(
                                                          "${ad.enginecapacity}cc",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 12.h),
                                      ],
                                    )
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: BottomAppBar(
                color: Colors.white.withOpacity(0.1),
                shape: const CircularNotchedRectangle(),
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
                            Navigator.push(context, SlideRightRoute(page: CarListingPage()));
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Navigator.push(context, SlideUpRoute(page: PublishAdScreen()));
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
                        ),
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
      ),
    );
  }
}
